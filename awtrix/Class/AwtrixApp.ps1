# Base class shared by AwtrixApp and AwtrixNotification.
# Classes defined in ScriptsToProcess run outside the module scope, so they
# cannot call InvokeAwtrixApi directly. The module wires up the static delegate
# [AwtrixAppBase]::InvokeApi during module load (see awtrix.psm1).
class AwtrixAppBase {

    # ── Shared API properties ────────────────────────────────────────────────

    # Text to display. String or array of colored fragment hashtables.
    $Text

    # 0 = global setting, 1 = force uppercase, 2 = show as sent.
    [ValidateRange(0, 2)]
    [System.Nullable[int]] $TextCase

    # Draw text on top of display.
    [System.Nullable[bool]] $TopText

    # X-axis offset for the starting text position.
    [System.Nullable[int]] $TextOffset

    # Centers a short, non-scrollable text.
    [System.Nullable[bool]] $Center

    # Text/bar/line color. Hex string or RGB array.
    $Color

    # Two-color gradient for text. Array of two color values.
    $Gradient

    # Blink interval in milliseconds. Not compatible with gradient/rainbow.
    [System.Nullable[int]] $BlinkTextMilliseconds

    # Fade-on/off interval in milliseconds. Not compatible with gradient/rainbow.
    [System.Nullable[int]] $FadeTextMilliseconds

    # Background color. Hex string or RGB array.
    $Background

    # Fade each letter through the full RGB spectrum.
    [System.Nullable[bool]] $Rainbow

    # Icon ID, filename (no extension), or Base64-encoded 8×8 JPG.
    [string] $Icon

    # 0 = static, 1 = moves with text once, 2 = moves with text repeatedly.
    [ValidateRange(0, 2)]
    [System.Nullable[int]] $PushIcon

    # Scroll count before app/notification ends. -1 = indefinite.
    [System.Nullable[int]] $Repeat

    # Display duration in seconds.
    [System.Nullable[int]] $DurationSeconds

    # Disables text scrolling.
    [System.Nullable[bool]] $NoScroll

    # Scroll speed as a percentage of normal speed (e.g. 200 = 2×).
    [System.Nullable[int]] $ScrollSpeed

    # Background effect name. Empty string clears an existing effect.
    [string] $Effect

    # Color/speed overrides for the background effect.
    [hashtable] $EffectSettings

    # Bar chart data. Max 16 values without icon, 11 with icon.
    [int[]] $Bar

    # Line chart data. Max 16 values without icon, 11 with icon.
    [int[]] $Line

    # Auto-scale bar/line chart axes.
    [System.Nullable[bool]] $Autoscale

    # Background color of bar chart bars.
    $BarBackgroundColor

    # Progress bar value 0-100. -1 disables.
    [ValidateRange(-1, 100)]
    [System.Nullable[int]] $Progress

    # Progress bar foreground color.
    $ProgressColor

    # Progress bar background color.
    $ProgressBackgroundColor

    # Drawing instructions. Use New-AwtrixDrawing to build entries.
    [array] $Draw

    # Effect overlay: clear, snow, rain, drizzle, storm, thunder, frost.
    [ValidateSet('', 'clear', 'snow', 'rain', 'drizzle', 'storm', 'thunder', 'frost')]
    [string] $Overlay

    # ── Module API delegate (set by awtrix.psm1 during module load) ──────────
    static [scriptblock] $InvokeApi

    # Per-object BaseUri override. $null = use module-level connection.
    hidden [string] $_baseUri

    # Payload snapshot taken after last Push/Send, used for dirty tracking.
    hidden [hashtable] $_lastPushed

    # ── Canonical property → API-key mapping ────────────────────────────────
    static [hashtable] GetPropertyMap() {
        return @{
            Text = 'text'
            TextCase = 'textCase'
            TopText = 'topText'
            TextOffset = 'textOffset'
            Center = 'center'
            Color = 'color'
            Gradient = 'gradient'
            BlinkTextMilliseconds = 'blinkText'
            FadeTextMilliseconds = 'fadeText'
            Background = 'background'
            Rainbow = 'rainbow'
            Icon = 'icon'
            PushIcon = 'pushIcon'
            Repeat = 'repeat'
            DurationSeconds = 'duration'
            NoScroll = 'noScroll'
            ScrollSpeed = 'scrollSpeed'
            Effect = 'effect'
            EffectSettings = 'effectSettings'
            Bar = 'bar'
            Line = 'line'
            Autoscale = 'autoscale'
            BarBackgroundColor = 'barBC'
            Progress = 'progress'
            ProgressColor = 'progressC'
            ProgressBackgroundColor = 'progressBC'
            Draw = 'draw'
            Overlay = 'overlay'
        }
    }

    # ── ToPayload ────────────────────────────────────────────────────────────
    # Returns an API-ready hashtable containing only properties with non-null,
    # non-empty values so we never send noise to the device.
    [hashtable] ToPayload() {
        $map = [AwtrixAppBase]::GetPropertyMap()
        $body = @{}
        foreach ($prop in $map.Keys) {
            $val = $this.$prop
            if ($null -eq $val) { continue }
            # Skip empty strings unless the property is Effect (empty string is
            # a documented signal meaning "remove the current effect").
            if ($val -is [string] -and $val -eq '' -and $prop -ne 'Effect') { continue }
            # Skip arrays and hashtables that are empty.
            if ($val -is [array] -and $val.Count -eq 0) { continue }
            if ($val -is [hashtable] -and $val.Count -eq 0) { continue }
            $body[$map[$prop]] = $val
        }
        return $body
    }

    # ── ToJson ───────────────────────────────────────────────────────────────
    [string] ToJson() {
        return $this.ToPayload() | ConvertTo-Json -Depth 10 -Compress
    }

    # ── Dirty Tracking ───────────────────────────────────────────────────────
    # Snapshot current payload, marking it as "clean".
    [void] ResetDirtyState() {
        $this._lastPushed = $this.ToPayload()
    }

    # Returns only the keys whose values differ from the last push snapshot.
    # On first call (no snapshot), returns the full payload.
    [hashtable] GetDirtyPayload() {
        if ($null -eq $this._lastPushed) {
            return $this.ToPayload()
        }
        $current = $this.ToPayload()
        $dirty = @{}
        # Keys present in current that are new or changed.
        foreach ($key in $current.Keys) {
            $prev = $this._lastPushed[$key]
            $curr = $current[$key]
            if ($null -eq $prev) {
                $dirty[$key] = $curr
            } elseif ($curr -is [array] -or $curr -is [hashtable]) {
                # Deep compare via JSON serialization.
                if (($curr | ConvertTo-Json -Depth 10 -Compress) -ne
                    ($prev | ConvertTo-Json -Depth 10 -Compress)) {
                    $dirty[$key] = $curr
                }
            } elseif ($curr -ne $prev) {
                $dirty[$key] = $curr
            }
        }
        # Keys that existed before but are now absent (set to null/empty) — send
        # the current (absent) value so callers can detect the removal if needed.
        # For simplicity we leave removed keys out; callers can always do a full push.
        return $dirty
    }

    # ── Clone (base - subclasses override to carry their extra properties) ──
    [AwtrixAppBase] CloneBase() {
        $copy = [AwtrixAppBase]::new()
        $copy._baseUri = $this._baseUri
        foreach ($prop in [AwtrixAppBase]::GetPropertyMap().Keys) {
            # Guard against null to avoid [ValidateRange] rejecting null assignments.
            if ($null -ne $this.$prop) { $copy.$prop = $this.$prop }
        }
        return $copy
    }
}

# ── AwtrixApp ────────────────────────────────────────────────────────────────
# Represents a persistent custom app in the AWTRIX display loop.
class AwtrixApp : AwtrixAppBase {

    # Unique app name used to identify and update the app.
    [string] $Name

    # Remove app after no update within this many seconds. 0 = disabled.
    [System.Nullable[int]] $LifetimeSeconds

    # 0 = delete app on expiry, 1 = mark as stale with red border.
    [ValidateRange(0, 1)]
    [System.Nullable[int]] $LifetimeMode

    # Loop position (0-based). Only applied on first push. Experimental.
    [System.Nullable[int]] $Position

    # Persist app across reboots. Avoid for high-frequency updates.
    [System.Nullable[bool]] $Save

    # ── Constructors ─────────────────────────────────────────────────────────
    AwtrixApp() {}

    AwtrixApp([string]$name) {
        $this.Name = $name
    }

    # ── ToPayload override — merges app-only fields ──────────────────────────
    [hashtable] ToPayload() {
        $body = ([AwtrixAppBase]$this).ToPayload()
        if ($null -ne $this.LifetimeSeconds) { $body['lifetime'] = $this.LifetimeSeconds }
        if ($null -ne $this.LifetimeMode) { $body['lifetimeMode'] = $this.LifetimeMode }
        if ($null -ne $this.Position) { $body['pos'] = $this.Position }
        if ($null -ne $this.Save) { $body['save'] = $this.Save }
        return $body
    }

    # ── Push — sends the full payload (or only dirty keys) to the device ─────
    [void] Push() {
        $this.Push($false)
    }

    [void] Push([bool]$dirtyOnly) {
        if ([string]::IsNullOrWhiteSpace($this.Name)) {
            throw 'AwtrixApp.Name must be set before calling Push().'
        }
        $body = if ($dirtyOnly) { $this.GetDirtyPayload() } else { $this.ToPayload() }
        & ([AwtrixAppBase]::InvokeApi) -Endpoint 'custom' -Method POST -Body $body `
            -QueryString "name=$($this.Name)" -BaseUri $this._baseUri
        $this.ResetDirtyState()
    }

    # ── Remove — deletes the app from the device ─────────────────────────────
    [void] Remove() {
        if ([string]::IsNullOrWhiteSpace($this.Name)) {
            throw 'AwtrixApp.Name must be set before calling Remove().'
        }
        & ([AwtrixAppBase]::InvokeApi) -Endpoint 'custom' -Method POST `
            -QueryString "name=$($this.Name)" -BaseUri $this._baseUri
    }

    # ── SwitchTo — navigates the device to this app ──────────────────────────
    [void] SwitchTo() {
        if ([string]::IsNullOrWhiteSpace($this.Name)) {
            throw 'AwtrixApp.Name must be set before calling SwitchTo().'
        }
        & ([AwtrixAppBase]::InvokeApi) -Endpoint 'switch' -Method POST `
            -Body @{ name = $this.Name } -BaseUri $this._baseUri
    }

    # ── Clone ────────────────────────────────────────────────────────────────
    [AwtrixApp] Clone() {
        return $this.Clone($this.Name)
    }

    [AwtrixApp] Clone([string]$newName) {
        $copy = [AwtrixApp]::new($newName)
        $copy._baseUri = $this._baseUri
        # Guard against null to avoid [ValidateRange] rejecting null assignments.
        if ($null -ne $this.LifetimeSeconds) { $copy.LifetimeSeconds = $this.LifetimeSeconds }
        if ($null -ne $this.LifetimeMode) { $copy.LifetimeMode = $this.LifetimeMode }
        if ($null -ne $this.Position) { $copy.Position = $this.Position }
        if ($null -ne $this.Save) { $copy.Save = $this.Save }
        foreach ($prop in [AwtrixAppBase]::GetPropertyMap().Keys) {
            if ($null -ne $this.$prop) { $copy.$prop = $this.$prop }
        }
        return $copy
    }

    # ── Serialization ────────────────────────────────────────────────────────
    [string] ToJson() {
        $payload = $this.ToPayload()
        $payload['_name'] = $this.Name
        if ($null -ne $this._baseUri) { $payload['_baseUri'] = $this._baseUri }
        return $payload | ConvertTo-Json -Depth 10 -Compress
    }

    static [AwtrixApp] FromJson([string]$json) {
        $data = $json | ConvertFrom-Json -AsHashtable
        $reverseMap = @{}
        foreach ($kv in [AwtrixAppBase]::GetPropertyMap().GetEnumerator()) {
            $reverseMap[$kv.Value] = $kv.Key
        }
        # App-only reverse mapping
        $appKeys = @{ lifetime = 'LifetimeSeconds'; lifetimeMode = 'LifetimeMode'
            pos = 'Position'; save = 'Save'
        }

        $app = [AwtrixApp]::new()
        foreach ($key in $data.Keys) {
            if ($key -eq '_name') { $app.Name = $data[$key]; continue }
            if ($key -eq '_baseUri') { $app._baseUri = $data[$key]; continue }
            if ($reverseMap.ContainsKey($key)) { $app.($reverseMap[$key]) = $data[$key]; continue }
            if ($appKeys.ContainsKey($key)) { $app.($appKeys[$key]) = $data[$key]; continue }
        }
        return $app
    }
}

# ── AwtrixNotification ───────────────────────────────────────────────────────
# Represents a one-time notification that interrupts the app loop.
class AwtrixNotification : AwtrixAppBase {

    # Hold notification until middle-button press or API dismiss.
    [System.Nullable[bool]] $Hold

    # RTTTL ringtone filename (no extension) or DFplayer 4-digit MP3 number.
    [string] $Sound

    # Inline RTTTL sound string played with the notification.
    [string] $Rtttl

    # Loop sound/RTTTL for the duration of the notification.
    [System.Nullable[bool]] $LoopSound

    # Stack notification (true) or replace current notification (false).
    [System.Nullable[bool]] $Stack

    # Wake the matrix for this notification if the display is off.
    [System.Nullable[bool]] $Wakeup

    # Forward notification to additional AWTRIX devices by IP.
    [string[]] $Clients

    # ── Constructors ─────────────────────────────────────────────────────────
    AwtrixNotification() {}

    AwtrixNotification([string]$text) {
        $this.Text = $text
    }

    # ── ToPayload override — merges notification-only fields ─────────────────
    [hashtable] ToPayload() {
        $body = ([AwtrixAppBase]$this).ToPayload()
        if ($null -ne $this.Hold) { $body['hold'] = $this.Hold }
        if ($null -ne $this.LoopSound) { $body['loopSound'] = $this.LoopSound }
        if ($null -ne $this.Stack) { $body['stack'] = $this.Stack }
        if ($null -ne $this.Wakeup) { $body['wakeup'] = $this.Wakeup }
        if (-not [string]::IsNullOrEmpty($this.Sound)) { $body['sound'] = $this.Sound }
        if (-not [string]::IsNullOrEmpty($this.Rtttl)) { $body['rtttl'] = $this.Rtttl }
        if ($null -ne $this.Clients -and $this.Clients.Count -gt 0) {
            $body['clients'] = $this.Clients
        }
        return $body
    }

    # ── Send — dispatches the notification to the device ─────────────────────
    [void] Send() {
        $body = $this.ToPayload()
        & ([AwtrixAppBase]::InvokeApi) -Endpoint 'notify' -Method POST `
            -Body $body -BaseUri $this._baseUri
        $this.ResetDirtyState()
    }

    # ── Clone ────────────────────────────────────────────────────────────────
    [AwtrixNotification] Clone() {
        $copy = [AwtrixNotification]::new()
        $copy._baseUri = $this._baseUri
        $copy.Hold = $this.Hold
        $copy.Sound = $this.Sound
        $copy.Rtttl = $this.Rtttl
        $copy.LoopSound = $this.LoopSound
        $copy.Stack = $this.Stack
        $copy.Wakeup = $this.Wakeup
        $copy.Clients = $this.Clients
        foreach ($prop in [AwtrixAppBase]::GetPropertyMap().Keys) {
            if ($this.$prop -ne $null) {
                $copy.$prop = $this.$prop
            }
        }
        return $copy
    }

    # ── Serialization ────────────────────────────────────────────────────────
    [string] ToJson() {
        $payload = $this.ToPayload()
        if ($null -ne $this._baseUri) { $payload['_baseUri'] = $this._baseUri }
        return $payload | ConvertTo-Json -Depth 10 -Compress
    }

    static [AwtrixNotification] FromJson([string]$json) {
        $data = $json | ConvertFrom-Json -AsHashtable
        $reverseMap = @{}
        foreach ($kv in [AwtrixAppBase]::GetPropertyMap().GetEnumerator()) {
            $reverseMap[$kv.Value] = $kv.Key
        }
        $notifKeys = @{ hold = 'Hold'; sound = 'Sound'; rtttl = 'Rtttl'
            loopSound = 'LoopSound'; stack = 'Stack'
            wakeup = 'Wakeup'; clients = 'Clients'
        }

        $notif = [AwtrixNotification]::new()
        foreach ($key in $data.Keys) {
            if ($key -eq '_baseUri') { $notif._baseUri = $data[$key]; continue }
            if ($reverseMap.ContainsKey($key)) { $notif.($reverseMap[$key]) = $data[$key]; continue }
            if ($notifKeys.ContainsKey($key)) { $notif.($notifKeys[$key]) = $data[$key]; continue }
        }
        return $notif
    }
}
