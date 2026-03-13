function Set-AwtrixApp {
    <#
    .SYNOPSIS
        Creates or updates a custom app on the AWTRIX device.
    .DESCRIPTION
        Creates or updates a custom app on the AWTRIX 3 device with text, icons, charts,
        progress bars, drawing instructions, and visual effects. The app is added to the
        display loop and can be updated by sending new data to the same app name.
    .PARAMETER Name
        The name of the custom app. Used to identify the app for updates or removal.
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
        a hex string (e.g., '#FF0000'), or an RGB array (e.g., @(255, 0, 0)).
    .PARAMETER Gradient
        Colorizes text in a gradient of two colors. Supply an array of two color values.
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
        Number of times the text scrolls before the app ends. -1 for indefinite.
    .PARAMETER DurationSeconds
        How long the app is displayed in seconds.
    .PARAMETER NoScroll
        Disables text scrolling.
    .PARAMETER ScrollSpeed
        Modifies scroll speed as a percentage of the original speed.
    .PARAMETER Effect
        Shows a background effect. Send empty string to remove an existing effect.
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
    .PARAMETER LifetimeSeconds
        Removes the app if no update is received within this many seconds. 0 = disabled.
    .PARAMETER LifetimeMode
        0 = delete the app when lifetime expires, 1 = mark as stale with red border.
    .PARAMETER Position
        Position of the app in the loop (0-based). Only applies on first push. Experimental.
    .PARAMETER Save
        Saves the app to flash memory, persisting across reboots. Avoid for frequently updated apps.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Set-AwtrixApp -Name 'myapp' -Text 'Hello World' -Rainbow -DurationSeconds 10

        Creates an app with rainbow text displayed for 10 seconds.
    .EXAMPLE
        PS> Set-AwtrixApp -Name 'temp' -Text '72°F' -Icon 'temperature' -Color '#FF6600'

        Creates a temperature display app with an icon.
    .EXAMPLE
        PS> Set-AwtrixApp -Name 'chart' -Bar @(1,5,3,8,2,6,4,7) -Color '#00FF00'

        Creates a bar chart app.
    .EXAMPLE
        PS> $drawings = @(
        >>     New-AwtrixDrawing -Circle -X 28 -Y 4 -Radius 3 -Color '#FF0000'
        >>     New-AwtrixDrawing -Text -X 0 -Y 0 -TextContent 'Hi' -Color '#00FF00'
        >> )
        PS> Set-AwtrixApp -Name 'custom' -Draw $drawings

        Creates an app with custom drawing instructions.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSReviewUnusedParameter',
        '',
        Justification = 'Switches used as ParameterSetNames'
    )]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
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
        [string]$BaseUri
    )

    $body = NewAppPayload -BoundParameters $PSBoundParameters
    InvokeAwtrixApi -Endpoint 'custom' -Method POST -Body $body -QueryString "name=$Name" -BaseUri $BaseUri
}
