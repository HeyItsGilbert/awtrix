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
}

Describe 'Disconnect-Awtrix' {

    It 'Clears the stored connection' {
        # Set a fake connection first
        & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
        Disconnect-Awtrix
        $conn = & (Get-Module awtrix) { $script:AwtrixConnection }
        $conn | Should -BeNullOrEmpty
    }

    It 'Does not throw when no connection exists' {
        & (Get-Module awtrix) { $script:AwtrixConnection = $null }
        { Disconnect-Awtrix } | Should -Not -Throw
    }
}
