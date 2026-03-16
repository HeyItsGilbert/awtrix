function New-AwtrixNotification {
    <#
    .SYNOPSIS
        Creates an AwtrixNotification object for deferred or reusable dispatch.
    .DESCRIPTION
        Returns an [AwtrixNotification] object that holds all properties of a one-time
        AWTRIX notification. Call .Send() when you're ready to dispatch it, or pass
        -Send to dispatch immediately.

        Storing the object lets you build reusable notification templates that can be
        cloned and customized without reconstructing every property each time.
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
        Blinks the text at the given interval in ms.
    .PARAMETER FadeTextMilliseconds
        Fades the text on and off at the given interval in ms.
    .PARAMETER Background
        Background color.
    .PARAMETER Rainbow
        Fades each letter through the entire RGB spectrum.
    .PARAMETER Icon
        Icon ID, filename (without extension), or Base64-encoded 8x8 JPG.
    .PARAMETER PushIcon
        0 = static, 1 = moves with text once, 2 = moves with text repeatedly.
    .PARAMETER Repeat
        Number of times the text scrolls before the notification ends.
    .PARAMETER DurationSeconds
        How long the notification is displayed in seconds.
    .PARAMETER Hold
        Keep the notification on screen until dismissed via the middle button or
        Clear-AwtrixNotification.
    .PARAMETER Sound
        RTTTL ringtone filename (no extension) from the MELODIES folder, or a
        4-digit DFplayer MP3 number.
    .PARAMETER Rtttl
        Inline RTTTL sound string played with the notification.
    .PARAMETER LoopSound
        Loop the sound or RTTTL for the duration of the notification.
    .PARAMETER Stack
        Stack this notification (true) or immediately replace the current one (false).
    .PARAMETER Wakeup
        Wake the matrix if it is off for the duration of this notification.
    .PARAMETER Clients
        Additional AWTRIX device IP addresses to forward this notification to.
    .PARAMETER NoScroll
        Disables text scrolling.
    .PARAMETER ScrollSpeed
        Scroll speed as a percentage of the original speed.
    .PARAMETER Effect
        Background effect name.
    .PARAMETER EffectSettings
        Hashtable to change color and speed of the background effect.
    .PARAMETER Bar
        Bar chart data.
    .PARAMETER Line
        Line chart data.
    .PARAMETER Autoscale
        Auto-scale bar and line chart axes.
    .PARAMETER BarBackgroundColor
        Background color of bar chart bars.
    .PARAMETER Progress
        Progress bar value 0–100.
    .PARAMETER ProgressColor
        Progress bar foreground color.
    .PARAMETER ProgressBackgroundColor
        Progress bar background color.
    .PARAMETER Draw
        Array of drawing instruction objects.
    .PARAMETER Overlay
        Effect overlay: clear, snow, rain, drizzle, storm, thunder, frost.
    .PARAMETER Send
        Dispatch the notification to the device immediately after creating the object.
    .PARAMETER BaseUri
        Base URI of the AWTRIX device. Overrides the module-level connection.
    .EXAMPLE
        PS> $alert = New-AwtrixNotification -Text 'Alert!' -Color Red -Sound 'alarm' -Hold
        PS> $alert.Send()

        Builds a reusable alert notification and sends it on demand.
    .EXAMPLE
        PS> $template = New-AwtrixNotification -Icon 'warning' -Color '#FF0000' -DurationSeconds 5
        PS> $disk  = $template.Clone(); $disk.Text  = 'Disk full!';    $disk.Send()
        PS> $net   = $template.Clone(); $net.Text   = 'Network down!'; $net.Send()

        Template pattern: clone a base notification, customize text, send.
    .EXAMPLE
        PS> New-AwtrixNotification -Text 'Done!' -Rainbow -Send

        Inline: create and immediately send.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSReviewUnusedParameter', '',
        Justification = 'Parameters are applied via PSBoundParameters loop'
    )]
    [CmdletBinding()]
    [OutputType([AwtrixNotification])]
    param(
        [Parameter(Position = 0)]
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
        [switch]$Hold,

        [Parameter()]
        [string]$Sound,

        [Parameter()]
        [string]$Rtttl,

        [Parameter()]
        [switch]$LoopSound,

        [Parameter()]
        [switch]$Stack,

        [Parameter()]
        [switch]$Wakeup,

        [Parameter()]
        [string[]]$Clients,

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
        [switch]$Send,

        [Parameter()]
        [string]$BaseUri
    )

    $notif = [AwtrixNotification]::new()

    $skip = @('Send', 'BaseUri')
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
        $notif.$key = $val
    }

    if ($PSBoundParameters.ContainsKey('BaseUri')) {
        $notif._baseUri = $BaseUri
    }

    if ($Send) {
        $notif.Send()
    }

    $notif
}
