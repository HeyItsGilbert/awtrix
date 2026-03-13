function New-AwtrixTextFragment {
    <#
    .SYNOPSIS
        Creates a colored text fragment for AWTRIX notifications and apps.
    .DESCRIPTION
        Generates text fragment objects for use with the -Text parameter of
        Set-AwtrixApp or Send-AwtrixNotification. Each fragment has its own
        text and color, allowing multi-colored text display on the AWTRIX 3 device.
    .PARAMETER Text
        The text content for this fragment.
    .PARAMETER Color
        The hex color for this fragment (without # prefix), e.g., 'FF0000' for red.
    .EXAMPLE
        PS> New-AwtrixTextFragment -Text 'Hello' -Color 'FF0000'

        Creates a red text fragment containing 'Hello'.
    .EXAMPLE
        PS> $fragments = @(
        >>     New-AwtrixTextFragment -Text 'Error: ' -Color 'FF0000'
        >>     New-AwtrixTextFragment -Text 'disk full' -Color 'FFFFFF'
        >> )
        PS> Send-AwtrixNotification -Text $fragments

        Sends a notification with 'Error: ' in red and 'disk full' in white.
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Text,

        [Parameter(Mandatory, Position = 1)]
        [string]$Color
    )

    @{
        t = $Text
        c = $Color.TrimStart('#')
    }
}
