function Set-AwtrixSetting {
    <#
    .SYNOPSIS
        Updates settings on the AWTRIX device.
    .DESCRIPTION
        Configures device settings on the AWTRIX 3 device including display brightness,
        transition effects, text colors, time/date formats, and built-in app visibility.
        Only include the settings you want to change.
    .PARAMETER AppDisplayDuration
        Duration in seconds that each app is displayed. Maps to ATIME.
    .PARAMETER TransitionEffect
        App transition effect (TEFF). 0=Random, 1=Slide, 2=Dim, 3=Zoom, 4=Rotate,
        5=Pixelate, 6=Curtain, 7=Ripple, 8=Blink, 9=Reload, 10=Fade.
    .PARAMETER TransitionSpeed
        Time in milliseconds for the transition animation. Maps to TSPEED.
    .PARAMETER GlobalTextColor
        Global text color. Accepts hex string or RGB array. Maps to TCOL.
    .PARAMETER TimeMode
        Time app display style, 0-6. Maps to TMODE.
    .PARAMETER CalendarHeaderColor
        Calendar header color in the time app. Maps to CHCOL.
    .PARAMETER CalendarBodyColor
        Calendar body color in the time app. Maps to CBCOL.
    .PARAMETER CalendarTextColor
        Calendar text color in the time app. Maps to CTCOL.
    .PARAMETER WeekdayDisplay
        Enable or disable weekday display. Maps to WD.
    .PARAMETER WeekdayActiveColor
        Active weekday indicator color. Maps to WDCA.
    .PARAMETER WeekdayInactiveColor
        Inactive weekday indicator color. Maps to WDCI.
    .PARAMETER Brightness
        Matrix brightness, 0-255. Maps to BRI.
    .PARAMETER AutoBrightness
        Enable automatic brightness control. Maps to ABRI.
    .PARAMETER AutoTransition
        Enable automatic app switching. Maps to ATRANS.
    .PARAMETER ColorCorrection
        Color correction RGB array for the matrix. Maps to CCORRECTION.
    .PARAMETER ColorTemperature
        Color temperature RGB array for the matrix. Maps to CTEMP.
    .PARAMETER TimeFormat
        Time format string for the Time app. Maps to TFORMAT.
        Examples: '%%H:%%M:%%S' (24h with seconds), '%%l:%%M %%p' (12h with AM/PM).
    .PARAMETER DateFormat
        Date format string for the Date app. Maps to DFORMAT.
        Examples: '%%d.%%m.%%y' (DD.MM.YY), '%%m/%%d/%%y' (MM/DD/YY).
    .PARAMETER StartWeekOnMonday
        Start the week on Monday instead of Sunday. Maps to SOM.
    .PARAMETER UseCelsius
        Show temperature in Celsius. When false, shows Fahrenheit. Maps to CEL.
    .PARAMETER BlockNavigation
        Block physical navigation keys. Keys still send MQTT events. Maps to BLOCKN.
    .PARAMETER Uppercase
        Display text in uppercase. Maps to UPPERCASE.
    .PARAMETER TimeColor
        Text color of the Time app. Use 0 for global text color. Maps to TIME_COL.
    .PARAMETER DateColor
        Text color of the Date app. Use 0 for global text color. Maps to DATE_COL.
    .PARAMETER TemperatureColor
        Text color of the Temperature app. Use 0 for global text color. Maps to TEMP_COL.
    .PARAMETER HumidityColor
        Text color of the Humidity app. Use 0 for global text color. Maps to HUM_COL.
    .PARAMETER BatteryColor
        Text color of the Battery app. Use 0 for global text color. Maps to BAT_COL.
    .PARAMETER ScrollSpeed
        Scroll speed as a percentage of the original speed. Maps to SSPEED.
    .PARAMETER ShowTimeApp
        Enable or disable the native Time app. Requires reboot to take effect. Maps to TIM.
    .PARAMETER ShowDateApp
        Enable or disable the native Date app. Requires reboot to take effect. Maps to DAT.
    .PARAMETER ShowHumidityApp
        Enable or disable the native Humidity app. Requires reboot to take effect. Maps to HUM.
    .PARAMETER ShowTemperatureApp
        Enable or disable the native Temperature app. Requires reboot to take effect. Maps to TEMP.
    .PARAMETER ShowBatteryApp
        Enable or disable the native Battery app. Requires reboot to take effect. Maps to BAT.
    .PARAMETER MatrixEnabled
        Enable or disable the matrix display. Similar to power endpoint but without animation. Maps to MATP.
    .PARAMETER Volume
        Volume for buzzer and DFplayer, 0-30. Maps to VOL.
    .PARAMETER GlobalOverlay
        Sets a global effect overlay. Options: clear, snow, rain, drizzle, storm, thunder, frost. Maps to OVERLAY.
    .PARAMETER BaseUri
        The base URI of the AWTRIX device. If not specified, uses the connection from Connect-Awtrix.
    .EXAMPLE
        PS> Set-AwtrixSetting -Brightness 150

        Sets the matrix brightness to 150.
    .EXAMPLE
        PS> Set-AwtrixSetting -TransitionEffect 1 -TransitionSpeed 300

        Sets the transition effect to Slide with a 300ms animation speed.
    .EXAMPLE
        PS> Set-AwtrixSetting -TimeFormat '%H:%M' -UseCelsius $true

        Sets 24-hour time format and Celsius temperature display.
    .EXAMPLE
        PS> Set-AwtrixSetting -ShowTimeApp $true -ShowDateApp $false

        Shows the Time app and hides the Date app (both require reboot).
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter()]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$AppDisplayDuration,

        [Parameter()]
        [ValidateRange(0, 10)]
        [int]$TransitionEffect,

        [Parameter()]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$TransitionSpeed,

        [Parameter()]
        $GlobalTextColor,

        [Parameter()]
        [ValidateRange(0, 6)]
        [int]$TimeMode,

        [Parameter()]
        $CalendarHeaderColor,

        [Parameter()]
        $CalendarBodyColor,

        [Parameter()]
        $CalendarTextColor,

        [Parameter()]
        [bool]$WeekdayDisplay,

        [Parameter()]
        $WeekdayActiveColor,

        [Parameter()]
        $WeekdayInactiveColor,

        [Parameter()]
        [ValidateRange(0, 255)]
        [int]$Brightness,

        [Parameter()]
        [bool]$AutoBrightness,

        [Parameter()]
        [bool]$AutoTransition,

        [Parameter()]
        [int[]]$ColorCorrection,

        [Parameter()]
        [int[]]$ColorTemperature,

        [Parameter()]
        [string]$TimeFormat,

        [Parameter()]
        [string]$DateFormat,

        [Parameter()]
        [bool]$StartWeekOnMonday,

        [Parameter()]
        [bool]$UseCelsius,

        [Parameter()]
        [bool]$BlockNavigation,

        [Parameter()]
        [bool]$Uppercase,

        [Parameter()]
        $TimeColor,

        [Parameter()]
        $DateColor,

        [Parameter()]
        $TemperatureColor,

        [Parameter()]
        $HumidityColor,

        [Parameter()]
        $BatteryColor,

        [Parameter()]
        [int]$ScrollSpeed,

        [Parameter()]
        [bool]$ShowTimeApp,

        [Parameter()]
        [bool]$ShowDateApp,

        [Parameter()]
        [bool]$ShowHumidityApp,

        [Parameter()]
        [bool]$ShowTemperatureApp,

        [Parameter()]
        [bool]$ShowBatteryApp,

        [Parameter()]
        [bool]$MatrixEnabled,

        [Parameter()]
        [ValidateRange(0, 30)]
        [int]$Volume,

        [Parameter()]
        [ValidateSet('clear', 'snow', 'rain', 'drizzle', 'storm', 'thunder', 'frost', '')]
        [string]$GlobalOverlay,

        [Parameter()]
        [string]$BaseUri
    )

    $paramMap = @{
        'AppDisplayDuration' = 'ATIME'
        'TransitionEffect' = 'TEFF'
        'TransitionSpeed' = 'TSPEED'
        'GlobalTextColor' = 'TCOL'
        'TimeMode' = 'TMODE'
        'CalendarHeaderColor' = 'CHCOL'
        'CalendarBodyColor' = 'CBCOL'
        'CalendarTextColor' = 'CTCOL'
        'WeekdayDisplay' = 'WD'
        'WeekdayActiveColor' = 'WDCA'
        'WeekdayInactiveColor' = 'WDCI'
        'Brightness' = 'BRI'
        'AutoBrightness' = 'ABRI'
        'AutoTransition' = 'ATRANS'
        'ColorCorrection' = 'CCORRECTION'
        'ColorTemperature' = 'CTEMP'
        'TimeFormat' = 'TFORMAT'
        'DateFormat' = 'DFORMAT'
        'StartWeekOnMonday' = 'SOM'
        'UseCelsius' = 'CEL'
        'BlockNavigation' = 'BLOCKN'
        'Uppercase' = 'UPPERCASE'
        'TimeColor' = 'TIME_COL'
        'DateColor' = 'DATE_COL'
        'TemperatureColor' = 'TEMP_COL'
        'HumidityColor' = 'HUM_COL'
        'BatteryColor' = 'BAT_COL'
        'ScrollSpeed' = 'SSPEED'
        'ShowTimeApp' = 'TIM'
        'ShowDateApp' = 'DAT'
        'ShowHumidityApp' = 'HUM'
        'ShowTemperatureApp' = 'TEMP'
        'ShowBatteryApp' = 'BAT'
        'MatrixEnabled' = 'MATP'
        'Volume' = 'VOL'
        'GlobalOverlay' = 'OVERLAY'
    }

    $body = @{}

    foreach ($key in $PSBoundParameters.Keys) {
        if ($paramMap.ContainsKey($key)) {
            $body[$paramMap[$key]] = $PSBoundParameters[$key]
        }
    }

    if ($body.Count -eq 0) {
        Write-Warning 'No settings specified to update.'
        return
    }

    if ($PSCmdlet.ShouldProcess('AWTRIX Settings', "Update $($body.Count) setting(s)")) {
        InvokeAwtrixApi -Endpoint 'settings' -Method POST -Body $body -BaseUri $BaseUri
    }
}
