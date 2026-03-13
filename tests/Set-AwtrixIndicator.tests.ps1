BeforeAll {
    if ($null -eq $env:BHPSModuleManifest) {
        & "$PSScriptRoot/../Build.ps1" -Task Init
    }
    $manifest = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
    $outputDir = Join-Path -Path $env:BHProjectPath -ChildPath 'Output'
    $outputModDir = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
    $outputModVerDir = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion
    $outputModVerManifest = Join-Path -Path $outputModVerDir -ChildPath "$($env:BHProjectName).psd1"

    Get-Module $env:BHProjectName | Remove-Module -Force -ErrorAction Ignore
    Import-Module -Name $outputModVerManifest -Verbose:$false -ErrorAction Stop

    & (Get-Module $env:BHProjectName) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Set-AwtrixIndicator' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends color to indicator 1 endpoint via Top position' {
        Set-AwtrixIndicator -Position Top -Color '#FF0000'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator1' -and
            $Method -eq 'POST'
        }
    }

    It 'Sends color to indicator 2 endpoint via Middle position' {
        Set-AwtrixIndicator -Position Middle -Color '#00FF00'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator2'
        }
    }

    It 'Sends color to indicator 3 endpoint via Bottom position' {
        Set-AwtrixIndicator -Position Bottom -Color '#0000FF'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/indicator3'
        }
    }

    It 'Accepts named color enum values' {
        Set-AwtrixIndicator -Position Top -Color Red
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).color -eq '#FF0000'
        }
    }

    It 'Accepts named color strings' {
        Set-AwtrixIndicator -Position Top -Color 'Green'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).color -eq '#00FF00'
        }
    }

    It 'Includes blink interval in payload' {
        Set-AwtrixIndicator -Position Top -Color '#FF0000' -BlinkMilliseconds 500
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).blink -eq 500
        }
    }

    It 'Accepts BlinkMs alias' {
        Set-AwtrixIndicator -Position Top -Color '#FF0000' -BlinkMs 250
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).blink -eq 250
        }
    }

    It 'Includes fade interval in payload' {
        Set-AwtrixIndicator -Position Top -Color '#FF0000' -FadeMilliseconds 1000
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).fade -eq 1000
        }
    }

    It 'Accepts FadeMs alias' {
        Set-AwtrixIndicator -Position Top -Color '#FF0000' -FadeMs 750
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            ($Body | ConvertFrom-Json).fade -eq 750
        }
    }

    It 'Rejects invalid indicator positions' {
        { Set-AwtrixIndicator -Position 'Invalid' -Color '#FF0000' } | Should -Throw
    }
}
