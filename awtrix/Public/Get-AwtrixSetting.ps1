function Get-AwtrixSetting {
    <#
    .SYNOPSIS
        Retrieves settings from the AWTRIX device.
    .DESCRIPTION
        Returns the current device settings from the AWTRIX 3 device, including
        brightness, transition effects, time/date formats, text colors, app
        visibility, and other configurable options.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Get-AwtrixSetting

        Returns all current device settings.
    .EXAMPLE
        PS> (Get-AwtrixSetting).BRI

        Gets the current brightness value.
    #>
    [OutputType([PSCustomObject])]
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'settings' -Method GET -BaseUri $BaseUri
}
