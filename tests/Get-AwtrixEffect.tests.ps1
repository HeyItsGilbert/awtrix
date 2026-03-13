BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Get-AwtrixEffect' {

    BeforeAll {
        Mock Invoke-RestMethod {
            @('Fade', 'Rainbow', 'Sparkle')
        } -ModuleName awtrix
    }

    It 'Calls the effects endpoint with GET' {
        Get-AwtrixEffect
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/effects' -and $Method -eq 'GET'
        }
    }

    It 'Returns a list of effects' {
        $result = Get-AwtrixEffect
        $result | Should -Contain 'Rainbow'
    }
}
