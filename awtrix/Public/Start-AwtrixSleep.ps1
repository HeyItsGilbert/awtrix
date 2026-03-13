function Start-AwtrixSleep {
    <#
    .SYNOPSIS
        Puts the AWTRIX device into deep sleep mode.
    .DESCRIPTION
        Sends the AWTRIX 3 device into deep sleep mode for a specified duration in seconds.
        The device will only wake up after the timer expires or when the middle
        button is pressed. There is no way to wake up via API.
    .PARAMETER Seconds
        The number of seconds the device should sleep.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Start-AwtrixSleep -Seconds 3600

        Puts the device to sleep for 1 hour.
    .EXAMPLE
        PS> Start-AwtrixSleep -Seconds 60

        Puts the device to sleep for 1 minute.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Seconds,

        [Parameter()]
        [string]$BaseUri
    )

    if ($PSCmdlet.ShouldProcess('AWTRIX Device', "Sleep for $Seconds seconds")) {
        InvokeAwtrixApi -Endpoint 'sleep' -Method POST -Body @{ sleep = $Seconds } -BaseUri $BaseUri
    }
}
