function Update-AwtrixFirmware {
    <#
    .SYNOPSIS
        Initiates a firmware update on the AWTRIX device.
    .DESCRIPTION
        Triggers the firmware update process on the AWTRIX 3 device.
        The device will download and install the latest available firmware.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Update-AwtrixFirmware

        Starts the firmware update process.
    .EXAMPLE
        PS> Update-AwtrixFirmware -BaseUri '192.168.1.100'

        Updates firmware on a specific device.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    if ($PSCmdlet.ShouldProcess('AWTRIX Device', 'Update firmware')) {
        InvokeAwtrixApi -Endpoint 'doupdate' -Method POST -BaseUri $BaseUri
    }
}
