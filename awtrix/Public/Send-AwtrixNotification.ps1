function Send-AwtrixNotification {
    <#
    .SYNOPSIS
        Sends a one-time notification to the AWTRIX device.
    .DESCRIPTION
        Displays a one-time notification on the AWTRIX 3 device that interrupts the current
        app loop. Supports the same visual options as custom apps, plus notification-specific
        features like hold, sound, wake-up, stacking, and client forwarding.
    .PARAMETER Text
        The text to display. Can be a simple string or an array of colored text fragment
        objects created by New-AwtrixTextFragment.
    .PARAMETER TextCase
        Changes the uppercase setting. 0 = global setting, 1 = force uppercase, 2 = show as sent.
    .PARAMETER TopText
        Draw the text on top of the display.
    .PARAMETER TextOffset
        Sets an offset for the x position of the starting text.
    .PARAMETER Center
        Centers a short, non-scrollable text.
    .PARAMETER Color
        The text, bar, or line color. Accepts a named color (e.g., Red, Green, Blue),
        a hex string, or an RGB array.
    .PARAMETER Gradient
        Colorizes text in a gradient of two colors.
    .PARAMETER BlinkTextMilliseconds
        Blinks the text at the given interval in milliseconds. Not compatible with gradient or rainbow.
    .PARAMETER FadeTextMilliseconds
        Fades the text on and off at the given interval in milliseconds. Not compatible with gradient or rainbow.
    .PARAMETER Background
        Sets a background color. Accepts a named color, hex string, or RGB array.
    .PARAMETER Rainbow
        Fades each letter through the entire RGB spectrum.
    .PARAMETER Icon
        The icon ID or filename (without extension) to display. Can also be a Base64-encoded 8x8 JPG.
    .PARAMETER PushIcon
        Controls icon behavior: 0 = static, 1 = moves with text (once), 2 = moves with text (repeating).
    .PARAMETER Repeat
        Number of times the text scrolls before the notification ends.
    .PARAMETER DurationSeconds
        How long the notification is displayed in seconds.
    .PARAMETER Hold
        Holds the notification on top until dismissed via the middle button or Clear-AwtrixNotification.
    .PARAMETER Sound
        The filename of an RTTTL ringtone (without extension) from the MELODIES folder,
        or the 4-digit number of an MP3 file for DFplayer.
    .PARAMETER Rtttl
        An RTTTL sound string to play inline with the notification.
    .PARAMETER LoopSound
        Loops the sound or RTTTL as long as the notification is running.
    .PARAMETER Stack
        If false, immediately replaces the current notification instead of stacking. Default is true.
    .PARAMETER Wakeup
        Wakes up the matrix if it is off for the duration of the notification.
    .PARAMETER Clients
        Array of AWTRIX device IP addresses to forward this notification to.
    .PARAMETER NoScroll
        Disables text scrolling.
    .PARAMETER ScrollSpeed
        Modifies scroll speed as a percentage of the original speed.
    .PARAMETER Effect
        Shows a background effect.
    .PARAMETER EffectSettings
        A hashtable to change color and speed of the background effect.
    .PARAMETER Bar
        Draws a bar graph. Maximum 16 values without icon, 11 with icon.
    .PARAMETER Line
        Draws a line chart. Maximum 16 values without icon, 11 with icon.
    .PARAMETER Autoscale
        Enables or disables autoscaling for bar and line charts.
    .PARAMETER BarBackgroundColor
        Background color of the bars. Accepts a named color, hex string, or RGB array.
    .PARAMETER Progress
        Shows a progress bar with value 0-100.
    .PARAMETER ProgressColor
        The color of the progress bar. Accepts a named color, hex string, or RGB array.
    .PARAMETER ProgressBackgroundColor
        The background color of the progress bar. Accepts a named color, hex string, or RGB array.
    .PARAMETER Draw
        Array of drawing instruction objects. Use New-AwtrixDrawing to create them.
    .PARAMETER Overlay
        Sets an effect overlay. Options: clear, snow, rain, drizzle, storm, thunder, frost.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Send-AwtrixNotification -Text 'Alert!' -Color '#FF0000' -Sound 'alarm'

        Sends a red notification with an alarm sound.
    .EXAMPLE
        PS> Send-AwtrixNotification -Text 'Important' -Hold -Icon 'warning'

        Sends a held notification that stays until dismissed.
    .EXAMPLE
        PS> Send-AwtrixNotification -Text 'Wake up!' -Wakeup -DurationSeconds 15

        Sends a notification that wakes the display for 15 seconds.
    .EXAMPLE
        PS> $fragments = @(
        >>     New-AwtrixTextFragment -Text 'Error: ' -Color 'FF0000'
        >>     New-AwtrixTextFragment -Text 'disk full' -Color 'FFFFFF'
        >> )
        PS> Send-AwtrixNotification -Text $fragments -DurationSeconds 10

        Sends a notification with colored text fragments.
    #>
    [CmdletBinding()]
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
        [string]$BaseUri
    )

    $body = NewAppPayload -BoundParameters $PSBoundParameters
    InvokeAwtrixApi -Endpoint 'notify' -Method POST -Body $body -BaseUri $BaseUri
}
