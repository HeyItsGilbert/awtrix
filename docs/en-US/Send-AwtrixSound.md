---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Send-AwtrixSound

## SYNOPSIS
Plays a sound on the AWTRIX device.

## SYNTAX

```
Send-AwtrixSound [-Sound] <String> [-BaseUri <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Plays an RTTTL sound from the MELODIES folder on the AWTRIX 3 device.
If using a DFplayer, specify the 4-digit number of the MP3 file.

## EXAMPLES

### EXAMPLE 1
```
Send-AwtrixSound -Sound 'alarm'
```

Plays the 'alarm' melody from the MELODIES folder.

### EXAMPLE 2
```
Send-AwtrixSound -Sound '0001'
```

Plays MP3 file 0001 on DFplayer.

## PARAMETERS

### -Sound
The filename of the RTTTL ringtone (without extension) from the MELODIES folder,
or the 4-digit number of an MP3 file if using a DFplayer.

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
