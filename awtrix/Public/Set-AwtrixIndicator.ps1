function Set-AwtrixIndicator {
    <#
    .SYNOPSIS
        Sets a colored indicator on the AWTRIX display.
    .DESCRIPTION
        Configures one of three colored indicators on the AWTRIX 3 display:
        - Indicator 1: Upper right corner
        - Indicator 2: Right side
        - Indicator 3: Lower right corner

        Indicators can optionally blink or fade at a specified interval.
    .PARAMETER Id
        The indicator number (1, 2, or 3).
    .PARAMETER Color
        The color for the indicator. Accepts a hex string (e.g., '#FF0000') or an RGB array (e.g., @(255, 0, 0)).
    .PARAMETER Blink
        Makes the indicator blink at the specified interval in milliseconds.
    .PARAMETER Fade
        Makes the indicator fade on and off at the specified interval in milliseconds.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Set-AwtrixIndicator -Id 1 -Color '#FF0000'

        Sets indicator 1 (upper right) to red.
    .EXAMPLE
        PS> Set-AwtrixIndicator -Id 2 -Color @(0, 255, 0) -Blink 500

        Sets indicator 2 to green, blinking every 500ms.
    .EXAMPLE
        PS> Set-AwtrixIndicator -Id 3 -Color '#0000FF' -Fade 1000

        Sets indicator 3 to blue, fading every 1000ms.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet(1, 2, 3)]
        [int]$Id,

        [Parameter(Mandatory, Position = 1)]
        $Color,

        [Parameter()]
        [int]$Blink,

        [Parameter()]
        [int]$Fade,

        [Parameter()]
        [string]$BaseUri
    )

    $body = @{
        color = ConvertColorInput -Color $Color
    }

    if ($PSBoundParameters.ContainsKey('Blink')) {
        $body['blink'] = $Blink
    }

    if ($PSBoundParameters.ContainsKey('Fade')) {
        $body['fade'] = $Fade
    }

    InvokeAwtrixApi -Endpoint "indicator$Id" -Method POST -Body $body -BaseUri $BaseUri
}
