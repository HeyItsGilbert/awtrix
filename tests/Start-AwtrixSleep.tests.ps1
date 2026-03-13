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
