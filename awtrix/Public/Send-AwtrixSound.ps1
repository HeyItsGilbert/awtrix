function Send-AwtrixSound {
    <#
    .SYNOPSIS
        Plays a sound on the AWTRIX device.
    .DESCRIPTION
        Plays an RTTTL sound from the MELODIES folder on the AWTRIX 3 device.
        If using a DFplayer, specify the 4-digit number of the MP3 file.
    .PARAMETER Sound
        The filename of the RTTTL ringtone (without extension) from the MELODIES folder,
        or the 4-digit number of an MP3 file if using a DFplayer.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Send-AwtrixSound -Sound 'alarm'

        Plays the 'alarm' melody from the MELODIES folder.
    .EXAMPLE
        PS> Send-AwtrixSound -Sound '0001'

        Plays MP3 file 0001 on DFplayer.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Sound,

        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint 'sound' -Method POST -Body @{ sound = $Sound } -BaseUri $BaseUri
}
