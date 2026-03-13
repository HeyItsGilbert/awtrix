BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Remove-AwtrixApp' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends empty POST to custom endpoint with app name' {
        Remove-AwtrixApp -Name 'myapp'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/custom?name=myapp' -and
            $Method -eq 'POST'
        }
    }

    It 'Supports ShouldProcess' {
        $cmd = Get-Command Remove-AwtrixApp
        $cmd.Parameters.Keys | Should -Contain 'WhatIf'
    }

    It 'Accepts positional parameter' {
        Remove-AwtrixApp 'testapp'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -match 'name=testapp'
        }
    }
}
