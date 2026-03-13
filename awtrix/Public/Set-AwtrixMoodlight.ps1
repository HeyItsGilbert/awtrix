function Set-AwtrixMoodlight {
    <#
    .SYNOPSIS
        Sets the AWTRIX matrix to a mood lighting mode.
    .DESCRIPTION
        Configures the entire AWTRIX 3 matrix as a mood light with a custom color or
        color temperature. Use -Disable to turn off mood lighting.

        Warning: Using mood lighting results in higher current draw and heat,
        especially when all pixels are lit. Manage brightness values responsibly.
    .PARAMETER Brightness
        The brightness level for the mood light (0-255).
    .PARAMETER Kelvin
        Color temperature in Kelvin (e.g., 2300 for warm white).
    .PARAMETER Color
        The color for the mood light. Accepts a hex string (e.g., '#FF00FF') or an RGB array (e.g., @(155, 38, 182)).
    .PARAMETER Disable
        Disables mood lighting by sending an empty payload.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Set-AwtrixMoodlight -Brightness 170 -Kelvin 2300

        Sets warm white mood lighting at brightness 170.
    .EXAMPLE
        PS> Set-AwtrixMoodlight -Brightness 100 -Color '#FF00FF'

        Sets magenta mood lighting at brightness 100.
    .EXAMPLE
        PS> Set-AwtrixMoodlight -Brightness 100 -Color @(155, 38, 182)

        Sets purple mood lighting using RGB values.
    .EXAMPLE
        PS> Set-AwtrixMoodlight -Disable

        Turns off mood lighting.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Kelvin')]
    param(
        [Parameter(ParameterSetName = 'Kelvin')]
        [Parameter(ParameterSetName = 'Color')]
        [ValidateRange(0, 255)]
        [int]$Brightness,

        [Parameter(ParameterSetName = 'Kelvin', Mandatory)]
        [int]$Kelvin,

        [Parameter(ParameterSetName = 'Color', Mandatory)]
        $Color,

        [Parameter(ParameterSetName = 'Disable', Mandatory)]
        [switch]$Disable,

        [Parameter()]
        [string]$BaseUri
    )

    if ($Disable) {
        InvokeAwtrixApi -Endpoint 'moodlight' -Method POST -BaseUri $BaseUri
        return
    }

    $body = @{}

    if ($PSBoundParameters.ContainsKey('Brightness')) {
        $body['brightness'] = $Brightness
    }

    if ($PSCmdlet.ParameterSetName -eq 'Kelvin') {
        $body['kelvin'] = $Kelvin
    } else {
        $body['color'] = ConvertColorInput -Color $Color
    }

    InvokeAwtrixApi -Endpoint 'moodlight' -Method POST -Body $body -BaseUri $BaseUri
}
