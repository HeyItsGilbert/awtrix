BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force
}

Describe 'New-AwtrixDrawing' {

    Context 'Pixel' {
        It 'Creates a pixel drawing instruction' {
            $result = New-AwtrixDrawing -Pixel -X 5 -Y 3 -Color '#FF0000'
            $result.dp | Should -Not -BeNullOrEmpty
            $result.dp[0] | Should -Be 5
            $result.dp[1] | Should -Be 3
            $result.dp[2] | Should -Be '#FF0000'
        }
    }

    Context 'Line' {
        It 'Creates a line drawing instruction' {
            $result = New-AwtrixDrawing -Line -X 0 -Y 0 -X2 10 -Y2 7 -Color '#00FF00'
            $result.dl | Should -Not -BeNullOrEmpty
            $result.dl[0] | Should -Be 0
            $result.dl[1] | Should -Be 0
            $result.dl[2] | Should -Be 10
            $result.dl[3] | Should -Be 7
            $result.dl[4] | Should -Be '#00FF00'
        }
    }

    Context 'Rectangle' {
        It 'Creates a rectangle drawing instruction' {
            $result = New-AwtrixDrawing -Rectangle -X 2 -Y 1 -Width 8 -Height 6 -Color '#0000FF'
            $result.dr | Should -Not -BeNullOrEmpty
            $result.dr[0] | Should -Be 2
            $result.dr[1] | Should -Be 1
            $result.dr[2] | Should -Be 8
            $result.dr[3] | Should -Be 6
            $result.dr[4] | Should -Be '#0000FF'
        }
    }

    Context 'FilledRectangle' {
        It 'Creates a filled rectangle drawing instruction' {
            $result = New-AwtrixDrawing -FilledRectangle -X 0 -Y 0 -Width 4 -Height 4 -Color '#FF6600'
            $result.df | Should -Not -BeNullOrEmpty
            $result.df[2] | Should -Be 4
            $result.df[3] | Should -Be 4
        }
    }

    Context 'Circle' {
        It 'Creates a circle drawing instruction' {
            $result = New-AwtrixDrawing -Circle -X 16 -Y 4 -Radius 3 -Color '#FF0000'
            $result.dc | Should -Not -BeNullOrEmpty
            $result.dc[0] | Should -Be 16
            $result.dc[1] | Should -Be 4
            $result.dc[2] | Should -Be 3
            $result.dc[3] | Should -Be '#FF0000'
        }
    }

    Context 'FilledCircle' {
        It 'Creates a filled circle drawing instruction' {
            $result = New-AwtrixDrawing -FilledCircle -X 10 -Y 5 -Radius 2 -Color '#00FFFF'
            $result.dfc | Should -Not -BeNullOrEmpty
            $result.dfc[0] | Should -Be 10
            $result.dfc[1] | Should -Be 5
            $result.dfc[2] | Should -Be 2
        }
    }

    Context 'Text' {
        It 'Creates a text drawing instruction' {
            $result = New-AwtrixDrawing -Text -X 0 -Y 0 -TextContent 'Hello' -Color '#FFFFFF'
            $result.dt | Should -Not -BeNullOrEmpty
            $result.dt[0] | Should -Be 0
            $result.dt[1] | Should -Be 0
            $result.dt[2] | Should -Be 'Hello'
            $result.dt[3] | Should -Be '#FFFFFF'
        }
    }

    Context 'Bitmap' {
        It 'Creates a bitmap drawing instruction' {
            $bmpData = @(255, 0, 0, 0, 255, 0, 0, 0, 255, 255, 255, 0)
            $result = New-AwtrixDrawing -Bitmap -X 0 -Y 0 -Width 2 -Height 2 -BitmapData $bmpData
            $result.db | Should -Not -BeNullOrEmpty
            $result.db[0] | Should -Be 0
            $result.db[1] | Should -Be 0
            $result.db[2] | Should -Be 2
            $result.db[3] | Should -Be 2
        }
    }

    Context 'JSON serialization' {
        It 'Serializes circle correctly for API' {
            $result = New-AwtrixDrawing -Circle -X 28 -Y 4 -Radius 3 -Color '#FF0000'
            $json = $result | ConvertTo-Json -Compress -Depth 5
            $json | Should -BeLike '*"dc"*'
            $json | Should -BeLike '*28*'
        }
    }
}
