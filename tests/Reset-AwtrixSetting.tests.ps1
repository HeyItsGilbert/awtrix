BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Reset-AwtrixSetting' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends POST to resetSettings endpoint with -Force' {
        Reset-AwtrixSetting -Force
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/resetSettings' -and $Method -eq 'POST'
        }
    }

    It 'Has High ConfirmImpact' {
        $cmd = Get-Command Reset-AwtrixSetting
        $meta = $cmd.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }
        $meta.ConfirmImpact | Should -Be 'High'
    }

    It 'Supports ShouldProcess' {
        $cmd = Get-Command Reset-AwtrixSetting
        $cmd.Parameters.Keys | Should -Contain 'WhatIf'
    }
}
