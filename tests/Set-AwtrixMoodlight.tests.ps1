BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Set-AwtrixMoodlight' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    Context 'Kelvin mode' {
        It 'Sends kelvin and brightness payload' {
            Set-AwtrixMoodlight -Brightness 170 -Kelvin 2300
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri -eq 'http://192.168.1.100/api/moodlight' -and
                $Method -eq 'POST' -and
                $Body -ne $null
            }
        }

        It 'Includes kelvin value in body' {
            Set-AwtrixMoodlight -Kelvin 3500
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $body = $Body | ConvertFrom-Json
                $body.kelvin -eq 3500
            }
        }
    }

    Context 'Color mode' {
        It 'Sends color as hex string' {
            Set-AwtrixMoodlight -Color '#FF00FF'
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $body = $Body | ConvertFrom-Json
                $body.color -eq '#FF00FF'
            }
        }

        It 'Sends brightness with color' {
            Set-AwtrixMoodlight -Brightness 100 -Color '#00FF00'
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $body = $Body | ConvertFrom-Json
                $body.brightness -eq 100 -and $body.color -eq '#00FF00'
            }
        }
    }

    Context 'Disable mode' {
        It 'Sends empty payload to disable moodlight' {
            Set-AwtrixMoodlight -Disable
            Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
                $Uri -eq 'http://192.168.1.100/api/moodlight' -and
                $Method -eq 'POST'
            }
        }
    }
}
