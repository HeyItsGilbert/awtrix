BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Send-AwtrixSound' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends correct sound payload' {
        Send-AwtrixSound -Sound 'alarm'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/sound' -and
            $Method -eq 'POST' -and
            ($Body | ConvertFrom-Json).sound -eq 'alarm'
        }
    }

    It 'Accepts positional parameter' {
        Send-AwtrixSound 'doorbell'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).sound -eq 'doorbell'
        }
    }

    It 'Accepts DFplayer number' {
        Send-AwtrixSound -Sound '0001'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).sound -eq '0001'
        }
    }
}
