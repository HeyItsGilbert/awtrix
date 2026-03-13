function ConvertColorInput {
    <#
    .SYNOPSIS
        Normalizes color input for the AWTRIX API.
    #>
    [CmdletBinding()]
    [OutputType([string], [object[]])]
    param(
        [Parameter(Mandatory)]
        $Color
    )

    # Pass through arrays as-is (RGB)
    if ($Color -is [array]) {
        return , $Color
    }

    # Pass through strings (hex or '0' for hide)
    if ($Color -is [string]) {
        return $Color
    }

    # Integer 0 used to hide indicators
    if ($Color -is [int] -and $Color -eq 0) {
        return '0'
    }

    return $Color
}
