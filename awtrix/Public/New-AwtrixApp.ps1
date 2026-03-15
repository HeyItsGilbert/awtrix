function New-AwtrixApp {
    <#
    .SYNOPSIS
        Creates an AwtrixApp object, optionally pushing it to the device immediately.
    .DESCRIPTION
        Returns an [AwtrixApp] object that holds the full state of a custom AWTRIX app.
        The object can be modified, pushed to the device, cloned into templates, and
        serialized to/from JSON — all without additional API calls until you're ready.

        Use -Push to send the app to the device in the same call. Omit -Push to build
        the object locally first, set properties, then call $app.Push() when ready.
    .PARAMETER Name
        The unique app name used to identify and update the app on the device.
    .PARAMETER Text
        The text to display. A simple string or an array of colored fragment objects
        created by New-AwtrixTextFragment.
    .PARAMETER TextCase
        0 = global setting, 1 = force uppercase, 2 = show as sent.
    .PARAMETER TopText
        Draw text on top of the display.
    .PARAMETER TextOffset
        X-axis offset for the starting text position.
    .PARAMETER Center
        Centers a short, non-scrollable text.
    .PARAMETER Color
        Text, bar, or line color. Accepts a named color, hex string, or RGB array.
    .PARAMETER Gradient
        Colorizes text in a gradient of two colors.
    .PARAMETER BlinkTextMilliseconds
        Blinks the text at the given interval in ms. Not compatible with gradient or rainbow.
    .PARAMETER FadeTextMilliseconds
        Fades the text on and off at the given interval in ms. Not compatible with gradient or rainbow.
    .PARAMETER Background
        Background color. Accepts a named color, hex string, or RGB array.
    .PARAMETER Rainbow
        Fades each letter through the entire RGB spectrum.
    .PARAMETER Icon
        Icon ID, filename (without extension), or Base64-encoded 8x8 JPG.
    .PARAMETER PushIcon
        0 = static, 1 = moves with text once, 2 = moves with text repeatedly.
    .PARAMETER Repeat
        Number of times the text scrolls before the app ends. -1 = indefinite.
    .PARAMETER DurationSeconds
        How long the app is displayed in seconds.
    .PARAMETER NoScroll
        Disables text scrolling.
    .PARAMETER ScrollSpeed
        Scroll speed as a percentage of the original speed.
    .PARAMETER Effect
        Background effect name. Empty string removes an existing effect.
    .PARAMETER EffectSettings
        Hashtable to change color and speed of the background effect.
    .PARAMETER Bar
        Bar chart data. Max 16 values without icon, 11 with icon.
    .PARAMETER Line
        Line chart data. Max 16 values without icon, 11 with icon.
    .PARAMETER Autoscale
        Enables or disables auto-scaling for bar and line charts.
    .PARAMETER BarBackgroundColor
        Background color of bar chart bars.
    .PARAMETER Progress
        Progress bar value 0–100.
    .PARAMETER ProgressColor
        Progress bar foreground color.
    .PARAMETER ProgressBackgroundColor
        Progress bar background color.
    .PARAMETER Draw
        Array of drawing instruction objects. Use New-AwtrixDrawing to create them.
    .PARAMETER Overlay
        Effect overlay: clear, snow, rain, drizzle, storm, thunder, frost.
    .PARAMETER LifetimeSeconds
        Removes the app if no update is received within this many seconds. 0 = disabled.
    .PARAMETER LifetimeMode
        0 = delete app on expiry, 1 = mark as stale with red border.
    .PARAMETER Position
        0-based loop position. Applied only on first push. Experimental.
    .PARAMETER Save
        Persist app to flash memory across reboots. Avoid for frequently updated apps.
    .PARAMETER Push
        Send the app to the device immediately after creating the object.
    .PARAMETER BaseUri
        Base URI of the AWTRIX device. Overrides the module-level connection for this app.
    .EXAMPLE
        PS> $app = New-AwtrixApp -Name 'weather' -Icon 'temperature' -Color '#FF6600'
        PS> $app.Text = '72°F'
        PS> $app.Push()

        Creates an app object locally, sets text, then pushes to the device.
    .EXAMPLE
        PS> $app = New-AwtrixApp -Name 'greeting' -Text 'Hello!' -Rainbow -DurationSeconds 10 -Push

        Creates and immediately pushes an app with rainbow text.
    .EXAMPLE
        PS> $base = New-AwtrixApp -Icon 'temperature' -Color '#FF6600' -DurationSeconds 10
        PS> $indoor  = $base.Clone('temp_indoor');  $indoor.Text  = '72°F'; $indoor.Push()
        PS> $outdoor = $base.Clone('temp_outdoor'); $outdoor.Text = '45°F'; $outdoor.Push()

        Template pattern: clone a base configuration and push two variants.
    .EXAMPLE
        PS> $app = New-AwtrixApp -Name 'status' -Text 'OK' -Push
        PS> $app.ToJson() | Set-Content 'status.json'
        PS> $restored = [AwtrixApp]::FromJson((Get-Content 'status.json' -Raw))

        Serialize and restore an app configuration.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSReviewUnusedParameter', '',
        Justification = 'Parameters are applied via PSBoundParameters loop'
    )]
    [CmdletBinding()]
    [OutputType([AwtrixApp])]
    param(
        [Parameter(Position = 0)]
        [string]$Name,

        [Parameter(Position = 1)]
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
        [int]$Position,

        [Parameter()]
        [switch]$Save,

        [Parameter()]
        [switch]$Push,

        [Parameter()]
        [string]$BaseUri
    )

    $app = [AwtrixApp]::new()

    $skip = @('Push', 'BaseUri')
    $colorParams = @('Color', 'Gradient', 'Background', 'BarBackgroundColor', 'ProgressColor', 'ProgressBackgroundColor')
    foreach ($key in $PSBoundParameters.Keys) {
        if ($key -in $skip) { continue }
        $val = $PSBoundParameters[$key]
        if ($val -is [switch]) { $val = [bool]$val }
        # The color transform attribute uses unary comma (", $val") to preserve arrays
        # through parameter binding. Unwrap the outer single-element array before storing.
        if ($key -in $colorParams -and $val -is [array] -and $val.Count -eq 1 -and $val[0] -is [array]) {
            $val = $val[0]
        }
        $app.$key = $val
    }

    if ($PSBoundParameters.ContainsKey('BaseUri')) {
        $app._baseUri = $BaseUri
    }

    if ($Push) {
        $app.Push()
    }

    $app
}
