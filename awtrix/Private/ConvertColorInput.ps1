function ConvertColorInput {
    <#
    .SYNOPSIS
        Normalizes color input for the AWTRIX API.
    .DESCRIPTION
        Delegates to AwtrixColorTransformAttribute.ConvertColor for consistent
        color resolution across the module. Accepts named colors, hex strings,
        and RGB arrays.
    #>
    [CmdletBinding()]
    [OutputType([string], [object[]])]
    param(
        [Parameter(Mandatory)]
        $Color
    )

    return [AwtrixColorTransformAttribute]::ConvertColor($Color)
}
