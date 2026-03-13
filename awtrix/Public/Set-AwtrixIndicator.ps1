function Set-AwtrixIndicator {
    <#
    .SYNOPSIS
        Sets a colored indicator on the AWTRIX display.
    .DESCRIPTION
        Configures one of three colored indicators on the AWTRIX 3 display:
        - Top: Upper right corner
        - Middle: Right side
        - Bottom: Lower right corner

        Indicators can optionally blink or fade at a specified interval.
    .PARAMETER Position
        The indicator position on the display: Top (upper right), Middle (right side), or Bottom (lower right).
    .PARAMETER Color
        The color for the indicator. Accepts a named color (e.g., Red, Green, Blue),
        a hex string (e.g., '#FF0000'), or an RGB array (e.g., @(255, 0, 0)).
    .PARAMETER BlinkMilliseconds
        Makes the indicator blink at the specified interval in milliseconds.
    .PARAMETER FadeMilliseconds
        Makes the indicator fade on and off at the specified interval in milliseconds.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Set-AwtrixIndicator -Position Top -Color Red

        Sets the top indicator (upper right) to red.
    .EXAMPLE
        PS> Set-AwtrixIndicator -Position Middle -Color Green -BlinkMilliseconds 500

        Sets the middle indicator to green, blinking every 500ms.
    .EXAMPLE
        PS> Set-AwtrixIndicator -Position Bottom -Color '#0000FF' -FadeMilliseconds 1000

        Sets the bottom indicator to blue, fading every 1000ms.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [AwtrixIndicatorPosition]$Position,

        [Parameter(Mandatory, Position = 1)]
        [AwtrixColorTransform()]
        $Color,

        [Parameter()]
        [Alias('BlinkMs')]
        [int]$BlinkMilliseconds,

        [Parameter()]
        [Alias('FadeMs')]
        [int]$FadeMilliseconds,

        [Parameter()]
        [string]$BaseUri
    )

    $body = @{
        color = $Color
    }

    if ($PSBoundParameters.ContainsKey('BlinkMilliseconds')) {
        $body['blink'] = $BlinkMilliseconds
    }

    if ($PSBoundParameters.ContainsKey('FadeMilliseconds')) {
        $body['fade'] = $FadeMilliseconds
    }

    InvokeAwtrixApi -Endpoint "indicator$([int]$Position)" -Method POST -Body $body -BaseUri $BaseUri
}
