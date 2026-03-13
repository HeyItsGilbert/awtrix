function Restart-Awtrix {
    <#
    .SYNOPSIS
        Reboots the AWTRIX device.
    .DESCRIPTION
        Sends a reboot command to the AWTRIX 3 device, causing it to restart.
        This is useful after changing settings that require a reboot (e.g., enabling/disabling built-in apps).
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Restart-Awtrix

        Reboots the AWTRIX device.
    .EXAMPLE
        PS> Restart-Awtrix -Confirm:$false

        Reboots without confirmation prompt.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    if ($PSCmdlet.ShouldProcess('AWTRIX Device', 'Reboot')) {
        InvokeAwtrixApi -Endpoint 'reboot' -Method POST -BaseUri $BaseUri
    }
}
