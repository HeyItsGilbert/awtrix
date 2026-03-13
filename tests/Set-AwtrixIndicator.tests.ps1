BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Set-AwtrixIndicator' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends color to indicator 1 endpoint' {
        Set-AwtrixIndicator -Id 1 -Color '#FF0000'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator1' -and
            $Method -eq 'POST'
        }
    }

    It 'Sends color to indicator 2 endpoint' {
        Set-AwtrixIndicator -Id 2 -Color '#00FF00'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator2'
        }
    }

    It 'Sends color to indicator 3 endpoint' {
        Set-AwtrixIndicator -Id 3 -Color '#0000FF'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator3'
        }
    }

    It 'Includes blink interval in payload' {
        Set-AwtrixIndicator -Id 1 -Color '#FF0000' -Blink 500
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).blink -eq 500
        }
    }

    It 'Includes fade interval in payload' {
        Set-AwtrixIndicator -Id 1 -Color '#FF0000' -Fade 1000
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).fade -eq 1000
        }
    }

    It 'Rejects invalid indicator IDs' {
        { Set-AwtrixIndicator -Id 0 -Color '#FF0000' } | Should -Throw
        { Set-AwtrixIndicator -Id 4 -Color '#FF0000' } | Should -Throw
    }
}
