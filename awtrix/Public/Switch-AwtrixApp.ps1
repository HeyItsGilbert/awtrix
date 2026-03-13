function Switch-AwtrixApp {
    <#
    .SYNOPSIS
        Switches the AWTRIX display to a different app.
    .DESCRIPTION
        Navigates to a specific app by name, or moves to the next or previous
        app in the display loop on the AWTRIX 3 device.

        Built-in app names: Time, Date, Temperature, Humidity, Battery.
        For custom apps, use the name assigned when creating the app.
    .PARAMETER Name
        The name of the app to switch to.
    .PARAMETER Next
        Switch to the next app in the loop.
    .PARAMETER Previous
        Switch to the previous app in the loop.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Switch-AwtrixApp -Name 'Time'

        Switches to the Time app.
    .EXAMPLE
        PS> Switch-AwtrixApp -Next

        Moves to the next app in the loop.
    .EXAMPLE
        PS> Switch-AwtrixApp -Previous

        Moves to the previous app in the loop.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSReviewUnusedParameter',
        '',
        Justification = 'Switches used as ParameterSetNames'
    )]
    [CmdletBinding(DefaultParameterSetName = 'ByName')]
    param(
        [Parameter(ParameterSetName = 'ByName', Mandatory, Position = 0)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Next', Mandatory)]
        [switch]$Next,

        [Parameter(ParameterSetName = 'Previous', Mandatory)]
        [switch]$Previous,

        [Parameter()]
        [string]$BaseUri
    )

    switch ($PSCmdlet.ParameterSetName) {
        'ByName' {
            InvokeAwtrixApi -Endpoint 'switch' -Method POST -Body @{ name = $Name } -BaseUri $BaseUri
        }
        'Next' {
            InvokeAwtrixApi -Endpoint 'nextapp' -Method POST -BaseUri $BaseUri
        }
        'Previous' {
            InvokeAwtrixApi -Endpoint 'previousapp' -Method POST -BaseUri $BaseUri
        }
    }
}
