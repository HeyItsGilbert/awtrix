BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Get-AwtrixScreen' {

    BeforeAll {
        Mock Invoke-RestMethod {
            @(0, 16777215, 255, 65280)
        } -ModuleName awtrix
    }

    It 'Calls the screen endpoint with GET' {
        Get-AwtrixScreen
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/screen' -and $Method -eq 'GET'
        }
    }

    It 'Returns pixel color array' {
        $result = Get-AwtrixScreen
        $result | Should -HaveCount 4
    }
}
