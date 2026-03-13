function Send-AwtrixRtttl {
    <#
    .SYNOPSIS
        Plays an RTTTL melody string on the AWTRIX device.
    .DESCRIPTION
        Plays a Ring Tone Text Transfer Language (RTTTL) melody from a given
        RTTTL string directly on the AWTRIX 3 device, without needing a file stored on the device.
    .PARAMETER RtttlString
        The RTTTL format string to play.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Send-AwtrixRtttl -RtttlString 'Super Mario:d=4,o=5,b=100:16e6,16e6,32p,8e6,16c6,8e6,8g6'

        Plays the Super Mario theme.
    .EXAMPLE
        PS> Send-AwtrixRtttl 'TakeOnMe:d=4,o=4,b=160:8f#5,8f#5,8f#5,8d5,8p'

        Plays a Take On Me snippet using positional parameter.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$RtttlString,

        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'rtttl' -Method POST -RawBody $RtttlString -BaseUri $BaseUri
}
