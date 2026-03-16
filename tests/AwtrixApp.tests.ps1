BeforeAll {
    if ($null -eq $env:BHPSModuleManifest) {
        & "$PSScriptRoot/../Build.ps1" -Task Init
    }
    $manifest = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
    $outputDir = Join-Path -Path $env:BHProjectPath -ChildPath 'Output'
    $outputModDir = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
    $outputModVerDir = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion
    $outputModVerManifest = Join-Path -Path $outputModVerDir -ChildPath "$($env:BHProjectName).psd1"

    Get-Module $env:BHProjectName | Remove-Module -Force -ErrorAction Ignore
    Import-Module -Name $outputModVerManifest -Verbose:$false -ErrorAction Stop

    & (Get-Module $env:BHProjectName) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'AwtrixApp class' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    Context 'Construction' {

        It 'Creates an empty instance' {
            $app = [AwtrixApp]::new()
            $app | Should -Not -BeNullOrEmpty
            $app.Name | Should -BeNullOrEmpty
        }

        It 'Accepts a name via the constructor overload' {
            $app = [AwtrixApp]::new('myapp')
            $app.Name | Should -Be 'myapp'
        }

        It 'All base properties default to null' {
            $app = [AwtrixApp]::new()
            $app.Text             | Should -BeNullOrEmpty
            $app.Color            | Should -BeNullOrEmpty
            $app.Icon             | Should -BeNullOrEmpty
            $app.DurationSeconds  | Should -BeNullOrEmpty
            $app.LifetimeSeconds  | Should -BeNullOrEmpty
        }
    }

    Context 'ToPayload' {

        It 'Returns an empty hashtable when no properties are set' {
            $app = [AwtrixApp]::new()
            $app.ToPayload().Count | Should -Be 0
        }

        It 'Maps Text to "text"' {
            $app = [AwtrixApp]::new()
            $app.Text = 'Hello'
            $app.ToPayload()['text'] | Should -Be 'Hello'
        }

        It 'Maps Color to "color"' {
            $app = [AwtrixApp]::new()
            $app.Color = '#FF0000'
            $app.ToPayload()['color'] | Should -Be '#FF0000'
        }

        It 'Maps DurationSeconds to "duration"' {
            $app = [AwtrixApp]::new()
            $app.DurationSeconds = 10
            $app.ToPayload()['duration'] | Should -Be 10
        }

        It 'Maps LifetimeSeconds to "lifetime"' {
            $app = [AwtrixApp]::new()
            $app.LifetimeSeconds = 300
            $app.ToPayload()['lifetime'] | Should -Be 300
        }

        It 'Maps LifetimeMode to "lifetimeMode"' {
            $app = [AwtrixApp]::new()
            $app.LifetimeMode = 1
            $app.ToPayload()['lifetimeMode'] | Should -Be 1
        }

        It 'Maps Position to "pos"' {
            $app = [AwtrixApp]::new()
            $app.Position = 2
            $app.ToPayload()['pos'] | Should -Be 2
        }

        It 'Maps Save to "save"' {
            $app = [AwtrixApp]::new()
            $app.Save = $true
            $app.ToPayload()['save'] | Should -Be $true
        }

        It 'Maps BlinkTextMilliseconds to "blinkText"' {
            $app = [AwtrixApp]::new()
            $app.BlinkTextMilliseconds = 500
            $app.ToPayload()['blinkText'] | Should -Be 500
        }

        It 'Maps Progress to "progress"' {
            $app = [AwtrixApp]::new()
            $app.Progress = 75
            $app.ToPayload()['progress'] | Should -Be 75
        }

        It 'Maps Overlay to "overlay"' {
            $app = [AwtrixApp]::new()
            $app.Overlay = 'snow'
            $app.ToPayload()['overlay'] | Should -Be 'snow'
        }

        It 'Maps NoScroll to "noScroll"' {
            $app = [AwtrixApp]::new()
            $app.NoScroll = $true
            $app.ToPayload()['noScroll'] | Should -Be $true
        }

        It 'Maps Rainbow to "rainbow"' {
            $app = [AwtrixApp]::new()
            $app.Rainbow = $true
            $app.ToPayload()['rainbow'] | Should -Be $true
        }

        It 'Maps Bar to "bar"' {
            $app = [AwtrixApp]::new()
            $app.Bar = @(1, 5, 3, 8)
            $app.ToPayload()['bar'] | Should -Be @(1, 5, 3, 8)
        }

        It 'Does not include null properties in payload' {
            $app = [AwtrixApp]::new()
            $app.Text = 'Hi'
            $payload = $app.ToPayload()
            $payload.ContainsKey('duration') | Should -Be $false
            $payload.ContainsKey('color')    | Should -Be $false
        }

        It 'Includes Effect empty string (API signal to remove effect)' {
            $app = [AwtrixApp]::new()
            $app.Effect = ''
            $app.ToPayload().ContainsKey('effect') | Should -Be $true
        }

        It 'Excludes empty string for non-Effect properties' {
            $app = [AwtrixApp]::new()
            $app.Icon = ''
            $app.ToPayload().ContainsKey('icon') | Should -Be $false
        }
    }

    Context 'ToJson and FromJson round-trip' {

        It 'Round-trips Name, Text, Color, and Duration' {
            $app = [AwtrixApp]::new('roundtrip')
            $app.Text            = 'Test'
            $app.Color           = '#00FF00'
            $app.DurationSeconds = 7

            $json     = $app.ToJson()
            $restored = [AwtrixApp]::FromJson($json)

            $restored.Name           | Should -Be 'roundtrip'
            $restored.Text           | Should -Be 'Test'
            $restored.Color          | Should -Be '#00FF00'
            $restored.DurationSeconds | Should -Be 7
        }

        It 'Round-trips app-only properties' {
            $app = [AwtrixApp]::new('lt')
            $app.LifetimeSeconds = 120
            $app.LifetimeMode    = 1
            $app.Position        = 3
            $app.Save            = $true

            $restored = [AwtrixApp]::FromJson($app.ToJson())

            $restored.LifetimeSeconds | Should -Be 120
            $restored.LifetimeMode    | Should -Be 1
            $restored.Position        | Should -Be 3
            $restored.Save            | Should -Be $true
        }
    }

    Context 'Clone' {

        It 'Returns a new AwtrixApp with the same properties' {
            $original = [AwtrixApp]::new('orig')
            $original.Text  = 'Hello'
            $original.Color = '#FF0000'

            $clone = $original.Clone('copy')
            $clone.Name  | Should -Be 'copy'
            $clone.Text  | Should -Be 'Hello'
            $clone.Color | Should -Be '#FF0000'
        }

        It 'Mutating the clone does not affect the original' {
            $original = [AwtrixApp]::new('orig')
            $original.Text = 'Hello'

            $clone      = $original.Clone('copy')
            $clone.Text = 'Changed'

            $original.Text | Should -Be 'Hello'
        }

        It 'Clone without argument keeps the same Name' {
            $original = [AwtrixApp]::new('same')
            $clone    = $original.Clone()
            $clone.Name | Should -Be 'same'
        }
    }

    Context 'Dirty Tracking' {

        It 'GetDirtyPayload returns full payload before any Push' {
            $app      = [AwtrixApp]::new('dirty')
            $app.Text = 'Initial'
            $dirty    = $app.GetDirtyPayload()
            $dirty['text'] | Should -Be 'Initial'
        }

        It 'GetDirtyPayload returns only changed keys after ResetDirtyState' {
            $app      = [AwtrixApp]::new('dirty')
            $app.Text = 'Initial'
            $app.ResetDirtyState()

            $app.Text  = 'Updated'
            $dirty     = $app.GetDirtyPayload()

            $dirty.ContainsKey('text')     | Should -Be $true
            $dirty.ContainsKey('duration') | Should -Be $false
        }

        It 'GetDirtyPayload returns empty when nothing changed since reset' {
            $app      = [AwtrixApp]::new('dirty')
            $app.Text = 'Same'
            $app.ResetDirtyState()

            $app.GetDirtyPayload().Count | Should -Be 0
        }

        It 'ResetDirtyState is called after Push' {
            $app      = [AwtrixApp]::new('dirty')
            $app.Text = 'First'
            $app.Push()

            $app.Text = 'Second'
            $dirty    = $app.GetDirtyPayload()

            $dirty.Keys | Should -Contain 'text'
            $dirty.Values | Should -Contain 'Second'
        }
    }

    Context 'Push' {

        It 'POSTs to custom endpoint with app name as query string' {
            $app      = [AwtrixApp]::new('pushtest')
            $app.Text = 'Hi'
            $app.Push()
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri    -eq 'http://192.168.1.100/api/custom?name=pushtest' -and
                $Method -eq 'POST'
            }
        }

        It 'Includes text in the POST body' {
            $app      = [AwtrixApp]::new('bodytest')
            $app.Text = 'Hello'
            $app.Push()
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                ($Body | ConvertFrom-Json).text -eq 'Hello'
            }
        }

        It 'DirtyOnly sends only changed properties' {
            $app      = [AwtrixApp]::new('dirtyonly')
            $app.Text = 'Init'
            $app.DurationSeconds = 5
            $app.Push()

            $app.Text = 'Updated'
            $app.Push($true)  # dirty only

            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $parsed = $Body | ConvertFrom-Json
                $parsed.text -eq 'Updated' -and $null -eq $parsed.duration
            }
        }

        It 'Throws when Name is not set' {
            $app = [AwtrixApp]::new()
            { $app.Push() } | Should -Throw '*Name must be set*'
        }
    }

    Context 'Remove' {

        It 'POSTs an empty body to the custom endpoint' {
            $app = [AwtrixApp]::new('removetest')
            $app.Remove()
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri    -eq 'http://192.168.1.100/api/custom?name=removetest' -and
                $Method -eq 'POST'
            }
        }

        It 'Throws when Name is not set' {
            { [AwtrixApp]::new().Remove() } | Should -Throw '*Name must be set*'
        }
    }

    Context 'SwitchTo' {

        It 'POSTs to switch endpoint with app name' {
            $app = [AwtrixApp]::new('switchtest')
            $app.SwitchTo()
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri  -eq 'http://192.168.1.100/api/switch' -and
                ($Body | ConvertFrom-Json).name -eq 'switchtest'
            }
        }
    }
}

Describe 'AwtrixNotification class' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    Context 'Construction' {

        It 'Creates an empty instance' {
            $n = [AwtrixNotification]::new()
            $n | Should -Not -BeNullOrEmpty
        }

        It 'Accepts initial text via constructor overload' {
            $n = [AwtrixNotification]::new('Alert!')
            $n.Text | Should -Be 'Alert!'
        }
    }

    Context 'ToPayload' {

        It 'Maps Hold to "hold"' {
            $n      = [AwtrixNotification]::new()
            $n.Hold = $true
            $n.ToPayload()['hold'] | Should -Be $true
        }

        It 'Maps Sound to "sound"' {
            $n       = [AwtrixNotification]::new()
            $n.Sound = 'alarm'
            $n.ToPayload()['sound'] | Should -Be 'alarm'
        }

        It 'Maps Rtttl to "rtttl"' {
            $n       = [AwtrixNotification]::new()
            $n.Rtttl = 'Scale:d=4,o=5,b=120:c,d,e,f'
            $n.ToPayload()['rtttl'] | Should -Be 'Scale:d=4,o=5,b=120:c,d,e,f'
        }

        It 'Maps Stack to "stack"' {
            $n       = [AwtrixNotification]::new()
            $n.Stack = $false
            $n.ToPayload()['stack'] | Should -Be $false
        }

        It 'Maps Wakeup to "wakeup"' {
            $n        = [AwtrixNotification]::new()
            $n.Wakeup = $true
            $n.ToPayload()['wakeup'] | Should -Be $true
        }

        It 'Maps Clients to "clients"' {
            $n         = [AwtrixNotification]::new()
            $n.Clients = @('10.0.0.2', '10.0.0.3')
            $payload   = $n.ToPayload()
            $payload['clients'].Count | Should -Be 2
        }

        It 'Does not include notification-only keys that are null' {
            $n    = [AwtrixNotification]::new()
            $n.Text = 'Hi'
            $payload = $n.ToPayload()
            $payload.ContainsKey('hold')  | Should -Be $false
            $payload.ContainsKey('sound') | Should -Be $false
        }
    }

    Context 'Send' {

        It 'POSTs to notify endpoint' {
            $n      = [AwtrixNotification]::new()
            $n.Text = 'Test'
            $n.Send()
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri    -eq 'http://192.168.1.100/api/notify' -and
                $Method -eq 'POST'
            }
        }

        It 'Includes text in the POST body' {
            $n      = [AwtrixNotification]::new()
            $n.Text = 'Hello'
            $n.Send()
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                ($Body | ConvertFrom-Json).text -eq 'Hello'
            }
        }
    }

    Context 'Clone' {

        It 'Produces an independent copy' {
            $original       = [AwtrixNotification]::new('Original')
            $original.Sound = 'alarm'
            $clone          = $original.Clone()
            $clone.Text     = 'Changed'
            $original.Text  | Should -Be 'Original'
        }
    }
}
