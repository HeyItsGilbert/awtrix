function Connect-Awtrix {
    <#
    .SYNOPSIS
        Connects to an AWTRIX device.
    .DESCRIPTION
        Establishes a connection to an AWTRIX 3 device by storing the base URI
        in the module scope. Validates the connection by retrieving device stats.
        Subsequent commands will use this connection unless -BaseUri is specified.
    .PARAMETER BaseUri
        The base URI or IP address of the AWTRIX device (e.g., '192.168.1.100' or 'http://192.168.1.100').
    .EXAMPLE
        PS> Connect-Awtrix -BaseUri '192.168.1.100'

        Connects to the AWTRIX device at 192.168.1.100 and returns device stats.
    .EXAMPLE
        PS> Connect-Awtrix -BaseUri 'http://awtrix.local'

        Connects using a hostname.
    #>
    [OutputType([PSCustomObject])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$BaseUri
    )

    if ($BaseUri -notmatch '^https?://') {
        $BaseUri = "http://$BaseUri"
    }
    $BaseUri = $BaseUri.TrimEnd('/')

    try {
        $stats = Invoke-RestMethod -Uri "$BaseUri/api/stats" -Method GET -ErrorAction Stop
    } catch {
        throw "Failed to connect to AWTRIX device at '$BaseUri': $($_.Exception.Message)"
    }

    $script:AwtrixConnection = @{
        BaseUri = $BaseUri
    }

    Write-Verbose "Connected to AWTRIX device at $BaseUri"
    $stats
}
