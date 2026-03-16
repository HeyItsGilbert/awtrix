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

Describe 'New-AwtrixApp' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Returns an [AwtrixApp] object' {
        $app = New-AwtrixApp -Name 'test'
        $app | Should -BeOfType ([AwtrixApp])
    }

    It 'Sets Name from parameter' {
        $app = New-AwtrixApp -Name 'myapp'
        $app.Name | Should -Be 'myapp'
    }

    It 'Sets Text and Color from parameters' {
        $app = New-AwtrixApp -Name 'test' -Text 'Hello' -Color '#FF0000'
        $app.Text | Should -Be 'Hello'
        $app.Color | Should -Be '#FF0000'
    }

    It 'Converts switch parameters to bool on the object' {
        $app = New-AwtrixApp -Name 'test' -Rainbow -NoScroll
        $app.Rainbow | Should -Be $true
        $app.NoScroll | Should -Be $true
    }

    It 'Does not push to device when -Push is omitted' {
        New-AwtrixApp -Name 'nopush' -Text 'Hi'
        Should -Not -Invoke Invoke-RestMethod -ModuleName awtrix
    }

    It 'Pushes to device when -Push is specified' {
        New-AwtrixApp -Name 'dopush' -Text 'Hi' -Push
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/custom?name=dopush' -and
            $Method -eq 'POST'
        }
    }

    It 'Includes all specified properties in the pushed payload' {
        New-AwtrixApp -Name 'props' -Text 'Test' -DurationSeconds 10 -Icon 'info' -Push
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.text -eq 'Test' -and $parsed.duration -eq 10 -and $parsed.icon -eq 'info'
        }
    }

    It 'Accepts a named color and transforms it to hex' {
        $app = New-AwtrixApp -Name 'c' -Color Red
        $app.Color | Should -Be '#FF0000'
    }

    It 'Accepts an RGB array color' {
        $app = New-AwtrixApp -Name 'c' -Color @(255, 128, 0)
        $colors = $app.Color
        $colors[0] | Should -Be 255
        $colors[1] | Should -Be 128
        $colors[2] | Should -Be 0
    }

    It 'Returns an object that can be pushed later' {
        $app = New-AwtrixApp -Name 'late' -Text 'Later'
        $app.Text = 'Modified'
        $app.Push()
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).text -eq 'Modified'
        }
    }

    It 'Sets LifetimeSeconds and LifetimeMode' {
        $app = New-AwtrixApp -Name 'lt' -LifetimeSeconds 300 -LifetimeMode 1
        $app.LifetimeSeconds | Should -Be 300
        $app.LifetimeMode | Should -Be 1
    }

    It 'Does not include Name or BaseUri in the pushed payload' {
        New-AwtrixApp -Name 'sanity' -Text 'Hi' -BaseUri 'http://10.0.0.1' -Push
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $null -eq $parsed.Name -and $null -eq $parsed.BaseUri -and $null -eq $parsed.Push
        }
    }
}

Describe 'New-AwtrixNotification' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Returns an [AwtrixNotification] object' {
        $n = New-AwtrixNotification -Text 'Alert!'
        $n | Should -BeOfType ([AwtrixNotification])
    }

    It 'Sets notification-specific properties' {
        $n = New-AwtrixNotification -Text 'Test' -Hold -Sound 'alarm' -Wakeup
        $n.Hold | Should -Be $true
        $n.Sound | Should -Be 'alarm'
        $n.Wakeup | Should -Be $true
    }

    It 'Does not send when -Send is omitted' {
        New-AwtrixNotification -Text 'Quiet'
        Should -Not -Invoke Invoke-RestMethod -ModuleName awtrix
    }

    It 'Sends to notify endpoint when -Send is specified' {
        New-AwtrixNotification -Text 'Alert!' -Send
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/notify' -and
            $Method -eq 'POST'
        }
    }
}

Describe 'New-AwtrixAppCollection' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Returns an [AwtrixAppCollection] object' {
        $p1 = New-AwtrixApp -Name 'p1' -Text 'Page1'
        $c = New-AwtrixAppCollection -BaseName 'dashboard' -Apps @($p1)
        $c | Should -BeOfType ([AwtrixAppCollection])
    }

    It 'Stores BaseName and Apps' {
        $p1 = New-AwtrixApp -Name 'p1' -Text 'A'
        $p2 = New-AwtrixApp -Name 'p2' -Text 'B'
        $c = New-AwtrixAppCollection -BaseName 'multi' -Apps @($p1, $p2)
        $c.BaseName | Should -Be 'multi'
        $c.Apps.Count | Should -Be 2
    }

    It 'Does not push when -Push is omitted' {
        $p1 = New-AwtrixApp -Name 'p1' -Text 'A'
        New-AwtrixAppCollection -BaseName 'x' -Apps @($p1)
        Should -Not -Invoke Invoke-RestMethod -ModuleName awtrix
    }

    It 'Pushes to device when -Push is specified' {
        $p1 = New-AwtrixApp -Name 'p1' -Text 'A'
        New-AwtrixAppCollection -BaseName 'col' -Apps @($p1) -Push
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/custom?name=col' -and
            $Method -eq 'POST'
        }
    }
}
