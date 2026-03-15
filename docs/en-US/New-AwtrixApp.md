---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# New-AwtrixApp

## SYNOPSIS
Creates an AwtrixApp object, optionally pushing it to the device immediately.

## SYNTAX

```
New-AwtrixApp [[-Name] <String>] [[-Text] <Object>] [-TextCase <Int32>] [-TopText] [-TextOffset <Int32>]
 [-Center] [-Color <Object>] [-Gradient <Array>] [-BlinkTextMilliseconds <Int32>]
 [-FadeTextMilliseconds <Int32>] [-Background <Object>] [-Rainbow] [-Icon <String>] [-PushIcon <Int32>]
 [-Repeat <Int32>] [-DurationSeconds <Int32>] [-NoScroll] [-ScrollSpeed <Int32>] [-Effect <String>]
 [-EffectSettings <Hashtable>] [-Bar <Int32[]>] [-Line <Int32[]>] [-Autoscale] [-BarBackgroundColor <Object>]
 [-Progress <Int32>] [-ProgressColor <Object>] [-ProgressBackgroundColor <Object>] [-Draw <Array>]
 [-Overlay <String>] [-LifetimeSeconds <Int32>] [-LifetimeMode <Int32>] [-Position <Int32>] [-Save] [-Push]
 [-BaseUri <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns an \[AwtrixApp\] object that holds the full state of a custom AWTRIX app.
The object can be modified, pushed to the device, cloned into templates, and
serialized to/from JSON - all without additional API calls until you're ready.

Use -Push to send the app to the device in the same call.
Omit -Push to build
the object locally first, set properties, then call $app.Push() when ready.

## EXAMPLES

### EXAMPLE 1
```
$app = New-AwtrixApp -Name 'weather' -Icon 'temperature' -Color '#FF6600'
PS> $app.Text = '72°F'
PS> $app.Push()
```

Creates an app object locally, sets text, then pushes to the device.

### EXAMPLE 2
```
$app = New-AwtrixApp -Name 'greeting' -Text 'Hello!' -Rainbow -DurationSeconds 10 -Push
```

Creates and immediately pushes an app with rainbow text.

### EXAMPLE 3
```
$base = New-AwtrixApp -Icon 'temperature' -Color '#FF6600' -DurationSeconds 10
PS> $indoor  = $base.Clone('temp_indoor');  $indoor.Text  = '72°F'; $indoor.Push()
PS> $outdoor = $base.Clone('temp_outdoor'); $outdoor.Text = '45°F'; $outdoor.Push()
```

Template pattern: clone a base configuration and push two variants.

### EXAMPLE 4
```
$app = New-AwtrixApp -Name 'status' -Text 'OK' -Push
PS> $app.ToJson() | Set-Content 'status.json'
PS> $restored = [AwtrixApp]::FromJson((Get-Content 'status.json' -Raw))
```

Serialize and restore an app configuration.

## PARAMETERS

### -Name
The unique app name used to identify and update the app on the device.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
The text to display.
A simple string or an array of colored fragment objects
created by New-AwtrixTextFragment.

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
Draw text on top of the display.

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
X-axis offset for the starting text position.

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
Text, bar, or line color.
Accepts a named color, hex string, or RGB array.

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

### -BlinkTextMilliseconds
Blinks the text at the given interval in ms.
Not compatible with gradient or rainbow.

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
Fades the text on and off at the given interval in ms.
Not compatible with gradient or rainbow.

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
Background color.
Accepts a named color, hex string, or RGB array.

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
Icon ID, filename (without extension), or Base64-encoded 8x8 JPG.

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
0 = static, 1 = moves with text once, 2 = moves with text repeatedly.

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
-1 = indefinite.

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
Scroll speed as a percentage of the original speed.

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
Background effect name.
Empty string removes an existing effect.

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
Hashtable to change color and speed of the background effect.

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
Bar chart data.
Max 16 values without icon, 11 with icon.

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
Line chart data.
Max 16 values without icon, 11 with icon.

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
Enables or disables auto-scaling for bar and line charts.

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
Background color of bar chart bars.

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
Progress bar value 0-100.

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
Progress bar foreground color.

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
Progress bar background color.

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
Effect overlay: clear, snow, rain, drizzle, storm, thunder, frost.

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
Removes the app if no update is received within this many seconds.
0 = disabled.

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
0 = delete app on expiry, 1 = mark as stale with red border.

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
0-based loop position.
Applied only on first push.
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
Persist app to flash memory across reboots.
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

### -Push
Send the app to the device immediately after creating the object.

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
Base URI of the AWTRIX device.
Overrides the module-level connection for this app.

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

### AwtrixApp
## NOTES

## RELATED LINKS
