# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.1.0] Unreleased

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
