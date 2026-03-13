function Get-AwtrixScreen {
    <#
    .SYNOPSIS
        Retrieves the current screen content from the AWTRIX device.
    .DESCRIPTION
        Returns the current matrix screen as an array of 24-bit colors,
        representing the live display content of the AWTRIX 3 device.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Get-AwtrixScreen

        Returns the current screen pixel data as an array of color values.
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'screen' -Method GET -BaseUri $BaseUri
}
