function Get-AwtrixStats {
    <#
    .SYNOPSIS
        Retrieves general statistics from the AWTRIX device.
    .DESCRIPTION
        Returns device information including battery level, RAM usage, uptime,
        WiFi signal strength, and other system metrics from the AWTRIX 3 device.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Get-AwtrixStats

        Returns device statistics using the stored connection.
    .EXAMPLE
        PS> Get-AwtrixStats -BaseUri '192.168.1.100'

        Returns device statistics from a specific device.
    #>
    [OutputType([PSCustomObject])]
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'stats' -Method GET -BaseUri $BaseUri
}
