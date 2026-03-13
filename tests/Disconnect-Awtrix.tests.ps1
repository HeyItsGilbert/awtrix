BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force
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
