---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Set-AwtrixMoodlight

## SYNOPSIS
Sets the AWTRIX matrix to a mood lighting mode.

## SYNTAX

### Kelvin (Default)
```
Set-AwtrixMoodlight [-Brightness <Int32>] -Kelvin <Int32> [-BaseUri <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Color
```
Set-AwtrixMoodlight [-Brightness <Int32>] -Color <Object> [-BaseUri <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Disable
```
Set-AwtrixMoodlight [-Disable] [-BaseUri <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Configures the entire AWTRIX 3 matrix as a mood light with a custom color or
color temperature.
Use -Disable to turn off mood lighting.

Warning: Using mood lighting results in higher current draw and heat,
especially when all pixels are lit.
Manage brightness values responsibly.

## EXAMPLES

### EXAMPLE 1
```
Set-AwtrixMoodlight -Brightness 170 -Kelvin 2300
```

Sets warm white mood lighting at brightness 170.

### EXAMPLE 2
```
Set-AwtrixMoodlight -Brightness 100 -Color '#FF00FF'
```

Sets magenta mood lighting at brightness 100.

### EXAMPLE 3
```
Set-AwtrixMoodlight -Brightness 100 -Color @(155, 38, 182)
```

Sets purple mood lighting using RGB values.

### EXAMPLE 4
```
Set-AwtrixMoodlight -Disable
```

Turns off mood lighting.

## PARAMETERS

### -Brightness
The brightness level for the mood light (0-255).

```yaml
Type: Int32
Parameter Sets: Kelvin, Color
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Kelvin
Color temperature in Kelvin (e.g., 2300 for warm white).

```yaml
Type: Int32
Parameter Sets: Kelvin
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
The color for the mood light.
Accepts a hex string (e.g., '#FF00FF') or an RGB array (e.g., @(155, 38, 182)).

```yaml
Type: Object
Parameter Sets: Color
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disable
Disables mood lighting by sending an empty payload.

```yaml
Type: SwitchParameter
Parameter Sets: Disable
Aliases:

Required: True
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
