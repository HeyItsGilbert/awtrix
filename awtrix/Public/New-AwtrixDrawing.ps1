function New-AwtrixDrawing {
    <#
    .SYNOPSIS
        Creates a drawing instruction object for AWTRIX custom apps.
    .DESCRIPTION
        Generates drawing instruction objects that can be passed to the -Draw
        parameter of Set-AwtrixApp or Send-AwtrixNotification. Supports pixels,
        lines, rectangles, filled rectangles, circles, filled circles, text, and bitmaps.

        Note: Depending on the number of drawing objects, RAM usage can be high.
        Be mindful of complexity to avoid device freezes or reboots.
    .PARAMETER Pixel
        Draw a pixel at position (X, Y).
    .PARAMETER Line
        Draw a line from (X, Y) to (X2, Y2).
    .PARAMETER Rectangle
        Draw a rectangle outline at (X, Y) with given Width and Height.
    .PARAMETER FilledRectangle
        Draw a filled rectangle at (X, Y) with given Width and Height.
    .PARAMETER Circle
        Draw a circle outline at center (X, Y) with given Radius.
    .PARAMETER FilledCircle
        Draw a filled circle at center (X, Y) with given Radius.
    .PARAMETER Text
        Draw text at position (X, Y).
    .PARAMETER Bitmap
        Draw an RGB888 bitmap at position (X, Y) with given Width and Height.
    .PARAMETER X
        The X coordinate.
    .PARAMETER Y
        The Y coordinate.
    .PARAMETER X2
        The ending X coordinate (for lines).
    .PARAMETER Y2
        The ending Y coordinate (for lines).
    .PARAMETER Width
        The width (for rectangles and bitmaps).
    .PARAMETER Height
        The height (for rectangles and bitmaps).
    .PARAMETER Radius
        The radius (for circles).
    .PARAMETER Color
        The draw color. Accepts a hex string (e.g., '#FF0000') or RGB array (e.g., @(255, 0, 0)).
    .PARAMETER TextContent
        The text string to draw (for the Text drawing type).
    .PARAMETER BitmapData
        The RGB888 bitmap data array (for the Bitmap drawing type).
    .EXAMPLE
        PS> New-AwtrixDrawing -Pixel -X 5 -Y 3 -Color '#FF0000'

        Creates a red pixel at position (5, 3).
    .EXAMPLE
        PS> New-AwtrixDrawing -Line -X 0 -Y 0 -X2 10 -Y2 7 -Color '#00FF00'

        Creates a green line from (0,0) to (10,7).
    .EXAMPLE
        PS> New-AwtrixDrawing -Circle -X 16 -Y 4 -Radius 3 -Color '#0000FF'

        Creates a blue circle outline at center (16,4) with radius 3.
    .EXAMPLE
        PS> New-AwtrixDrawing -Text -X 0 -Y 0 -TextContent 'Hello' -Color '#FFFFFF'

        Creates white text 'Hello' at position (0,0).
    .EXAMPLE
        PS> New-AwtrixDrawing -FilledRectangle -X 0 -Y 0 -Width 8 -Height 8 -Color '#FF6600'

        Creates a filled orange 8x8 rectangle.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSReviewUnusedParameter',
        '',
        Justification = 'The switches are used via the parameter sets and ScriptAnalyzer thinks they are not being used'
    )]
    [OutputType([hashtable])]
    [CmdletBinding(DefaultParameterSetName = 'Pixel')]
    param(
        [Parameter(ParameterSetName = 'Pixel', Mandatory)]
        [switch]$Pixel,

        [Parameter(ParameterSetName = 'Line', Mandatory)]
        [switch]$Line,

        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [switch]$Rectangle,

        [Parameter(ParameterSetName = 'FilledRectangle', Mandatory)]
        [switch]$FilledRectangle,

        [Parameter(ParameterSetName = 'Circle', Mandatory)]
        [switch]$Circle,

        [Parameter(ParameterSetName = 'FilledCircle', Mandatory)]
        [switch]$FilledCircle,

        [Parameter(ParameterSetName = 'Text', Mandatory)]
        [switch]$Text,

        [Parameter(ParameterSetName = 'Bitmap', Mandatory)]
        [switch]$Bitmap,

        [Parameter(Mandatory)]
        [int]$X,

        [Parameter(Mandatory)]
        [int]$Y,

        [Parameter(ParameterSetName = 'Line', Mandatory)]
        [int]$X2,

        [Parameter(ParameterSetName = 'Line', Mandatory)]
        [int]$Y2,

        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [Parameter(ParameterSetName = 'FilledRectangle', Mandatory)]
        [Parameter(ParameterSetName = 'Bitmap', Mandatory)]
        [int]$Width,

        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [Parameter(ParameterSetName = 'FilledRectangle', Mandatory)]
        [Parameter(ParameterSetName = 'Bitmap', Mandatory)]
        [int]$Height,

        [Parameter(ParameterSetName = 'Circle', Mandatory)]
        [Parameter(ParameterSetName = 'FilledCircle', Mandatory)]
        [int]$Radius,

        [Parameter(ParameterSetName = 'Pixel', Mandatory)]
        [Parameter(ParameterSetName = 'Line', Mandatory)]
        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [Parameter(ParameterSetName = 'FilledRectangle', Mandatory)]
        [Parameter(ParameterSetName = 'Circle', Mandatory)]
        [Parameter(ParameterSetName = 'FilledCircle', Mandatory)]
        [Parameter(ParameterSetName = 'Text', Mandatory)]
        $Color,

        [Parameter(ParameterSetName = 'Text', Mandatory)]
        [string]$TextContent,

        [Parameter(ParameterSetName = 'Bitmap', Mandatory)]
        [int[]]$BitmapData
    )

    if ($PSCmdlet.ParameterSetName -ne 'Bitmap') {
        $cl = ConvertColorInput -Color $Color
    }
    switch ($PSCmdlet.ParameterSetName) {
        'Pixel' {
            $v = [System.Collections.ArrayList]::new()
            [void]$v.Add($X)
            [void]$v.Add($Y)
            [void]$v.Add($cl)
            @{ dp = $v }
        }
        'Line' {
            $v = [System.Collections.ArrayList]::new()
            [void]$v.Add($X)
            [void]$v.Add($Y)
            [void]$v.Add($X2)
            [void]$v.Add($Y2)
            [void]$v.Add($cl)
            @{ dl = $v }
        }
        'Rectangle' {
            $v = [System.Collections.ArrayList]::new()
            [void]$v.Add($X)
            [void]$v.Add($Y)
            [void]$v.Add($Width)
            [void]$v.Add($Height)
            [void]$v.Add($cl)
            @{ dr = $v }
        }
        'FilledRectangle' {
            $v = [System.Collections.ArrayList]::new()
            [void]$v.Add($X)
            [void]$v.Add($Y)
            [void]$v.Add($Width)
            [void]$v.Add($Height)
            [void]$v.Add($cl)
            @{ df = $v }
        }
        'Circle' {
            $v = [System.Collections.ArrayList]::new()
            [void]$v.Add($X)
            [void]$v.Add($Y)
            [void]$v.Add($Radius)
            [void]$v.Add($cl)
            @{ dc = $v }
        }
        'FilledCircle' {
            $v = [System.Collections.ArrayList]::new()
            [void]$v.Add($X)
            [void]$v.Add($Y)
            [void]$v.Add($Radius)
            [void]$v.Add($cl)
            @{ dfc = $v }
        }
        'Text' {
            $v = [System.Collections.ArrayList]::new()
            [void]$v.Add($X)
            [void]$v.Add($Y)
            [void]$v.Add($TextContent)
            [void]$v.Add($cl)
            @{ dt = $v }
        }
        'Bitmap' {
            $v = [System.Collections.ArrayList]::new()
            [void]$v.Add($X)
            [void]$v.Add($Y)
            [void]$v.Add($Width)
            [void]$v.Add($Height)
            [void]$v.Add($BitmapData)
            @{ db = $v }
        }
    }
}
