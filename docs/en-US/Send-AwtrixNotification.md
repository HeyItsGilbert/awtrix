---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Send-AwtrixNotification

## SYNOPSIS
Sends a one-time notification to the AWTRIX device.

## SYNTAX

```
Send-AwtrixNotification [[-Text] <Object>] [-TextCase <Int32>] [-TopText] [-TextOffset <Int32>] [-Center]
 [-Color <Object>] [-Gradient <Array>] [-BlinkText <Int32>] [-FadeText <Int32>] [-Background <Object>]
 [-Rainbow] [-Icon <String>] [-PushIcon <Int32>] [-Repeat <Int32>] [-Duration <Int32>] [-Hold]
 [-Sound <String>] [-Rtttl <String>] [-LoopSound] [-Stack] [-Wakeup] [-Clients <String[]>] [-NoScroll]
 [-ScrollSpeed <Int32>] [-Effect <String>] [-EffectSettings <Hashtable>] [-Bar <Int32[]>] [-Line <Int32[]>]
 [-Autoscale] [-BarBackgroundColor <Object>] [-Progress <Int32>] [-ProgressColor <Object>]
 [-ProgressBackgroundColor <Object>] [-Draw <Array>] [-Overlay <String>] [-BaseUri <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Displays a one-time notification on the AWTRIX 3 device that interrupts the current
app loop.
Supports the same visual options as custom apps, plus notification-specific
features like hold, sound, wake-up, stacking, and client forwarding.

## EXAMPLES

### EXAMPLE 1
```
Send-AwtrixNotification -Text 'Alert!' -Color '#FF0000' -Sound 'alarm'
```

Sends a red notification with an alarm sound.

### EXAMPLE 2
```
Send-AwtrixNotification -Text 'Important' -Hold -Icon 'warning'
```

Sends a held notification that stays until dismissed.

### EXAMPLE 3
```
Send-AwtrixNotification -Text 'Wake up!' -Wakeup -Duration 15
```

Sends a notification that wakes the display for 15 seconds.

### EXAMPLE 4
```
$fragments = @(
>>     New-AwtrixTextFragment -Text 'Error: ' -Color 'FF0000'
>>     New-AwtrixTextFragment -Text 'disk full' -Color 'FFFFFF'
>> )
PS> Send-AwtrixNotification -Text $fragments -Duration 10
```

Sends a notification with colored text fragments.

## PARAMETERS

### -Text
The text to display.
Can be a simple string or an array of colored text fragment
objects created by New-AwtrixTextFragment.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

### -Gradient
Colorizes text in a gradient of two colors.

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

### -BlinkText
Blinks the text at the given interval in milliseconds.
Not compatible with gradient or rainbow.

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

### -FadeText
Fades the text on and off at the given interval in milliseconds.
Not compatible with gradient or rainbow.

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
Number of times the text scrolls before the notification ends.

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

### -Duration
How long the notification is displayed in seconds.

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

### -Hold
Holds the notification on top until dismissed via the middle button or Clear-AwtrixNotification.

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

### -Sound
The filename of an RTTTL ringtone (without extension) from the MELODIES folder,
or the 4-digit number of an MP3 file for DFplayer.

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

### -Rtttl
An RTTTL sound string to play inline with the notification.

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

### -LoopSound
Loops the sound or RTTTL as long as the notification is running.

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

### -Stack
If false, immediately replaces the current notification instead of stacking.
Default is true.

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

### -Wakeup
Wakes up the matrix if it is off for the duration of the notification.

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

### -Clients
Array of AWTRIX device IP addresses to forward this notification to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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
