function Clear-AwtrixNotification {
    <#
    .SYNOPSIS
        Dismisses the current notification on the AWTRIX device.
    .DESCRIPTION
        Dismisses a notification on the AWTRIX 3 device that was sent with the
        Hold option enabled. The display returns to the normal app loop.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Clear-AwtrixNotification

        Dismisses the currently held notification.
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'notify/dismiss' -Method POST -BaseUri $BaseUri
}
