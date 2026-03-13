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

Describe 'Get-AwtrixStats' {

    BeforeAll {
        Mock Invoke-RestMethod {
            [PSCustomObject]@{ bat = 100; ram = 50000; uptime = 3600 }
        } -ModuleName awtrix
    }

    It 'Calls the stats endpoint with GET' {
        Get-AwtrixStats
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/stats' -and $Method -eq 'GET'
        }
    }

    It 'Returns stats object' {
        $result = Get-AwtrixStats
        $result.bat | Should -Be 100
    }

    It 'Uses -BaseUri override when provided' {
        Get-AwtrixStats -BaseUri '10.0.0.5'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://10.0.0.5/api/stats'
        }
    }
}
