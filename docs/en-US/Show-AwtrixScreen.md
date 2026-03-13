---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Show-AwtrixScreen

## SYNOPSIS
Renders the current AWTRIX screen as colored pixels in the terminal.

## SYNTAX

```
Show-AwtrixScreen [[-ScreenData] <Int32[]>] [[-BaseUri] <String>] [[-PixelSize] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Fetches the current 32x8 matrix screen from the AWTRIX device and renders
it in the terminal using Spectre.Console's Canvas via PwshSpectreConsole.
Each LED pixel is displayed as a colored block, scaled up for visibility.

Requires the PwshSpectreConsole module to be installed:
    Install-Module PwshSpectreConsole

## EXAMPLES

### EXAMPLE 1
```
Show-AwtrixScreen
```

Fetches and renders the current screen content.

### EXAMPLE 2
```
Get-AwtrixScreen | Show-AwtrixScreen -PixelSize 3
```

Pipes screen data and renders at 3x scale.

### EXAMPLE 3
```
Show-AwtrixScreen -BaseUri 'http://192.168.1.100'
```

Renders screen from a specific device.

## PARAMETERS

### -ScreenData
Optional pre-fetched screen data (array of 256 24-bit color integers).
If not provided, the function calls Get-AwtrixScreen to fetch live data.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PixelSize
Scale factor for each pixel.
Default is 2, meaning each LED pixel maps to
a 2x2 block on the canvas for better visibility.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 2
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
