function NewAppPayload {
    <#
    .SYNOPSIS
        Builds an AWTRIX custom app or notification JSON payload from bound parameters.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory)]
        [hashtable]$BoundParameters
    )

    $paramMap = @{
        'Text' = 'text'
        'TextCase' = 'textCase'
        'TopText' = 'topText'
        'TextOffset' = 'textOffset'
        'Center' = 'center'
        'Color' = 'color'
        'Gradient' = 'gradient'
        'BlinkTextMilliseconds' = 'blinkText'
        'FadeTextMilliseconds' = 'fadeText'
        'Background' = 'background'
        'Rainbow' = 'rainbow'
        'Icon' = 'icon'
        'PushIcon' = 'pushIcon'
        'Repeat' = 'repeat'
        'DurationSeconds' = 'duration'
        'NoScroll' = 'noScroll'
        'ScrollSpeed' = 'scrollSpeed'
        'Effect' = 'effect'
        'EffectSettings' = 'effectSettings'
        'Bar' = 'bar'
        'Line' = 'line'
        'Autoscale' = 'autoscale'
        'BarBackgroundColor' = 'barBC'
        'Progress' = 'progress'
        'ProgressColor' = 'progressC'
        'ProgressBackgroundColor' = 'progressBC'
        'Draw' = 'draw'
        'Overlay' = 'overlay'
        'LifetimeSeconds' = 'lifetime'
        'LifetimeMode' = 'lifetimeMode'
        'Position' = 'pos'
        'Save' = 'save'
        'Hold' = 'hold'
        'Sound' = 'sound'
        'Rtttl' = 'rtttl'
        'LoopSound' = 'loopSound'
        'Stack' = 'stack'
        'Wakeup' = 'wakeup'
        'Clients' = 'clients'
    }

    $body = @{}

    foreach ($key in $BoundParameters.Keys) {
        if ($paramMap.ContainsKey($key)) {
            # If the parameter is a switch, convert it to a boolean value
            if ($BoundParameters[$key] -is [switch]) {
                $body[$paramMap[$key]] = [bool]$BoundParameters[$key]
            } else {
                $body[$paramMap[$key]] = $BoundParameters[$key]
            }
        }
    }

    return $body
}
