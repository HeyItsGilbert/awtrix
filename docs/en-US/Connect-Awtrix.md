---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Connect-Awtrix

## SYNOPSIS
Connects to an AWTRIX device.

## SYNTAX

```
Connect-Awtrix [-BaseUri] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Establishes a connection to an AWTRIX 3 device by storing the base URI
in the module scope.
Validates the connection by retrieving device stats.
Subsequent commands will use this connection unless -BaseUri is specified.

## EXAMPLES

### EXAMPLE 1
```
Connect-Awtrix -BaseUri '192.168.1.100'
```

Connects to the AWTRIX device at 192.168.1.100 and returns device stats.

### EXAMPLE 2
```
Connect-Awtrix -BaseUri 'http://awtrix.local'
```

Connects using a hostname.

## PARAMETERS

### -BaseUri
The base URI or IP address of the AWTRIX device (e.g., '192.168.1.100' or 'http://192.168.1.100').

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
