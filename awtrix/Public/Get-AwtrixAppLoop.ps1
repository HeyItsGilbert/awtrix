function Get-AwtrixAppLoop {
    <#
    .SYNOPSIS
        Retrieves the current app loop from the AWTRIX device.
    .DESCRIPTION
        Returns a list of all apps currently in the display loop on the AWTRIX 3 device,
        including built-in apps (Time, Date, Temperature, Humidity, Battery) and any
        custom apps that have been added.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Get-AwtrixAppLoop

        Returns all apps in the current loop.
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'loop' -Method GET -BaseUri $BaseUri
}
