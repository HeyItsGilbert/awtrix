BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Get-AwtrixSetting' {

    BeforeAll {
        Mock Invoke-RestMethod {
            [PSCustomObject]@{ BRI = 150; ATIME = 7; TEFF = 1 }
        } -ModuleName awtrix
    }

    It 'Calls the settings endpoint with GET' {
        Get-AwtrixSetting
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/settings' -and $Method -eq 'GET'
        }
    }

    It 'Returns settings object' {
        $result = Get-AwtrixSetting
        $result.BRI | Should -Be 150
    }
}
