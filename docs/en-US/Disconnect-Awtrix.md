---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Disconnect-Awtrix

## SYNOPSIS
Disconnects from the current AWTRIX device.

## SYNTAX

```
Disconnect-Awtrix [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Clears the stored AWTRIX connection from the module scope.
After disconnecting, commands will require -BaseUri or a new Connect-Awtrix call.

## EXAMPLES

### EXAMPLE 1
```
Disconnect-Awtrix
```

Disconnects from the current AWTRIX device.

## PARAMETERS

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
