# Named colors for easy, discoverable use across all color parameters.
enum AwtrixColor {
    Red
    Green
    Blue
    Yellow
    Cyan
    Magenta
    White
    Black
    Orange
    Purple
    Pink
}

# Descriptive indicator positions mapped to the AWTRIX API indicator numbers.
# Top = upper-right (1), Middle = right side (2), Bottom = lower-right (3).
enum AwtrixIndicatorPosition {
    Top = 1
    Middle = 2
    Bottom = 3
}

# Argument transformation attribute that normalises any supported color input
# (AwtrixColor enum, named-color string, hex string, or RGB int array) into
# the format the AWTRIX API expects (hex string or int array).
class AwtrixColorTransformAttribute : System.Management.Automation.ArgumentTransformationAttribute {

    [object] Transform(
        [System.Management.Automation.EngineIntrinsics]$engineIntrinsics,
        [object]$inputData
    ) {
        return [AwtrixColorTransformAttribute]::ConvertColor($inputData)
    }

    # Public helper so other module code (e.g. ConvertColorInput) can reuse
    # the same resolution logic.
    static [object] ConvertColor([object]$inputData) {
        if ($null -eq $inputData) { return $inputData }

        # Already an AwtrixColor enum value
        if ($inputData -is [AwtrixColor]) {
            return [AwtrixColorTransformAttribute]::ResolveNamedColor($inputData)
        }

        # Array handling --------------------------------------------------
        if ($inputData -is [array]) {
            # Three-element numeric array → RGB tuple, pass through
            if ([AwtrixColorTransformAttribute]::IsRgbArray($inputData)) {
                return , $inputData
            }
            # Otherwise treat as a list of individual colours (e.g. gradient pair)
            $converted = [object[]]::new($inputData.Count)
            for ($i = 0; $i -lt $inputData.Count; $i++) {
                $converted[$i] = [AwtrixColorTransformAttribute]::ConvertColor($inputData[$i])
            }
            return , $converted
        }

        # String handling -------------------------------------------------
        if ($inputData -is [string]) {
            try {
                $parsed = [AwtrixColor]$inputData
                return [AwtrixColorTransformAttribute]::ResolveNamedColor($parsed)
            } catch {
                # Not a named colour - treat as a hex string and pass through
                return $inputData
            }
        }

        # Integer 0 is used by the API to hide / clear an indicator
        if ($inputData -is [int] -and $inputData -eq 0) {
            return '0'
        }

        return $inputData
    }

    # Returns $true when the array looks like an RGB triple (3 numeric items).
    static [bool] IsRgbArray([object]$data) {
        if ($data -isnot [array]) { return $false }
        if ($data.Count -ne 3) { return $false }
        foreach ($item in $data) {
            if ($item -isnot [int] -and
                $item -isnot [long] -and
                $item -isnot [double] -and
                $item -isnot [byte]) {
                return $false
            }
        }
        return $true
    }

    # Maps an AwtrixColor enum value to its hex string.
    static [string] ResolveNamedColor([AwtrixColor]$color) {
        switch ($color) {
            ([AwtrixColor]::Red) { return '#FF0000' }
            ([AwtrixColor]::Green) { return '#00FF00' }
            ([AwtrixColor]::Blue) { return '#0000FF' }
            ([AwtrixColor]::Yellow) { return '#FFFF00' }
            ([AwtrixColor]::Cyan) { return '#00FFFF' }
            ([AwtrixColor]::Magenta) { return '#FF00FF' }
            ([AwtrixColor]::White) { return '#FFFFFF' }
            ([AwtrixColor]::Black) { return '#000000' }
            ([AwtrixColor]::Orange) { return '#FFA500' }
            ([AwtrixColor]::Purple) { return '#800080' }
            ([AwtrixColor]::Pink) { return '#FFC0CB' }
        }
        return '#FFFFFF'
    }
}
