---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# New-AwtrixAppCollection

## SYNOPSIS
Creates an AwtrixAppCollection for multi-page custom app groups.

## SYNTAX

```
New-AwtrixAppCollection [-BaseName] <String> [-Apps] <AwtrixApp[]> [-Push] [-BaseUri <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Wraps multiple AwtrixApp pages under a shared base name.
AWTRIX 3 automatically
assigns numeric suffixes (BaseName0, BaseName1, …) when an array is sent to
the API.
Use Push() to send all pages at once, or Remove() to delete the group.

## EXAMPLES

### EXAMPLE 1
```
$p1 = New-AwtrixApp -Text 'Page 1' -DurationSeconds 5
PS> $p2 = New-AwtrixApp -Text 'Page 2' -Color Red -DurationSeconds 5
PS> $c  = New-AwtrixAppCollection -BaseName 'dashboard' -Apps @($p1, $p2) -Push
```

Creates a two-page dashboard group and immediately pushes it.

### EXAMPLE 2
```
$collection = New-AwtrixAppCollection -BaseName 'report' -Apps $pages
PS> # ... later, after data changes ...
PS> $collection.Push()
```

Builds a collection, then pushes when you're ready.

### EXAMPLE 3
```
$collection.Remove()
```

Removes all pages in the group from the device.

## PARAMETERS

### -BaseName
The shared base name for all pages in the collection.

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

### -Apps
Ordered array of AwtrixApp objects representing each page.

```yaml
Type: AwtrixApp[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Push
Send the collection to the device immediately after creating the object.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BaseUri
Base URI of the AWTRIX device.
Overrides the module-level connection.

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

### AwtrixAppCollection
## NOTES

## RELATED LINKS
