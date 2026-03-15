# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.4.0] 2026-03-14

### Added

- **First-Class App Objects** — Apps and notifications are now full-fledged
  stateful PowerShell objects with methods, properties, and lifecycle
  management, enabling sophisticated scenarios:
  - `AwtrixApp` class — Represents a persistent custom app with state
    management, dirty tracking, and serialization
  - `AwtrixNotification` class — Represents a one-time notification with
    hold, sound, wakeup, and stacking support
  - `AwtrixAppBase` base class — Shared infrastructure for 24 display
    properties (text, colors, effects, charts, drawing, overlays, etc.)
  - `AwtrixAppCollection` class — Multi-page app batching via single API
    call (device-assigned suffixes: BaseName0, BaseName1, etc.)
- `New-AwtrixApp` cmdlet — Create and optionally push `[AwtrixApp]`
  objects. Returns object for property mutation, template cloning, and
  serialization workflows
- `New-AwtrixNotification` cmdlet — Create `[AwtrixNotification]` objects
  for deferred or immediate dispatch
- `Update-AwtrixApp` cmdlet — Pipeline cmdlet to update app properties and
  push. Supports `-DirtyOnly` for incremental updates (only changed
  properties sent to device)
- `New-AwtrixAppCollection` cmdlet — Batch multi-page apps with unified
  push/remove operations
- Object methods: `Push()`, `Push($dirtyOnly)`, `Remove()`, `SwitchTo()`,
  `Send()` for imperative app lifecycle
- Object methods: `ToJson()`, `FromJson()` for config serialization and
  restoration
- Object method: `Clone($newName)` for template/variant patterns
- Object method: `GetDirtyPayload()` for incremental updates
- Type accelerators for new classes: `[AwtrixApp]`, `[AwtrixNotification]`,
  `[AwtrixAppBase]`, `[AwtrixAppCollection]`

### Changed

- `Set-AwtrixApp` now internally uses `[AwtrixApp]` class and supports
  `-PassThru` to return the object. Fully backward-compatible — omit
  `-PassThru` for fire-and-forget behavior (default)
- `Send-AwtrixNotification` now internally uses `[AwtrixNotification]`
  class and supports `-PassThru`. Fully backward-compatible
- Module loading now establishes static delegate
  `[AwtrixAppBase]::InvokeApi` during initialization to enable class
  methods to call module-scoped `InvokeAwtrixApi` function

## [0.3.0] 2026-03-13

### Added

- `GapSize` parameter on `Show-AwtrixScreen` — Control black pixel spacing
  between LEDs to simulate the dark borders on a real matrix display

## [0.2.0] 2026-03-13

### Added

- `Show-AwtrixScreen` — Render the current AWTRIX screen as colored pixels in the terminal using PwshSpectreConsole Canvas
- `AwtrixColor` enum — Named colors (Red, Green, Blue, Yellow, Cyan, Magenta, White, Black, Orange, Purple, Pink) for intuitive color selection
- `AwtrixIndicatorPosition` enum — Descriptive indicator positions (Top, Middle, Bottom) instead of numeric IDs
- `AwtrixColorTransformAttribute` — Custom transform attribute for automatic color conversion across all color parameters
- Type accelerators for `AwtrixColor`, `AwtrixIndicatorPosition`, and `AwtrixColorTransformAttribute`

### Changed

- **Indicator Naming**: Replaced numeric indicator IDs (1, 2, 3) with descriptive enum values:
  - `-Id 1` → `-Position Top` (upper right corner)
  - `-Id 2` → `-Position Middle` (right side)
  - `-Id 3` → `-Position Bottom` (lower right corner)
- **Time Parameter UX**: All time-based parameters now have explicit units in their names:
  - `-Blink` → `-BlinkMilliseconds` (alias `-BlinkMs`)
  - `-Fade` → `-FadeMilliseconds` (alias `-FadeMs`)
  - `-BlinkText` → `-BlinkTextMilliseconds` (alias `-BlinkTextMs`)
  - `-FadeText` → `-FadeTextMilliseconds` (alias `-FadeTextMs`)
  - `-Duration` → `-DurationSeconds` (alias `-DurationSec`)
  - `-Lifetime` → `-LifetimeSeconds` (alias `-LifetimeSec`)
- **Color Parameter Handling**: All color parameters now accept named colors via `AwtrixColor` enum, with automatic conversion to hex or RGB arrays
- **Module Loading Order**: Classes now load before functions to ensure transform attributes are available at parse time
- **Test Infrastructure**: Updated all Pester tests to import from built module output via build environment variables for consistency with deployment
- **Payload Mapping**: Updated `NewAppPayload` parameter mapping to use renamed parameter names

## [0.1.0] 2026-03-13

### Added

- **Connection Management**
  - `Connect-Awtrix` — Establish a session to an AWTRIX 3 device (validates via `/api/stats`)
  - `Disconnect-Awtrix` — Clear the stored session

- **Status & Retrieval**
  - `Get-AwtrixStats` — Retrieve device statistics (battery, RAM, uptime, etc.)
  - `Get-AwtrixEffect` — List available background effects
  - `Get-AwtrixTransition` — List available transition effects
  - `Get-AwtrixAppLoop` — List all apps in the current display loop
  - `Get-AwtrixScreen` — Capture the current matrix screen as a 24-bit color array
  - `Get-AwtrixSetting` — Read all device settings

- **Power & Sleep**
  - `Set-AwtrixPower` — Toggle the matrix display on or off
  - `Start-AwtrixSleep` — Send the device into timed deep sleep

- **Sound**
  - `Send-AwtrixSound` — Play a named sound from the MELODIES folder or DFplayer MP3
  - `Send-AwtrixRtttl` — Play an RTTTL melody string directly

- **Mood Lighting**
  - `Set-AwtrixMoodlight` — Set the matrix to a color, Kelvin temperature, or disable

- **Indicators**
  - `Set-AwtrixIndicator` — Set a colored indicator (1-3) with optional blink/fade
  - `Clear-AwtrixIndicator` — Hide a specific indicator

- **Custom Apps & Notifications**
  - `Set-AwtrixApp` — Create or update a custom app with 35+ properties (text, icons, charts, progress bars, drawing instructions, effects, overlays, etc.)
  - `Remove-AwtrixApp` — Delete a custom app by name
  - `Send-AwtrixNotification` — Send a one-time notification with hold, sound, wakeup, and stacking support
  - `Clear-AwtrixNotification` — Dismiss a held notification

- **App Navigation**
  - `Switch-AwtrixApp` — Switch to next, previous, or a specific named app

- **Settings**
  - `Set-AwtrixSetting` — Update 34 device settings (brightness, transitions, colors, time/date formats, built-in app visibility, volume, overlays, etc.)

- **Maintenance**
  - `Update-AwtrixFirmware` — Trigger a firmware update
  - `Restart-Awtrix` — Reboot the device
  - `Reset-Awtrix` — Factory reset (format flash/EEPROM, preserves WiFi)
  - `Reset-AwtrixSetting` — Reset all settings to defaults

- **Builder Helpers**
  - `New-AwtrixDrawing` — Create drawing instruction objects (pixel, line, rectangle, filled rectangle, circle, filled circle, text, bitmap)
  - `New-AwtrixTextFragment` — Create colored text fragments for multi-color display

- **Private Helpers**
  - `GetAwtrixConnection` — Resolve session URI or `-BaseUri` override
  - `InvokeAwtrixApi` — Central `Invoke-RestMethod` wrapper with JSON/plain-text support
  - `ConvertColorInput` — Normalize hex string / RGB array color inputs
  - `NewAppPayload` — Map PowerShell parameter names to AWTRIX API JSON keys
