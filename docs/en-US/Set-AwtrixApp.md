---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Set-AwtrixApp

## SYNOPSIS
Creates or updates a custom app on the AWTRIX device.

## SYNTAX

```
Set-AwtrixApp [-Name] <String> [[-Text] <Object>] [-TextCase <Int32>] [-TopText] [-TextOffset <Int32>]
 [-Center] [-Color <Object>] [-Gradient <Array>] [-BlinkTextMilliseconds <Int32>]
 [-FadeTextMilliseconds <Int32>] [-Background <Object>] [-Rainbow] [-Icon <String>] [-PushIcon <Int32>]
 [-Repeat <Int32>] [-DurationSeconds <Int32>] [-NoScroll] [-ScrollSpeed <Int32>] [-Effect <String>]
 [-EffectSettings <Hashtable>] [-Bar <Int32[]>] [-Line <Int32[]>] [-Autoscale] [-BarBackgroundColor <Object>]
 [-Progress <Int32>] [-ProgressColor <Object>] [-ProgressBackgroundColor <Object>] [-Draw <Array>]
 [-Overlay <String>] [-LifetimeSeconds <Int32>] [-LifetimeMode <Int32>] [-Position <Int32>] [-Save]
 [-BaseUri <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates or updates a custom app on the AWTRIX 3 device with text, icons, charts,
progress bars, drawing instructions, and visual effects.
The app is added to the
display loop and can be updated by sending new data to the same app name.

## EXAMPLES

### EXAMPLE 1
```
Set-AwtrixApp -Name 'myapp' -Text 'Hello World' -Rainbow -Duration 10
```

Creates an app with rainbow text displayed for 10 seconds.

### EXAMPLE 2
```
Set-AwtrixApp -Name 'temp' -Text '72°F' -Icon 'temperature' -Color '#FF6600'
```

Creates a temperature display app with an icon.

### EXAMPLE 3
```
Set-AwtrixApp -Name 'chart' -Bar @(1,5,3,8,2,6,4,7) -Color '#00FF00'
```

Creates a bar chart app.

### EXAMPLE 4
```
$drawings = @(
>>     New-AwtrixDrawing -Circle -X 28 -Y 4 -Radius 3 -Color '#FF0000'
>>     New-AwtrixDrawing -Text -X 0 -Y 0 -TextContent 'Hi' -Color '#00FF00'
>> )
PS> Set-AwtrixApp -Name 'custom' -Draw $drawings
```

Creates an app with custom drawing instructions.

## PARAMETERS

### -Name
The name of the custom app.
Used to identify the app for updates or removal.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
The text to display.
Can be a simple string or an array of colored text fragment
objects created by New-AwtrixTextFragment.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TextCase
Changes the uppercase setting.
0 = global setting, 1 = force uppercase, 2 = show as sent.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TopText
Draw the text on top of the display.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TextOffset
Sets an offset for the x position of the starting text.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Center
Centers a short, non-scrollable text.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
The text, bar, or line color.
Accepts a hex string (e.g., '#FF0000') or RGB array (e.g., @(255, 0, 0)).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Gradient
Colorizes text in a gradient of two colors.
Supply an array of two color values.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlinkTextMilliseconds
Blinks the text at the given interval in milliseconds. Not compatible with gradient or rainbow.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: BlinkTextMs

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FadeTextMilliseconds
Fades the text on and off at the given interval in milliseconds. Not compatible with gradient or rainbow.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FadeTextMs

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Background
Sets a background color.
Accepts a hex string or RGB array.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Rainbow
Fades each letter through the entire RGB spectrum.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
The icon ID or filename (without extension) to display.
Can also be a Base64-encoded 8x8 JPG.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PushIcon
Controls icon behavior: 0 = static, 1 = moves with text (once), 2 = moves with text (repeating).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repeat
Number of times the text scrolls before the app ends.
-1 for indefinite.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DurationSeconds
How long the app is displayed in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DurationSec

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoScroll
Disables text scrolling.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScrollSpeed
Modifies scroll speed as a percentage of the original speed.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Effect
Shows a background effect.
Send empty string to remove an existing effect.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EffectSettings
A hashtable to change color and speed of the background effect.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Bar
Draws a bar graph.
Maximum 16 values without icon, 11 with icon.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Line
Draws a line chart.
Maximum 16 values without icon, 11 with icon.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Autoscale
Enables or disables autoscaling for bar and line charts.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BarBackgroundColor
Background color of the bars.
Accepts a hex string or RGB array.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Progress
Shows a progress bar with value 0-100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressColor
The color of the progress bar.
Accepts a hex string or RGB array.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressBackgroundColor
The background color of the progress bar.
Accepts a hex string or RGB array.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Draw
Array of drawing instruction objects.
Use New-AwtrixDrawing to create them.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Overlay
Sets an effect overlay.
Options: clear, snow, rain, drizzle, storm, thunder, frost.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LifetimeSeconds
Removes the app if no update is received within this many seconds. 0 = disabled.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: LifetimeSec

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LifetimeMode
0 = delete the app when lifetime expires, 1 = mark as stale with red border.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Position
Position of the app in the loop (0-based).
Only applies on first push.
Experimental.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Save
Saves the app to flash memory, persisting across reboots.
Avoid for frequently updated apps.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BaseUri
The base URI of the AWTRIX device.
If not specified, uses the connection from Connect-Awtrix.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
