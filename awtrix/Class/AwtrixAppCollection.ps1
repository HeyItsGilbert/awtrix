# Represents a multi-page custom app group sent as an array to AWTRIX.
# The API assigns suffixes automatically: BaseName0, BaseName1, etc.
# Removing the BaseName prefix removes all pages in the group.
class AwtrixAppCollection {

    # Base name shared by all pages (no numeric suffix needed here).
    [string] $BaseName

    # Ordered array of AwtrixApp pages. Each page's Name property is ignored
    # on push — the device assigns suffixes from this array's order.
    [AwtrixApp[]] $Apps

    # Per-collection BaseUri override.
    hidden [string] $_baseUri

    # ── Constructors ─────────────────────────────────────────────────────────
    AwtrixAppCollection() {}

    AwtrixAppCollection([string]$baseName, [AwtrixApp[]]$apps) {
        $this.BaseName = $baseName
        $this.Apps = $apps
    }

    # ── Push — sends the array payload in one request ─────────────────────────
    # AWTRIX handles suffix assignment internally when an array is POSTed to
    # /api/custom?name=<BaseName>.
    [void] Push() {
        if ([string]::IsNullOrWhiteSpace($this.BaseName)) {
            throw 'AwtrixAppCollection.BaseName must be set before calling Push().'
        }
        if ($null -eq $this.Apps -or $this.Apps.Count -eq 0) {
            throw 'AwtrixAppCollection.Apps must contain at least one page.'
        }
        # Build an array of payload hashtables — one per page.
        $pages = @($this.Apps | ForEach-Object { $_.ToPayload() })
        & ([AwtrixAppBase]::InvokeApi) -Endpoint 'custom' -Method POST `
            -Body $pages -QueryString "name=$($this.BaseName)" -BaseUri $this._baseUri
    }

    # ── Remove — deletes all pages by sending an empty payload ────────────────
    [void] Remove() {
        if ([string]::IsNullOrWhiteSpace($this.BaseName)) {
            throw 'AwtrixAppCollection.BaseName must be set before calling Remove().'
        }
        & ([AwtrixAppBase]::InvokeApi) -Endpoint 'custom' -Method POST `
            -QueryString "name=$($this.BaseName)" -BaseUri $this._baseUri
    }
}
