function Remove-AwtrixApp {
    <#
    .SYNOPSIS
        Removes a custom app from the AWTRIX device.
    .DESCRIPTION
        Deletes a custom app from the AWTRIX 3 device by sending an empty payload to its endpoint.
        When deleting, AWTRIX matches apps that start with the specified name,
        so removing 'test' will also remove 'test0', 'test1', etc.
    .PARAMETER Name
        The name of the custom app to remove.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Remove-AwtrixApp -Name 'myapp'

        Removes the custom app named 'myapp'.
    .EXAMPLE
        PS> Remove-AwtrixApp -Name 'test'

        Removes all apps starting with 'test' (test0, test1, etc.).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name,

        [Parameter()]
        [string]$BaseUri
    )

    if ($PSCmdlet.ShouldProcess("Custom App '$Name'", 'Remove')) {
        InvokeAwtrixApi -Endpoint 'custom' -Method POST -QueryString "name=$Name" -BaseUri $BaseUri
    }
}
