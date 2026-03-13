---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# Switch-AwtrixApp

## SYNOPSIS
Switches the AWTRIX display to a different app.

## SYNTAX

### ByName (Default)
```
Switch-AwtrixApp [-Name] <String> [-BaseUri <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Next
```
Switch-AwtrixApp [-Next] [-BaseUri <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Previous
```
Switch-AwtrixApp [-Previous] [-BaseUri <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Navigates to a specific app by name, or moves to the next or previous
app in the display loop on the AWTRIX 3 device.

Built-in app names: Time, Date, Temperature, Humidity, Battery.
For custom apps, use the name assigned when creating the app.

## EXAMPLES

### EXAMPLE 1
```
Switch-AwtrixApp -Name 'Time'
```

Switches to the Time app.

### EXAMPLE 2
```
Switch-AwtrixApp -Next
```

Moves to the next app in the loop.

### EXAMPLE 3
```
Switch-AwtrixApp -Previous
```

Moves to the previous app in the loop.

## PARAMETERS

### -Name
The name of the app to switch to.

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Next
Switch to the next app in the loop.

```yaml
Type: SwitchParameter
Parameter Sets: Next
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Previous
Switch to the previous app in the loop.

```yaml
Type: SwitchParameter
Parameter Sets: Previous
Aliases:

Required: True
Position: Named
Default value: False
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
