BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Get-AwtrixAppLoop' {

    BeforeAll {
        Mock Invoke-RestMethod {
            @('Time', 'Date', 'Temperature', 'myapp')
        } -ModuleName awtrix
    }

    It 'Calls the loop endpoint with GET' {
        Get-AwtrixAppLoop
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/loop' -and $Method -eq 'GET'
        }
    }

    It 'Returns app loop list' {
        $result = Get-AwtrixAppLoop
        $result | Should -Contain 'Time'
        $result | Should -Contain 'myapp'
    }
}
