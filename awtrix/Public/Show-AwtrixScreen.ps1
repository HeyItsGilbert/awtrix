function Show-AwtrixScreen {
    <#
    .SYNOPSIS
        Renders the current AWTRIX screen as colored pixels in the terminal.
    .DESCRIPTION
        Fetches the current 32x8 matrix screen from the AWTRIX device and renders
        it in the terminal using Spectre.Console's Canvas via PwshSpectreConsole.
        Each LED pixel is displayed as a colored block, scaled up for visibility.

        Requires the PwshSpectreConsole module to be installed:
            Install-Module PwshSpectreConsole
    .PARAMETER ScreenData
        Optional pre-fetched screen data (array of 256 24-bit color integers).
        If not provided, the function calls Get-AwtrixScreen to fetch live data.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .PARAMETER PixelSize
        Scale factor for each pixel. Default is 2, meaning each LED pixel maps to
        a 2x2 block on the canvas for better visibility.
    .EXAMPLE
        PS> Show-AwtrixScreen

        Fetches and renders the current screen content.
    .EXAMPLE
        PS> Get-AwtrixScreen | Show-AwtrixScreen -PixelSize 3

        Pipes screen data and renders at 3x scale.
    .EXAMPLE
        PS> Show-AwtrixScreen -BaseUri 'http://192.168.1.100'

        Renders screen from a specific device.
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [int[]]$ScreenData,

        [Parameter()]
        [string]$BaseUri,

        [Parameter()]
        [ValidateRange(1, 5)]
        [int]$PixelSize = 2
    )

    begin {
        if (-not (Get-Module -Name PwshSpectreConsole -ListAvailable)) {
            throw 'PwshSpectreConsole module is required. Install it with: Install-Module PwshSpectreConsole'
        }

        Import-Module PwshSpectreConsole -ErrorAction Stop

        $collectedData = [System.Collections.Generic.List[int]]::new()
    }

    process {
        if ($null -ne $ScreenData) {
            foreach ($pixel in $ScreenData) {
                $collectedData.Add($pixel)
            }
        }
    }

    end {
        if ($collectedData.Count -eq 0) {
            $fetchParams = @{}
            if ($BaseUri) { $fetchParams['BaseUri'] = $BaseUri }
            $collectedData = [System.Collections.Generic.List[int]]::new(
                [int[]](Get-AwtrixScreen @fetchParams)
            )
        }

        $matrixWidth = 32
        $matrixHeight = 8
        $expectedPixels = $matrixWidth * $matrixHeight

        if ($collectedData.Count -ne $expectedPixels) {
            throw "Expected $expectedPixels pixel values (32x8) but received $($collectedData.Count)."
        }

        $canvasWidth = $matrixWidth * $PixelSize
        $canvasHeight = $matrixHeight * $PixelSize
        $canvas = [Spectre.Console.Canvas]::new($canvasWidth, $canvasHeight)

        for ($y = 0; $y -lt $matrixHeight; $y++) {
            for ($x = 0; $x -lt $matrixWidth; $x++) {
                $colorInt = $collectedData[$y * $matrixWidth + $x]

                $r = [byte](($colorInt -shr 16) -band 0xFF)
                $g = [byte](($colorInt -shr 8) -band 0xFF)
                $b = [byte]($colorInt -band 0xFF)
                $color = [Spectre.Console.Color]::new($r, $g, $b)

                # Fill the scaled pixel block
                for ($py = 0; $py -lt $PixelSize; $py++) {
                    for ($px = 0; $px -lt $PixelSize; $px++) {
                        $canvas.SetPixel(
                            ($x * $PixelSize) + $px,
                            ($y * $PixelSize) + $py,
                            $color
                        )
                    }
                }
            }
        }

        [Spectre.Console.AnsiConsole]::Write($canvas)
    }
}
