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

Describe 'Update-AwtrixApp' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Accepts an AwtrixApp from the pipeline and pushes it' {
        $app = New-AwtrixApp -Name 'uptest' -Text 'Before'
        $app | Update-AwtrixApp
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/custom?name=uptest' -and
            $Method -eq 'POST'
        }
    }

    It 'Updates a property on the object before pushing' {
        $app = New-AwtrixApp -Name 'textup' -Text 'Before'
        $app | Update-AwtrixApp -Text 'After'
        $app.Text | Should -Be 'After'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).text -eq 'After'
        }
    }

    It 'Updates multiple properties in one call' {
        $app = New-AwtrixApp -Name 'multi' -Text 'X'
        $app | Update-AwtrixApp -Text 'New' -Color '#00FF00' -DurationSeconds 15
        $app.Text            | Should -Be 'New'
        $app.Color           | Should -Be '#00FF00'
        $app.DurationSeconds | Should -Be 15
    }

    It 'Converts switch parameters to bool on the object' {
        $app = New-AwtrixApp -Name 'sw'
        $app | Update-AwtrixApp -Rainbow
        $app.Rainbow | Should -Be $true
    }

    It '-DirtyOnly sends only changed properties' {
        $app      = New-AwtrixApp -Name 'donly' -Text 'Init' -DurationSeconds 5
        $app.Push()        # snapshot clean state

        $app | Update-AwtrixApp -Text 'Changed' -DirtyOnly

        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.text -eq 'Changed' -and $null -eq $parsed.duration
        }
    }

    It '-PassThru returns the mutated AwtrixApp object' {
        $app    = New-AwtrixApp -Name 'pt' -Text 'Before'
        $result = $app | Update-AwtrixApp -Text 'After' -PassThru
        $result | Should -BeOfType ([AwtrixApp])
        $result.Text | Should -Be 'After'
    }

    It '-PassThru returns the same object reference (mutates in place)' {
        $app    = New-AwtrixApp -Name 'ref' -Text 'X'
        $result = $app | Update-AwtrixApp -Text 'Y' -PassThru
        # Same object — they're the identical reference
        [object]::ReferenceEquals($app, $result) | Should -Be $true
    }

    It 'Handles multiple pipeline objects' {
        $a = New-AwtrixApp -Name 'batch1' -Text 'A'
        $b = New-AwtrixApp -Name 'batch2' -Text 'B'
        @($a, $b) | Update-AwtrixApp -DurationSeconds 3
        $a.DurationSeconds | Should -Be 3
        $b.DurationSeconds | Should -Be 3
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -Exactly -Times 2
    }
}
