BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Clear-AwtrixIndicator' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends empty POST to indicator 1' {
        Clear-AwtrixIndicator -Id 1
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator1' -and
            $Method -eq 'POST'
        }
    }

    It 'Sends empty POST to indicator 2' {
        Clear-AwtrixIndicator -Id 2
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator2'
        }
    }

    It 'Sends empty POST to indicator 3' {
        Clear-AwtrixIndicator -Id 3
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator3'
        }
    }

    It 'Rejects invalid indicator IDs' {
        { Clear-AwtrixIndicator -Id 0 } | Should -Throw
        { Clear-AwtrixIndicator -Id 4 } | Should -Throw
    }
}
