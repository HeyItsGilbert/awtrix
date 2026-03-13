BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Get-AwtrixTransition' {

    BeforeAll {
        Mock Invoke-RestMethod {
            @('Slide', 'Dim', 'Zoom', 'Rotate')
        } -ModuleName awtrix
    }

    It 'Calls the transitions endpoint with GET' {
        Get-AwtrixTransition
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/transitions' -and $Method -eq 'GET'
        }
    }

    It 'Returns transition list' {
        $result = Get-AwtrixTransition
        $result | Should -Contain 'Slide'
    }
}
