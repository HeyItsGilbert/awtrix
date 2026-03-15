function InvokeAwtrixApi {
    <#
    .SYNOPSIS
        Central HTTP wrapper for AWTRIX API calls.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Endpoint,

        [Parameter()]
        [ValidateSet('GET', 'POST')]
        [string]$Method = 'GET',

        [Parameter()]
        $Body,

        [Parameter()]
        [string]$RawBody,

        [Parameter()]
        [string]$QueryString,

        [Parameter()]
        [string]$BaseUri
    )

    $connection = GetAwtrixConnection -BaseUri $BaseUri
    $uri = '{0}/api/{1}' -f $connection.BaseUri, $Endpoint.TrimStart('/')

    if ($QueryString) {
        $uri = '{0}?{1}' -f $uri, $QueryString
    }

    $params = @{
        Uri = $uri
        Method = $Method
        ErrorAction = 'Stop'
    }

    if ($Body -and $Body.Count -gt 0) {
        $params['Body'] = $Body | ConvertTo-Json -Depth 10 -Compress
        $params['ContentType'] = 'application/json'
    } elseif ($RawBody) {
        $params['Body'] = $RawBody
        $params['ContentType'] = 'text/plain'
    }

    try {
        Write-Verbose "AWTRIX API: $Method $uri"
        Invoke-RestMethod @params
    } catch {
        $statusCode = $null
        if ($_.Exception.Response) {
            $statusCode = [int]$_.Exception.Response.StatusCode
        }
        $message = "AWTRIX API error calling $Method $uri"
        if ($statusCode) {
            $message += " (HTTP $statusCode)"
        }
        Write-Error "$message : $($_.Exception.Message)"
    }
}
