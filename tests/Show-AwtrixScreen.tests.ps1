BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Show-AwtrixScreen' {

    BeforeAll {
        # Generate a full 32x8 (256 pixel) screen of known colors
        $script:blackScreen = @(0) * 256
        $script:whiteScreen = @(16777215) * 256

        # RGB test: first pixel red, second green, third blue, rest black
        $script:rgbScreen = @(0) * 256
        $script:rgbScreen[0] = 16711680  # 0xFF0000 red
        $script:rgbScreen[1] = 65280     # 0x00FF00 green
        $script:rgbScreen[2] = 255       # 0x0000FF blue
    }

    Context 'When PwshSpectreConsole is not available' {

        It 'Throws when PwshSpectreConsole module is not installed' {
            Mock Get-Module { $null } -ModuleName awtrix -ParameterFilter {
                $Name -eq 'PwshSpectreConsole' -and $ListAvailable
            }

            { Show-AwtrixScreen -ScreenData $script:blackScreen } | Should -Throw '*PwshSpectreConsole*'
        }
    }

    Context 'When PwshSpectreConsole is available' -Skip:(-not (Get-Module PwshSpectreConsole -ListAvailable)) {

        It 'Throws when pixel count is not 256' {
            { Show-AwtrixScreen -ScreenData @(0, 1, 2) } | Should -Throw '*Expected 256*'
        }

        It 'Fetches screen data when none is piped' {
            Mock Get-AwtrixScreen { $script:blackScreen } -ModuleName awtrix
            Mock -CommandName 'Write' -ModuleName awtrix -MockWith {} -ParameterFilter {
                $true
            }

            # Use the AnsiConsole mock approach: capture that the function runs without error
            # We cannot fully mock [Spectre.Console.AnsiConsole]::Write, so just verify Get-AwtrixScreen is called
            { Show-AwtrixScreen } | Should -Not -Throw
            Should -Invoke Get-AwtrixScreen -ModuleName awtrix -Times 1
        }

        It 'Accepts piped screen data' {
            { $script:blackScreen | Show-AwtrixScreen } | Should -Not -Throw
        }

        It 'Accepts PixelSize parameter' {
            { Show-AwtrixScreen -ScreenData $script:blackScreen -PixelSize 1 } | Should -Not -Throw
        }

        It 'Rejects PixelSize outside valid range' {
            { Show-AwtrixScreen -ScreenData $script:blackScreen -PixelSize 0 } | Should -Throw
            { Show-AwtrixScreen -ScreenData $script:blackScreen -PixelSize 6 } | Should -Throw
        }

        It 'Renders all-white screen without error' {
            { Show-AwtrixScreen -ScreenData $script:whiteScreen } | Should -Not -Throw
        }

        It 'Renders RGB test screen without error' {
            { Show-AwtrixScreen -ScreenData $script:rgbScreen } | Should -Not -Throw
        }
    }
}
