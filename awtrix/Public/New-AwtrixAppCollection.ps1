function New-AwtrixAppCollection {
    <#
    .SYNOPSIS
        Creates an AwtrixAppCollection for multi-page custom app groups.
    .DESCRIPTION
        Wraps multiple AwtrixApp pages under a shared base name. AWTRIX 3 automatically
        assigns numeric suffixes (BaseName0, BaseName1, …) when an array is sent to
        the API. Use Push() to send all pages at once, or Remove() to delete the group.
    .PARAMETER BaseName
        The shared base name for all pages in the collection.
    .PARAMETER Apps
        Ordered array of AwtrixApp objects representing each page.
    .PARAMETER Push
        Send the collection to the device immediately after creating the object.
    .PARAMETER BaseUri
        Base URI of the AWTRIX device. Overrides the module-level connection.
    .EXAMPLE
        PS> $p1 = New-AwtrixApp -Text 'Page 1' -DurationSeconds 5
        PS> $p2 = New-AwtrixApp -Text 'Page 2' -Color Red -DurationSeconds 5
        PS> $c  = New-AwtrixAppCollection -BaseName 'dashboard' -Apps @($p1, $p2) -Push

        Creates a two-page dashboard group and immediately pushes it.
    .EXAMPLE
        PS> $collection = New-AwtrixAppCollection -BaseName 'report' -Apps $pages
        PS> # ... later, after data changes ...
        PS> $collection.Push()

        Builds a collection, then pushes when you're ready.
    .EXAMPLE
        PS> $collection.Remove()

        Removes all pages in the group from the device.
    #>
    [CmdletBinding()]
    [OutputType([AwtrixAppCollection])]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$BaseName,

        [Parameter(Mandatory, Position = 1)]
        [AwtrixApp[]]$Apps,

        [Parameter()]
        [switch]$Push,

        [Parameter()]
        [string]$BaseUri
    )

    $collection = [AwtrixAppCollection]::new($BaseName, $Apps)

    if ($PSBoundParameters.ContainsKey('BaseUri')) {
        $collection._baseUri = $BaseUri
    }

    if ($Push) {
        $collection.Push()
    }

    $collection
}
