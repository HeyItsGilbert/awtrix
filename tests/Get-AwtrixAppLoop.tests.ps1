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

Describe 'Get-AwtrixAppLoop' {

    BeforeAll {
        Mock Invoke-RestMethod {
            @('Time', 'Date', 'Temperature', 'myapp')
        } -ModuleName awtrix
    }

    It 'Calls the loop endpoint with GET' {
        Get-AwtrixAppLoop
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/loop' -and $Method -eq 'GET'
        }
    }

    It 'Returns app loop list' {
        $result = Get-AwtrixAppLoop
        $result | Should -Contain 'Time'
        $result | Should -Contain 'myapp'
    }
}
