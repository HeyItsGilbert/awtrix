function Clear-AwtrixIndicator {
    <#
    .SYNOPSIS
        Clears a colored indicator on the AWTRIX display.
    .DESCRIPTION
        Hides one of the three colored indicators on the AWTRIX 3 display
        by sending an empty payload to the indicator endpoint.
    .PARAMETER Id
        The indicator number to clear (1, 2, or 3).
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Clear-AwtrixIndicator -Id 1

        Clears indicator 1 (upper right corner).
    .EXAMPLE
        PS> 1..3 | ForEach-Object { Clear-AwtrixIndicator -Id $_ }

        Clears all three indicators.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet(1, 2, 3)]
        [int]$Id,

        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint "indicator$Id" -Method POST -BaseUri $BaseUri
}
