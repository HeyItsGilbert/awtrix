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

Describe 'Switch-AwtrixApp' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    Context 'By name' {
        It 'Sends switch request with app name' {
            Switch-AwtrixApp -Name 'Time'
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri -eq 'http://192.168.1.100/api/switch' -and
                $Method -eq 'POST' -and
                ($Body | ConvertFrom-Json).name -eq 'Time'
            }
        }

        It 'Accepts positional parameter' {
            Switch-AwtrixApp 'Temperature'
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                ($Body | ConvertFrom-Json).name -eq 'Temperature'
            }
        }
    }

    Context 'Next' {
        It 'Sends POST to nextapp endpoint' {
            Switch-AwtrixApp -Next
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri -eq 'http://192.168.1.100/api/nextapp' -and
                $Method -eq 'POST'
            }
        }
    }

    Context 'Previous' {
        It 'Sends POST to previousapp endpoint' {
            Switch-AwtrixApp -Previous
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri -eq 'http://192.168.1.100/api/previousapp' -and
                $Method -eq 'POST'
            }
        }
    }
}
