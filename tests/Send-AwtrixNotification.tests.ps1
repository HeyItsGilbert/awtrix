BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Send-AwtrixNotification' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends to notify endpoint' {
        Send-AwtrixNotification -Text 'Alert!'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/notify' -and
            $Method -eq 'POST'
        }
    }

    It 'Includes text in payload' {
        Send-AwtrixNotification -Text 'Hello'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).text -eq 'Hello'
        }
    }

    It 'Includes hold flag' {
        Send-AwtrixNotification -Text 'Important' -Hold
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).hold -eq $true
        }
    }

    It 'Includes sound in payload' {
        Send-AwtrixNotification -Text 'Alert!' -Sound 'alarm'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).sound -eq 'alarm'
        }
    }

    It 'Includes wakeup flag' {
        Send-AwtrixNotification -Text 'Wake!' -Wakeup
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).wakeup -eq $true
        }
    }

    It 'Includes duration and icon' {
        Send-AwtrixNotification -Text 'Test' -Duration 15 -Icon 'warning'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.duration -eq 15 -and $parsed.icon -eq 'warning'
        }
    }

    It 'Includes rainbow and noScroll flags' {
        Send-AwtrixNotification -Text 'Hi' -Rainbow -NoScroll
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.rainbow -eq $true -and $parsed.noScroll -eq $true
        }
    }

    It 'Does not include BaseUri in payload' {
        Send-AwtrixNotification -Text 'Hi' -BaseUri '10.0.0.1'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $null -eq ($Body | ConvertFrom-Json).BaseUri
        }
    }
}
