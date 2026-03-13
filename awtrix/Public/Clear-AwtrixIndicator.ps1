function Clear-AwtrixIndicator {
    <#
    .SYNOPSIS
        Clears a colored indicator on the AWTRIX display.
    .DESCRIPTION
        Hides one of the three colored indicators on the AWTRIX 3 display
        by sending an empty payload to the indicator endpoint.
    .PARAMETER Position
        The indicator position to clear: Top (upper right), Middle (right side), or Bottom (lower right).
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Clear-AwtrixIndicator -Position Top

        Clears the top indicator (upper right corner).
    .EXAMPLE
        PS> [AwtrixIndicatorPosition].GetEnumValues() | ForEach-Object { Clear-AwtrixIndicator -Position $_ }

        Clears all three indicators.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [AwtrixIndicatorPosition]$Position,

        [Parameter()]
        [string]$BaseUri
    )

    InvokeAwtrixApi -Endpoint "indicator$([int]$Position)" -Method POST -BaseUri $BaseUri
}
