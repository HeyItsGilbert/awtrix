---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Set-AwtrixIndicator

## SYNOPSIS
Sets a colored indicator on the AWTRIX display.

## SYNTAX

```
Set-AwtrixIndicator [-Id] <Int32> [-Color] <Object> [-Blink <Int32>] [-Fade <Int32>] [-BaseUri <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Configures one of three colored indicators on the AWTRIX 3 display:
- Indicator 1: Upper right corner
- Indicator 2: Right side
- Indicator 3: Lower right corner

Indicators can optionally blink or fade at a specified interval.

## EXAMPLES

### EXAMPLE 1
```
Set-AwtrixIndicator -Id 1 -Color '#FF0000'
```

Sets indicator 1 (upper right) to red.

### EXAMPLE 2
```
Set-AwtrixIndicator -Id 2 -Color @(0, 255, 0) -Blink 500
```

Sets indicator 2 to green, blinking every 500ms.

### EXAMPLE 3
```
Set-AwtrixIndicator -Id 3 -Color '#0000FF' -Fade 1000
```

Sets indicator 3 to blue, fading every 1000ms.

## PARAMETERS

### -Id
The indicator number (1, 2, or 3).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
The color for the indicator.
Accepts a hex string (e.g., '#FF0000') or an RGB array (e.g., @(255, 0, 0)).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Blink
Makes the indicator blink at the specified interval in milliseconds.

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

### -Fade
Makes the indicator fade on and off at the specified interval in milliseconds.

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
