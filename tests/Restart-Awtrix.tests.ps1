BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Restart-Awtrix' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends POST to reboot endpoint' {
        Restart-Awtrix
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/reboot' -and $Method -eq 'POST'
        }
    }

    It 'Supports ShouldProcess' {
        $cmd = Get-Command Restart-Awtrix
        $cmd.Parameters.Keys | Should -Contain 'WhatIf'
    }
}
