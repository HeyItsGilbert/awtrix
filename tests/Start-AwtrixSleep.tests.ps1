BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Start-AwtrixSleep' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends sleep payload with correct seconds' {
        Start-AwtrixSleep -Seconds 3600
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/sleep' -and
            $Method -eq 'POST' -and
            ($Body | ConvertFrom-Json).sleep -eq 3600
        }
    }

    It 'Rejects zero or negative seconds' {
        { Start-AwtrixSleep -Seconds 0 } | Should -Throw
        { Start-AwtrixSleep -Seconds -5 } | Should -Throw
    }

    It 'Accepts positional parameter' {
        Start-AwtrixSleep 60
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).sleep -eq 60
        }
    }

    It 'Supports ShouldProcess' {
        $cmd = Get-Command Start-AwtrixSleep
        $cmd.Parameters.Keys | Should -Contain 'WhatIf'
    }
}
