---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Get-AwtrixScreen

## SYNOPSIS
Retrieves the current screen content from the AWTRIX device.

## SYNTAX

```
Get-AwtrixScreen [[-BaseUri] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the current matrix screen as an array of 24-bit colors,
representing the live display content of the AWTRIX 3 device.

## EXAMPLES

### EXAMPLE 1
```
Get-AwtrixScreen
```

Returns the current screen pixel data as an array of color values.

## PARAMETERS

### -BaseUri
The base URI of the AWTRIX device.
If not specified, uses the connection from Connect-Awtrix.

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
