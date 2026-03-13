---
external help file: awtrix-help.xml
Module Name: awtrix
online version:
schema: 2.0.0
---

# New-AwtrixDrawing

## SYNOPSIS
Creates a drawing instruction object for AWTRIX custom apps.

## SYNTAX

### Pixel (Default)
```
New-AwtrixDrawing [-Pixel] -X <Int32> -Y <Int32> -Color <Object> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Line
```
New-AwtrixDrawing [-Line] -X <Int32> -Y <Int32> -X2 <Int32> -Y2 <Int32> -Color <Object>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Rectangle
```
New-AwtrixDrawing [-Rectangle] -X <Int32> -Y <Int32> -Width <Int32> -Height <Int32> -Color <Object>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### FilledRectangle
```
New-AwtrixDrawing [-FilledRectangle] -X <Int32> -Y <Int32> -Width <Int32> -Height <Int32> -Color <Object>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Circle
```
New-AwtrixDrawing [-Circle] -X <Int32> -Y <Int32> -Radius <Int32> -Color <Object>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### FilledCircle
```
New-AwtrixDrawing [-FilledCircle] -X <Int32> -Y <Int32> -Radius <Int32> -Color <Object>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Text
```
New-AwtrixDrawing [-Text] -X <Int32> -Y <Int32> -Color <Object> -TextContent <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Bitmap
```
New-AwtrixDrawing [-Bitmap] -X <Int32> -Y <Int32> -Width <Int32> -Height <Int32> -BitmapData <Int32[]>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Generates drawing instruction objects that can be passed to the -Draw
parameter of Set-AwtrixApp or Send-AwtrixNotification.
Supports pixels,
lines, rectangles, filled rectangles, circles, filled circles, text, and bitmaps.

Note: Depending on the number of drawing objects, RAM usage can be high.
Be mindful of complexity to avoid device freezes or reboots.

## EXAMPLES

### EXAMPLE 1
```
New-AwtrixDrawing -Pixel -X 5 -Y 3 -Color '#FF0000'
```

Creates a red pixel at position (5, 3).

### EXAMPLE 2
```
New-AwtrixDrawing -Line -X 0 -Y 0 -X2 10 -Y2 7 -Color '#00FF00'
```

Creates a green line from (0,0) to (10,7).

### EXAMPLE 3
```
New-AwtrixDrawing -Circle -X 16 -Y 4 -Radius 3 -Color '#0000FF'
```

Creates a blue circle outline at center (16,4) with radius 3.

### EXAMPLE 4
```
New-AwtrixDrawing -Text -X 0 -Y 0 -TextContent 'Hello' -Color '#FFFFFF'
```

Creates white text 'Hello' at position (0,0).

### EXAMPLE 5
```
New-AwtrixDrawing -FilledRectangle -X 0 -Y 0 -Width 8 -Height 8 -Color '#FF6600'
```

Creates a filled orange 8x8 rectangle.

## PARAMETERS

### -Pixel
Draw a pixel at position (X, Y).

```yaml
Type: SwitchParameter
Parameter Sets: Pixel
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Line
Draw a line from (X, Y) to (X2, Y2).

```yaml
Type: SwitchParameter
Parameter Sets: Line
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Rectangle
Draw a rectangle outline at (X, Y) with given Width and Height.

```yaml
Type: SwitchParameter
Parameter Sets: Rectangle
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilledRectangle
Draw a filled rectangle at (X, Y) with given Width and Height.

```yaml
Type: SwitchParameter
Parameter Sets: FilledRectangle
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Circle
Draw a circle outline at center (X, Y) with given Radius.

```yaml
Type: SwitchParameter
Parameter Sets: Circle
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilledCircle
Draw a filled circle at center (X, Y) with given Radius.

```yaml
Type: SwitchParameter
Parameter Sets: FilledCircle
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
Draw text at position (X, Y).

```yaml
Type: SwitchParameter
Parameter Sets: Text
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Bitmap
Draw an RGB888 bitmap at position (X, Y) with given Width and Height.

```yaml
Type: SwitchParameter
Parameter Sets: Bitmap
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -X
The X coordinate.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Y
The Y coordinate.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -X2
The ending X coordinate (for lines).

```yaml
Type: Int32
Parameter Sets: Line
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Y2
The ending Y coordinate (for lines).

```yaml
Type: Int32
Parameter Sets: Line
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
The width (for rectangles and bitmaps).

```yaml
Type: Int32
Parameter Sets: Rectangle, FilledRectangle, Bitmap
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Height
The height (for rectangles and bitmaps).

```yaml
Type: Int32
Parameter Sets: Rectangle, FilledRectangle, Bitmap
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Radius
The radius (for circles).

```yaml
Type: Int32
Parameter Sets: Circle, FilledCircle
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
The draw color.
Accepts a hex string (e.g., '#FF0000') or RGB array (e.g., @(255, 0, 0)).

```yaml
Type: Object
Parameter Sets: Pixel, Line, Rectangle, FilledRectangle, Circle, FilledCircle, Text
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TextContent
The text string to draw (for the Text drawing type).

```yaml
Type: String
Parameter Sets: Text
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BitmapData
The RGB888 bitmap data array (for the Bitmap drawing type).

```yaml
Type: Int32[]
Parameter Sets: Bitmap
Aliases:

Required: True
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

### System.Collections.Hashtable
## NOTES

## RELATED LINKS
