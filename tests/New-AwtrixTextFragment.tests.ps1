BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force
}

Describe 'New-AwtrixTextFragment' {

    It 'Creates a text fragment with text and color' {
        $result = New-AwtrixTextFragment -Text 'Hello' -Color 'FF0000'
        $result.t | Should -Be 'Hello'
        $result.c | Should -Be 'FF0000'
    }

    It 'Strips # prefix from color' {
        $result = New-AwtrixTextFragment -Text 'World' -Color '#00FF00'
        $result.c | Should -Be '00FF00'
    }

    It 'Accepts positional parameters' {
        $result = New-AwtrixTextFragment 'Test' 'FFFFFF'
        $result.t | Should -Be 'Test'
        $result.c | Should -Be 'FFFFFF'
    }

    It 'Works as part of array for Set-AwtrixApp' {
        $fragments = @(
            New-AwtrixTextFragment -Text 'Error: ' -Color 'FF0000'
            New-AwtrixTextFragment -Text 'disk full' -Color 'FFFFFF'
        )
        $fragments | Should -HaveCount 2
        $fragments[0].t | Should -Be 'Error: '
        $fragments[1].c | Should -Be 'FFFFFF'
    }

    It 'Serializes correctly to JSON' {
        $result = New-AwtrixTextFragment -Text 'Hi' -Color 'FF0000'
        $json = $result | ConvertTo-Json -Compress
        $json | Should -BeLike '*"t":"Hi"*'
        $json | Should -BeLike '*"c":"FF0000"*'
    }
}
