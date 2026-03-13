function Disconnect-Awtrix {
    <#
    .SYNOPSIS
        Disconnects from the current AWTRIX device.
    .DESCRIPTION
        Clears the stored AWTRIX connection from the module scope.
        After disconnecting, commands will require -BaseUri or a new Connect-Awtrix call.
    .EXAMPLE
        PS> Disconnect-Awtrix

        Disconnects from the current AWTRIX device.
    #>
    [CmdletBinding()]
    param()

    $script:AwtrixConnection = $null
    Write-Verbose 'Disconnected from AWTRIX device'
}
