---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Send-AwtrixRtttl

## SYNOPSIS
Plays an RTTTL melody string on the AWTRIX device.

## SYNTAX

```
Send-AwtrixRtttl [-RtttlString] <String> [-BaseUri <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Plays a Ring Tone Text Transfer Language (RTTTL) melody from a given
RTTTL string directly on the AWTRIX 3 device, without needing a file stored on the device.

## EXAMPLES

### EXAMPLE 1
```
Send-AwtrixRtttl -RtttlString 'Super Mario:d=4,o=5,b=100:16e6,16e6,32p,8e6,16c6,8e6,8g6'
```

Plays the Super Mario theme.

### EXAMPLE 2
```
Send-AwtrixRtttl 'TakeOnMe:d=4,o=4,b=160:8f#5,8f#5,8f#5,8d5,8p'
```

Plays a Take On Me snippet using positional parameter.

## PARAMETERS

### -RtttlString
The RTTTL format string to play.

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
