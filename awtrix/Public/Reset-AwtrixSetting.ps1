function Reset-AwtrixSetting {
    <#
    .SYNOPSIS
        Resets all AWTRIX settings to defaults.
    .DESCRIPTION
        WARNING: This resets all settings from the settings API on the AWTRIX 3 device
        to their factory defaults. It does not reset flash files or WiFi settings.
        This action cannot be undone.
    .PARAMETER Force
        Bypasses the confirmation prompt.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Reset-AwtrixSetting

        Resets all settings after confirmation prompt.
    .EXAMPLE
        PS> Reset-AwtrixSetting -Force

        Resets all settings without confirmation.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter()]
        [switch]$Force,

        [Parameter()]
        [string]$BaseUri
    )

    if ($Force -or $PSCmdlet.ShouldProcess('AWTRIX Settings', 'Reset all settings to defaults')) {
        InvokeAwtrixApi -Endpoint 'resetSettings' -Method POST -BaseUri $BaseUri
    }
}
