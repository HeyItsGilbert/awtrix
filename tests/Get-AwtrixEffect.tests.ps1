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

Describe 'Get-AwtrixEffect' {

    BeforeAll {
        Mock Invoke-RestMethod {
            @('Fade', 'Rainbow', 'Sparkle')
        } -ModuleName awtrix
    }

    It 'Calls the effects endpoint with GET' {
        Get-AwtrixEffect
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/effects' -and $Method -eq 'GET'
        }
    }

    It 'Returns a list of effects' {
        $result = Get-AwtrixEffect
        $result | Should -Contain 'Rainbow'
    }
}
