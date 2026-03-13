---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Get-AwtrixStats

## SYNOPSIS
Retrieves general statistics from the AWTRIX device.

## SYNTAX

```
Get-AwtrixStats [[-BaseUri] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns device information including battery level, RAM usage, uptime,
WiFi signal strength, and other system metrics from the AWTRIX 3 device.

## EXAMPLES

### EXAMPLE 1
```
Get-AwtrixStats
```

Returns device statistics using the stored connection.

### EXAMPLE 2
```
Get-AwtrixStats -BaseUri '192.168.1.100'
```

Returns device statistics from a specific device.

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

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
