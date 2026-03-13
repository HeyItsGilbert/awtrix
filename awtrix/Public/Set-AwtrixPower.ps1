function Set-AwtrixPower {
    <#
    .SYNOPSIS
        Toggles the AWTRIX matrix display on or off.
    .DESCRIPTION
        Controls the power state of the AWTRIX 3 LED matrix. Turning off
        the matrix stops the display but keeps the device running.
    .PARAMETER On
        Turns the matrix display on.
    .PARAMETER Off
        Turns the matrix display off.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Set-AwtrixPower -On

        Turns on the matrix display.
    .EXAMPLE
        PS> Set-AwtrixPower -Off

        Turns off the matrix display.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSReviewUnusedParameter',
        '',
        Justification = 'Switches used as ParameterSetNames'
    )]
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'On')]
    param(
        [Parameter(ParameterSetName = 'On', Mandatory)]
        [switch]$On,

        [Parameter(ParameterSetName = 'Off', Mandatory)]
        [switch]$Off,

        [Parameter()]
        [string]$BaseUri
    )

    $powerState = $PSCmdlet.ParameterSetName -eq 'On'
    $stateLabel = if ($powerState) { 'On' } else { 'Off' }

    if ($PSCmdlet.ShouldProcess('AWTRIX Matrix', "Set power $stateLabel")) {
        InvokeAwtrixApi -Endpoint 'power' -Method POST -Body @{ power = $powerState } -BaseUri $BaseUri
    }
}
