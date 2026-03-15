---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Update-AwtrixApp

## SYNOPSIS
Updates properties of an AwtrixApp object and pushes the changes to the device.

## SYNTAX

```
Update-AwtrixApp [-InputObject] <AwtrixApp> [[-Text] <Object>] [[-TextCase] <Int32>] [-TopText]
 [[-TextOffset] <Int32>] [-Center] [[-Color] <Object>] [[-Gradient] <Array>] [[-BlinkTextMilliseconds] <Int32>]
 [[-FadeTextMilliseconds] <Int32>] [[-Background] <Object>] [-Rainbow] [[-Icon] <String>] [[-PushIcon] <Int32>]
 [[-Repeat] <Int32>] [[-DurationSeconds] <Int32>] [-NoScroll] [[-ScrollSpeed] <Int32>] [[-Effect] <String>]
 [[-EffectSettings] <Hashtable>] [[-Bar] <Int32[]>] [[-Line] <Int32[]>] [-Autoscale]
 [[-BarBackgroundColor] <Object>] [[-Progress] <Int32>] [[-ProgressColor] <Object>]
 [[-ProgressBackgroundColor] <Object>] [[-Draw] <Array>] [[-Overlay] <String>] [[-LifetimeSeconds] <Int32>]
 [[-LifetimeMode] <Int32>] [-Save] [-DirtyOnly] [-PassThru] [[-BaseUri] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Accepts an \[AwtrixApp\] object from the pipeline (or directly), applies any
specified property overrides, then calls Push() to send the update to the device.

Use -DirtyOnly to send only the properties that changed since the last push,
minimising the payload sent over the network.
Use -PassThru to get the updated
object back for further chaining.

The InputObject is mutated in place so the caller's variable reflects the
latest state after the update.

## EXAMPLES

### EXAMPLE 1
```
$app | Update-AwtrixApp -Text '68°F'
```

Pipes an existing app object, updates its text, and pushes.

### EXAMPLE 2
```
$app | Update-AwtrixApp -Text '68°F' -DirtyOnly -PassThru | Select-Object Name, Text
```

Updates text, pushes dirty payload only, returns updated object.

### EXAMPLE 3
```
Get-Variable -Name 'app*' -ValueOnly | Update-AwtrixApp -DurationSeconds 5
```

Update duration on multiple app objects at once via pipeline.

## PARAMETERS

### -InputObject
The AwtrixApp object to update.
Accepts pipeline input.

```yaml
Type: AwtrixApp
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Text
New text value.

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
Position: 3
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
Position: 4
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

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Gradient
Two-color text gradient.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlinkTextMilliseconds
Blink interval in ms.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: BlinkTextMs

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FadeTextMilliseconds
Fade interval in ms.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: FadeTextMs

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Background
Background color.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Rainbow
Fade each letter through the RGB spectrum.

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
Icon ID, filename, or Base64 8x8 JPG.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PushIcon
0 = static, 1 = moves once, 2 = moves repeatedly.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repeat
Scroll count before app ends.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DurationSeconds
Display duration in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: DurationSec

Required: False
Position: 13
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoScroll
Disable text scrolling.

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
Scroll speed percentage.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Effect
Background effect name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EffectSettings
Effect color/speed overrides.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Bar
Bar chart data.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Line
Line chart data.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Autoscale
Auto-scale chart axes.

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
Bar background color.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
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
Position: 20
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
Position: 21
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
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Draw
Drawing instructions array.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Overlay
Effect overlay.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LifetimeSeconds
Auto-remove timeout in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: LifetimeSec

Required: False
Position: 25
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LifetimeMode
0 = delete on expiry, 1 = stale indicator.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Save
Persist to flash.

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

### -DirtyOnly
Send only properties that changed since the last Push().
If this is the first
push since the object was created, the full payload is sent.

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

### -PassThru
Return the updated AwtrixApp object.

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
Override the device URI for this push.
Does not persist on the object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
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
