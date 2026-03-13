BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Set-AwtrixPower' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends power on payload' {
        Set-AwtrixPower -On
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/power' -and
            $Method -eq 'POST' -and
            ($Body | ConvertFrom-Json).power -eq $true
        }
    }

    It 'Sends power off payload' {
        Set-AwtrixPower -Off
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/power' -and
            $Method -eq 'POST' -and
            ($Body | ConvertFrom-Json).power -eq $false
        }
    }

    It 'Supports ShouldProcess' {
        $cmd = Get-Command Set-AwtrixPower
        $cmd.Parameters.Keys | Should -Contain 'WhatIf'
    }
}
