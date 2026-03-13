function Get-AwtrixTransition {
    <#
    .SYNOPSIS
        Retrieves available transition effects from the AWTRIX device.
    .DESCRIPTION
        Returns a list of all transition effects available for app switching on the
        AWTRIX 3 device, including Slide, Dim, Zoom, Rotate, Pixelate, Curtain,
        Ripple, Blink, Reload, and Fade.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Get-AwtrixTransition

        Returns all available transition effects.
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'transitions' -Method GET -BaseUri $BaseUri
}
