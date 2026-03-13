BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
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
