function GetAwtrixConnection {
    <#
    .SYNOPSIS
        Resolves the AWTRIX connection URI.
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$BaseUri
    )

    if ($BaseUri) {
        if ($BaseUri -notmatch '^https?://') {
            $BaseUri = "http://$BaseUri"
        }
        return @{ BaseUri = $BaseUri.TrimEnd('/') }
    }

    if ($script:AwtrixConnection) {
        return $script:AwtrixConnection
    }

    throw 'Not connected to an AWTRIX device. Use Connect-Awtrix or specify -BaseUri.'
}
