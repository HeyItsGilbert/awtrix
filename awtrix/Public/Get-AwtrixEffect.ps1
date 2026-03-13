function Get-AwtrixEffect {
    <#
    .SYNOPSIS
        Retrieves available effects from the AWTRIX device.
    .DESCRIPTION
        Returns a list of all available background effects that can be used
        with custom apps and notifications on the AWTRIX 3 device.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Get-AwtrixEffect

        Returns all available effects.
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'effects' -Method GET -BaseUri $BaseUri
}
