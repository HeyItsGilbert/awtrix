---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Clear-AwtrixIndicator

## SYNOPSIS
Clears a colored indicator on the AWTRIX display.

## SYNTAX

```
Clear-AwtrixIndicator [-Id] <Int32> [-BaseUri <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Hides one of the three colored indicators on the AWTRIX 3 display
by sending an empty payload to the indicator endpoint.

## EXAMPLES

### EXAMPLE 1
```
Clear-AwtrixIndicator -Id 1
```

Clears indicator 1 (upper right corner).

### EXAMPLE 2
```
1..3 | ForEach-Object { Clear-AwtrixIndicator -Id $_ }
```

Clears all three indicators.

## PARAMETERS

### -Id
The indicator number to clear (1, 2, or 3).

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
