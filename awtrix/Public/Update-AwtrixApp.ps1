function Update-AwtrixApp {
    <#
    .SYNOPSIS
        Updates properties of an AwtrixApp object and pushes the changes to the device.
    .DESCRIPTION
        Accepts an [AwtrixApp] object from the pipeline (or directly), applies any
        specified property overrides, then calls Push() to send the update to the device.

        Use -DirtyOnly to send only the properties that changed since the last push,
        minimising the payload sent over the network. Use -PassThru to get the updated
        object back for further chaining.

        The InputObject is mutated in place so the caller's variable reflects the
        latest state after the update.
    .PARAMETER InputObject
        The AwtrixApp object to update. Accepts pipeline input.
    .PARAMETER Text
        New text value.
    .PARAMETER TextCase
        0 = global setting, 1 = force uppercase, 2 = show as sent.
    .PARAMETER TopText
        Draw text on top of the display.
    .PARAMETER TextOffset
        X-axis offset for the starting text position.
    .PARAMETER Center
        Centers a short, non-scrollable text.
    .PARAMETER Color
        Text, bar, or line color.
    .PARAMETER Gradient
        Two-color text gradient.
    .PARAMETER BlinkTextMilliseconds
        Blink interval in ms.
    .PARAMETER FadeTextMilliseconds
        Fade interval in ms.
    .PARAMETER Background
        Background color.
    .PARAMETER Rainbow
        Fade each letter through the RGB spectrum.
    .PARAMETER Icon
        Icon ID, filename, or Base64 8x8 JPG.
    .PARAMETER PushIcon
        0 = static, 1 = moves once, 2 = moves repeatedly.
    .PARAMETER Repeat
        Scroll count before app ends.
    .PARAMETER DurationSeconds
        Display duration in seconds.
    .PARAMETER NoScroll
        Disable text scrolling.
    .PARAMETER ScrollSpeed
        Scroll speed percentage.
    .PARAMETER Effect
        Background effect name.
    .PARAMETER EffectSettings
        Effect color/speed overrides.
    .PARAMETER Bar
        Bar chart data.
    .PARAMETER Line
        Line chart data.
    .PARAMETER Autoscale
        Auto-scale chart axes.
    .PARAMETER BarBackgroundColor
        Bar background color.
    .PARAMETER Progress
        Progress bar value 0–100.
    .PARAMETER ProgressColor
        Progress bar foreground color.
    .PARAMETER ProgressBackgroundColor
        Progress bar background color.
    .PARAMETER Draw
        Drawing instructions array.
    .PARAMETER Overlay
        Effect overlay.
    .PARAMETER LifetimeSeconds
        Auto-remove timeout in seconds.
    .PARAMETER LifetimeMode
        0 = delete on expiry, 1 = stale indicator.
    .PARAMETER Save
        Persist to flash.
    .PARAMETER DirtyOnly
        Send only properties that changed since the last Push(). If this is the first
        push since the object was created, the full payload is sent.
    .PARAMETER PassThru
        Return the updated AwtrixApp object.
    .PARAMETER BaseUri
        Override the device URI for this push. Does not persist on the object.
    .EXAMPLE
        PS> $app | Update-AwtrixApp -Text '68°F'

        Pipes an existing app object, updates its text, and pushes.
    .EXAMPLE
        PS> $app | Update-AwtrixApp -Text '68°F' -DirtyOnly -PassThru | Select-Object Name, Text

        Updates text, pushes dirty payload only, returns updated object.
    .EXAMPLE
        PS> Get-Variable -Name 'app*' -ValueOnly | Update-AwtrixApp -DurationSeconds 5

        Update duration on multiple app objects at once via pipeline.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSReviewUnusedParameter', '',
        Justification = 'Parameters are applied via PSBoundParameters loop'
    )]
    [CmdletBinding()]
    [OutputType([AwtrixApp])]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [AwtrixApp]$InputObject,

        [Parameter()]
        $Text,

        [Parameter()]
        [ValidateSet(0, 1, 2)]
        [int]$TextCase,

        [Parameter()]
        [switch]$TopText,

        [Parameter()]
        [int]$TextOffset,

        [Parameter()]
        [switch]$Center,

        [Parameter()]
        [AwtrixColorTransform()]
        $Color,

        [Parameter()]
        [AwtrixColorTransform()]
        [array]$Gradient,

        [Parameter()]
        [Alias('BlinkTextMs')]
        [int]$BlinkTextMilliseconds,

        [Parameter()]
        [Alias('FadeTextMs')]
        [int]$FadeTextMilliseconds,

        [Parameter()]
        [AwtrixColorTransform()]
        $Background,

        [Parameter()]
        [switch]$Rainbow,

        [Parameter()]
        [string]$Icon,

        [Parameter()]
        [ValidateSet(0, 1, 2)]
        [int]$PushIcon,

        [Parameter()]
        [int]$Repeat,

        [Parameter()]
        [Alias('DurationSec')]
        [int]$DurationSeconds,

        [Parameter()]
        [switch]$NoScroll,

        [Parameter()]
        [int]$ScrollSpeed,

        [Parameter()]
        [string]$Effect,

        [Parameter()]
        [hashtable]$EffectSettings,

        [Parameter()]
        [int[]]$Bar,

        [Parameter()]
        [int[]]$Line,

        [Parameter()]
        [switch]$Autoscale,

        [Parameter()]
        [AwtrixColorTransform()]
        $BarBackgroundColor,

        [Parameter()]
        [ValidateRange(0, 100)]
        [int]$Progress,

        [Parameter()]
        [AwtrixColorTransform()]
        $ProgressColor,

        [Parameter()]
        [AwtrixColorTransform()]
        $ProgressBackgroundColor,

        [Parameter()]
        [array]$Draw,

        [Parameter()]
        [ValidateSet('clear', 'snow', 'rain', 'drizzle', 'storm', 'thunder', 'frost', '')]
        [string]$Overlay,

        [Parameter()]
        [Alias('LifetimeSec')]
        [int]$LifetimeSeconds,

        [Parameter()]
        [ValidateSet(0, 1)]
        [int]$LifetimeMode,

        [Parameter()]
        [switch]$Save,

        [Parameter()]
        [switch]$DirtyOnly,

        [Parameter()]
        [switch]$PassThru,

        [Parameter()]
        [string]$BaseUri
    )

    process {
        $skip = @('InputObject', 'DirtyOnly', 'PassThru', 'BaseUri')
        foreach ($key in $PSBoundParameters.Keys) {
            if ($key -in $skip) { continue }
            $val = $PSBoundParameters[$key]
            if ($val -is [switch]) { $val = [bool]$val }
            $InputObject.$key = $val
        }

        # Resolve BaseUri: use explicit override for this call, or fall back to object's stored URI.
        $resolvedUri = if ($PSBoundParameters.ContainsKey('BaseUri')) { $BaseUri } else { $InputObject._baseUri }

        $InputObject.Push($DirtyOnly.IsPresent)

        # Restore the original _baseUri in case we applied a one-time override above.
        $InputObject._baseUri = $resolvedUri

        if ($PassThru) {
            $InputObject
        }
    }
}
