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
}

Describe 'Connect-Awtrix' {

    BeforeEach {
        # Reset module connection state
        & (Get-Module awtrix) { $script:AwtrixConnection = $null }
    }

    Context 'Successful connection' {

        BeforeAll {
            Mock Invoke-RestMethod {
                [PSCustomObject]@{ bat = 100; ram = 50000; uptime = 3600 }
            } -ModuleName awtrix
        }

        It 'Returns device stats' {
            $result = Connect-Awtrix -BaseUri '192.168.1.100'
            $result.bat | Should -Be 100
            $result.ram | Should -Be 50000
        }

        It 'Prepends http:// when no scheme is provided' {
            Connect-Awtrix -BaseUri '192.168.1.100'
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri -eq 'http://192.168.1.100/api/stats'
            }
        }

        It 'Uses existing http scheme as-is' {
            Connect-Awtrix -BaseUri 'http://awtrix.local'
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri -eq 'http://awtrix.local/api/stats'
            }
        }

        It 'Trims trailing slash from URI' {
            Connect-Awtrix -BaseUri 'http://192.168.1.100/'
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri -eq 'http://192.168.1.100/api/stats'
            }
        }

        It 'Stores connection in module scope' {
            Connect-Awtrix -BaseUri '192.168.1.100'
            $conn = & (Get-Module awtrix) { $script:AwtrixConnection }
            $conn.BaseUri | Should -Be 'http://192.168.1.100'
        }
    }

    Context 'Failed connection' {

        BeforeAll {
            Mock Invoke-RestMethod { throw 'Connection refused' } -ModuleName awtrix
        }

        It 'Throws when device is unreachable' {
            { Connect-Awtrix -BaseUri '10.0.0.1' } | Should -Throw '*Failed to connect*'
        }

        It 'Does not store connection on failure' {
            try { Connect-Awtrix -BaseUri '10.0.0.1' } catch {}
            $conn = & (Get-Module awtrix) { $script:AwtrixConnection }
            $conn | Should -BeNullOrEmpty
        }
    }
}
