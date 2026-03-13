BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Clear-AwtrixNotification' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends POST to notify/dismiss endpoint' {
        Clear-AwtrixNotification
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/notify/dismiss' -and
            $Method -eq 'POST'
        }
    }

    It 'Uses BaseUri override' {
        Clear-AwtrixNotification -BaseUri '10.0.0.5'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://10.0.0.5/api/notify/dismiss'
        }
    }
}
