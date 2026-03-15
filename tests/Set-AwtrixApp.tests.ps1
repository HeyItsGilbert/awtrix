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

Describe 'Set-AwtrixApp' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends to custom endpoint with app name as query parameter' {
        Set-AwtrixApp -Name 'myapp' -Text 'Hello'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/custom?name=myapp' -and
            $Method -eq 'POST'
        }
    }

    It 'Includes text in payload' {
        Set-AwtrixApp -Name 'myapp' -Text 'Hello World'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).text -eq 'Hello World'
        }
    }

    It 'Includes rainbow flag in payload' {
        Set-AwtrixApp -Name 'myapp' -Text 'Hi' -Rainbow
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).rainbow -eq $true
        }
    }

    It 'Includes duration in payload' {
        Set-AwtrixApp -Name 'myapp' -Text 'Hi' -DurationSeconds 10
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).duration -eq 10
        }
    }

    It 'Includes icon in payload' {
        Set-AwtrixApp -Name 'myapp' -Text 'Temp' -Icon 'temperature'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).icon -eq 'temperature'
        }
    }

    It 'Includes bar chart data' {
        Set-AwtrixApp -Name 'chart' -Bar @(1, 5, 3, 8)
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.bar.Count -eq 4
        }
    }

    It 'Includes progress value' {
        Set-AwtrixApp -Name 'prog' -Progress 75
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).progress -eq 75
        }
    }

    It 'Includes scroll speed' {
        Set-AwtrixApp -Name 'myapp' -Text 'Fast' -ScrollSpeed 200
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).scrollSpeed -eq 200
        }
    }

    It 'Includes effect and overlay' {
        Set-AwtrixApp -Name 'myapp' -Effect 'Rainbow' -Overlay 'snow'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.effect -eq 'Rainbow' -and $parsed.overlay -eq 'snow'
        }
    }

    It 'Includes lifetime settings' {
        Set-AwtrixApp -Name 'myapp' -Text 'Hi' -LifetimeSeconds 300 -LifetimeMode 1
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.lifetime -eq 300 -and $parsed.lifetimeMode -eq 1
        }
    }

    It 'Does not include Name or BaseUri in payload' {
        Set-AwtrixApp -Name 'myapp' -Text 'Hello' -BaseUri '10.0.0.1'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $null -eq $parsed.Name -and $null -eq $parsed.BaseUri
        }
    }

    It 'Includes draw instructions' {
        $drawings = @(
            @{ dp = @(5, 3, '#FF0000') }
            @{ dt = @(0, 0, 'Hi', '#00FF00') }
        )
        Set-AwtrixApp -Name 'draw' -Draw $drawings
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).draw.Count -eq 2
        }
    }

    It '-PassThru returns an AwtrixApp object' {
        $result = Set-AwtrixApp -Name 'pt' -Text 'Hello' -PassThru
        $result | Should -BeOfType ([AwtrixApp])
    }

    It '-PassThru object has correct Name and properties' {
        $result = Set-AwtrixApp -Name 'ptprops' -Text 'World' -DurationSeconds 8 -PassThru
        $result.Name            | Should -Be 'ptprops'
        $result.Text            | Should -Be 'World'
        $result.DurationSeconds | Should -Be 8
    }

    It 'Returns nothing when -PassThru is omitted' {
        $result = Set-AwtrixApp -Name 'nopt' -Text 'Hi'
        $result | Should -BeNullOrEmpty
    }
}
