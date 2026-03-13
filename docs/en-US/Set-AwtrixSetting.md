---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Set-AwtrixSetting

## SYNOPSIS
Updates settings on the AWTRIX device.

## SYNTAX

```
Set-AwtrixSetting [[-AppDisplayDuration] <Int32>] [[-TransitionEffect] <Int32>] [[-TransitionSpeed] <Int32>]
 [[-GlobalTextColor] <Object>] [[-TimeMode] <Int32>] [[-CalendarHeaderColor] <Object>]
 [[-CalendarBodyColor] <Object>] [[-CalendarTextColor] <Object>] [[-WeekdayDisplay] <Boolean>]
 [[-WeekdayActiveColor] <Object>] [[-WeekdayInactiveColor] <Object>] [[-Brightness] <Int32>]
 [[-AutoBrightness] <Boolean>] [[-AutoTransition] <Boolean>] [[-ColorCorrection] <Int32[]>]
 [[-ColorTemperature] <Int32[]>] [[-TimeFormat] <String>] [[-DateFormat] <String>]
 [[-StartWeekOnMonday] <Boolean>] [[-UseCelsius] <Boolean>] [[-BlockNavigation] <Boolean>]
 [[-Uppercase] <Boolean>] [[-TimeColor] <Object>] [[-DateColor] <Object>] [[-TemperatureColor] <Object>]
 [[-HumidityColor] <Object>] [[-BatteryColor] <Object>] [[-ScrollSpeed] <Int32>] [[-ShowTimeApp] <Boolean>]
 [[-ShowDateApp] <Boolean>] [[-ShowHumidityApp] <Boolean>] [[-ShowTemperatureApp] <Boolean>]
 [[-ShowBatteryApp] <Boolean>] [[-MatrixEnabled] <Boolean>] [[-Volume] <Int32>] [[-GlobalOverlay] <String>]
 [[-BaseUri] <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Configures device settings on the AWTRIX 3 device including display brightness,
transition effects, text colors, time/date formats, and built-in app visibility.
Only include the settings you want to change.

## EXAMPLES

### EXAMPLE 1
```
Set-AwtrixSetting -Brightness 150
```

Sets the matrix brightness to 150.

### EXAMPLE 2
```
Set-AwtrixSetting -TransitionEffect 1 -TransitionSpeed 300
```

Sets the transition effect to Slide with a 300ms animation speed.

### EXAMPLE 3
```
Set-AwtrixSetting -TimeFormat '%H:%M' -UseCelsius $true
```

Sets 24-hour time format and Celsius temperature display.

### EXAMPLE 4
```
Set-AwtrixSetting -ShowTimeApp $true -ShowDateApp $false
```

Shows the Time app and hides the Date app (both require reboot).

## PARAMETERS

### -AppDisplayDuration
Duration in seconds that each app is displayed.
Maps to ATIME.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TransitionEffect
App transition effect (TEFF).
0=Random, 1=Slide, 2=Dim, 3=Zoom, 4=Rotate,
5=Pixelate, 6=Curtain, 7=Ripple, 8=Blink, 9=Reload, 10=Fade.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TransitionSpeed
Time in milliseconds for the transition animation.
Maps to TSPEED.

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

### -GlobalTextColor
Global text color.
Accepts hex string or RGB array.
Maps to TCOL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeMode
Time app display style, 0-6.
Maps to TMODE.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CalendarHeaderColor
Calendar header color in the time app.
Maps to CHCOL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CalendarBodyColor
Calendar body color in the time app.
Maps to CBCOL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CalendarTextColor
Calendar text color in the time app.
Maps to CTCOL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WeekdayDisplay
Enable or disable weekday display.
Maps to WD.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WeekdayActiveColor
Active weekday indicator color.
Maps to WDCA.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WeekdayInactiveColor
Inactive weekday indicator color.
Maps to WDCI.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Brightness
Matrix brightness, 0-255.
Maps to BRI.

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

### -AutoBrightness
Enable automatic brightness control.
Maps to ABRI.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoTransition
Enable automatic app switching.
Maps to ATRANS.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ColorCorrection
Color correction RGB array for the matrix.
Maps to CCORRECTION.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ColorTemperature
Color temperature RGB array for the matrix.
Maps to CTEMP.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeFormat
Time format string for the Time app.
Maps to TFORMAT.
Examples: '%%H:%%M:%%S' (24h with seconds), '%%l:%%M %%p' (12h with AM/PM).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DateFormat
Date format string for the Date app.
Maps to DFORMAT.
Examples: '%%d.%%m.%%y' (DD.MM.YY), '%%m/%%d/%%y' (MM/DD/YY).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartWeekOnMonday
Start the week on Monday instead of Sunday.
Maps to SOM.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseCelsius
Show temperature in Celsius.
When false, shows Fahrenheit.
Maps to CEL.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlockNavigation
Block physical navigation keys.
Keys still send MQTT events.
Maps to BLOCKN.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uppercase
Display text in uppercase.
Maps to UPPERCASE.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeColor
Text color of the Time app.
Use 0 for global text color.
Maps to TIME_COL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DateColor
Text color of the Date app.
Use 0 for global text color.
Maps to DATE_COL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemperatureColor
Text color of the Temperature app.
Use 0 for global text color.
Maps to TEMP_COL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HumidityColor
Text color of the Humidity app.
Use 0 for global text color.
Maps to HUM_COL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BatteryColor
Text color of the Battery app.
Use 0 for global text color.
Maps to BAT_COL.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScrollSpeed
Scroll speed as a percentage of the original speed.
Maps to SSPEED.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowTimeApp
Enable or disable the native Time app.
Requires reboot to take effect.
Maps to TIM.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowDateApp
Enable or disable the native Date app.
Requires reboot to take effect.
Maps to DAT.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowHumidityApp
Enable or disable the native Humidity app.
Requires reboot to take effect.
Maps to HUM.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowTemperatureApp
Enable or disable the native Temperature app.
Requires reboot to take effect.
Maps to TEMP.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowBatteryApp
Enable or disable the native Battery app.
Requires reboot to take effect.
Maps to BAT.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MatrixEnabled
Enable or disable the matrix display.
Similar to power endpoint but without animation.
Maps to MATP.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Volume
Volume for buzzer and DFplayer, 0-30.
Maps to VOL.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GlobalOverlay
Sets a global effect overlay.
Options: clear, snow, rain, drizzle, storm, thunder, frost.
Maps to OVERLAY.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
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
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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
