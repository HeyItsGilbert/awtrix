function Reset-Awtrix {
    <#
    .SYNOPSIS
        Factory resets the AWTRIX device.
    .DESCRIPTION
        WARNING: This formats the flash memory and EEPROM on the AWTRIX 3 device
        but does not modify WiFi settings. This is essentially a factory reset
        and cannot be undone.
    .PARAMETER Force
        Bypasses the confirmation prompt.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Reset-Awtrix

        Factory resets the AWTRIX device after confirmation.
    .EXAMPLE
        PS> Reset-Awtrix -Force

        Factory resets without confirmation prompt.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter()]
        [switch]$Force,

        [Parameter()]
        [string]$BaseUri
    )

    if ($Force -or $PSCmdlet.ShouldProcess('AWTRIX Device', 'Factory reset (format flash memory and EEPROM)')) {
        InvokeAwtrixApi -Endpoint 'erase' -Method POST -BaseUri $BaseUri
    }
}
