BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Set-AwtrixSetting' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends to settings endpoint with POST' {
        Set-AwtrixSetting -Brightness 150
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/settings' -and $Method -eq 'POST'
        }
    }

    It 'Maps Brightness to BRI' {
        Set-AwtrixSetting -Brightness 200
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).BRI -eq 200
        }
    }

    It 'Maps AppDisplayDuration to ATIME' {
        Set-AwtrixSetting -AppDisplayDuration 10
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).ATIME -eq 10
        }
    }

    It 'Maps TransitionEffect to TEFF' {
        Set-AwtrixSetting -TransitionEffect 3
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).TEFF -eq 3
        }
    }

    It 'Maps TransitionSpeed to TSPEED' {
        Set-AwtrixSetting -TransitionSpeed 300
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).TSPEED -eq 300
        }
    }

    It 'Maps Volume to VOL' {
        Set-AwtrixSetting -Volume 15
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).VOL -eq 15
        }
    }

    It 'Maps boolean settings correctly' {
        Set-AwtrixSetting -AutoBrightness $true -UseCelsius $false
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.ABRI -eq $true -and $parsed.CEL -eq $false
        }
    }

    It 'Maps ShowTimeApp to TIM' {
        Set-AwtrixSetting -ShowTimeApp $true
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).TIM -eq $true
        }
    }

    It 'Maps TimeFormat to TFORMAT' {
        Set-AwtrixSetting -TimeFormat '%H:%M'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).TFORMAT -eq '%H:%M'
        }
    }

    It 'Sends multiple settings in one payload' {
        Set-AwtrixSetting -Brightness 100 -Volume 20 -TransitionEffect 5
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $parsed = $Body | ConvertFrom-Json
            $parsed.BRI -eq 100 -and $parsed.VOL -eq 20 -and $parsed.TEFF -eq 5
        }
    }

    It 'Warns when no settings are specified' {
        Set-AwtrixSetting 3>&1 | Should -BeLike '*No settings*'
    }

    It 'Does not include BaseUri in payload' {
        Set-AwtrixSetting -Brightness 100 -BaseUri '10.0.0.1'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $null -eq ($Body | ConvertFrom-Json).BaseUri
        }
    }

    It 'Supports ShouldProcess' {
        $cmd = Get-Command Set-AwtrixSetting
        $cmd.Parameters.Keys | Should -Contain 'WhatIf'
    }

    It 'Rejects invalid brightness values' {
        { Set-AwtrixSetting -Brightness 300 } | Should -Throw
        { Set-AwtrixSetting -Brightness -1 } | Should -Throw
    }

    It 'Rejects invalid volume values' {
        { Set-AwtrixSetting -Volume 31 } | Should -Throw
        { Set-AwtrixSetting -Volume -1 } | Should -Throw
    }

    It 'Rejects invalid transition effect values' {
        { Set-AwtrixSetting -TransitionEffect 11 } | Should -Throw
    }
}
