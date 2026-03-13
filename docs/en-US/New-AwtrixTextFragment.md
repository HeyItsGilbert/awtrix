---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# New-AwtrixTextFragment

## SYNOPSIS
Creates a colored text fragment for AWTRIX notifications and apps.

## SYNTAX

```
New-AwtrixTextFragment [-Text] <String> [-Color] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Generates text fragment objects for use with the -Text parameter of
Set-AwtrixApp or Send-AwtrixNotification.
Each fragment has its own
text and color, allowing multi-colored text display on the AWTRIX 3 device.

## EXAMPLES

### EXAMPLE 1
```
New-AwtrixTextFragment -Text 'Hello' -Color 'FF0000'
```

Creates a red text fragment containing 'Hello'.

### EXAMPLE 2
```
$fragments = @(
>>     New-AwtrixTextFragment -Text 'Error: ' -Color 'FF0000'
>>     New-AwtrixTextFragment -Text 'disk full' -Color 'FFFFFF'
>> )
PS> Send-AwtrixNotification -Text $fragments
```

Sends a notification with 'Error: ' in red and 'disk full' in white.

## PARAMETERS

### -Text
The text content for this fragment.

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

### -Color
The hex color for this fragment (without # prefix), e.g., 'FF0000' for red.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

### System.Collections.Hashtable
## NOTES

## RELATED LINKS
