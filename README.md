# awtrix

A PowerShell module for managing [AWTRIX
3](https://blueforcer.github.io/awtrix3/) pixel clocks via the HTTP API.

## Overview

The **awtrix** module provides 27 commands covering every endpoint of the AWTRIX
3 HTTP API:

| Category          | Commands                                                                                                                    |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------|
| **Connection**    | `Connect-Awtrix`, `Disconnect-Awtrix`                                                                                       |
| **Status**        | `Get-AwtrixStats`, `Get-AwtrixEffect`, `Get-AwtrixTransition`, `Get-AwtrixAppLoop`, `Get-AwtrixScreen`, `Get-AwtrixSetting` |
| **Power**         | `Set-AwtrixPower`, `Start-AwtrixSleep`                                                                                      |
| **Sound**         | `Send-AwtrixSound`, `Send-AwtrixRtttl`                                                                                      |
| **Mood Light**    | `Set-AwtrixMoodlight`                                                                                                       |
| **Indicators**    | `Set-AwtrixIndicator`, `Clear-AwtrixIndicator`                                                                              |
| **Apps**          | `Set-AwtrixApp`, `Remove-AwtrixApp`, `Switch-AwtrixApp`                                                                     |
| **Notifications** | `Send-AwtrixNotification`, `Clear-AwtrixNotification`                                                                       |
| **Settings**      | `Set-AwtrixSetting`                                                                                                         |
| **Maintenance**   | `Update-AwtrixFirmware`, `Restart-Awtrix`, `Reset-Awtrix`, `Reset-AwtrixSetting`                                            |
| **Builders**      | `New-AwtrixDrawing`, `New-AwtrixTextFragment`                                                                               |

## Requirements

- PowerShell 5.1+ or PowerShell 7+
- An AWTRIX 3 device on your network

## Installation

```powershell
# From PSGallery (when published)
Install-Module -Name awtrix -Scope CurrentUser

# From source
git clone <repo-url>
Import-Module ./awtrix/awtrix.psd1
```

## Quick Start

```powershell
# Connect to your device
Connect-Awtrix -BaseUri '192.168.1.100'

# Check device status
Get-AwtrixStats

# Display a custom app
Set-AwtrixApp -Name 'hello' -Text 'Hello World!' -Rainbow -Duration 10

# Send a notification
Send-AwtrixNotification -Text 'Alert!' -Color '#FF0000' -Icon 'warning' -Sound 'alarm'

# Disconnect
Disconnect-Awtrix
```

## Examples

### Custom App with Icon and Color

```powershell
Set-AwtrixApp -Name 'weather' -Text '72°F Sunny' -Icon 'weather_sunny' -Color '#FF6600'
```

### Bar Chart

```powershell
Set-AwtrixApp -Name 'chart' -Bar @(3, 7, 2, 9, 5, 8, 1, 6) -Color '#00FF00'
```

### Drawing Instructions

```powershell
$drawings = @(
    New-AwtrixDrawing -FilledCircle -X 16 -Y 4 -Radius 3 -Color '#FF0000'
    New-AwtrixDrawing -Text -X 0 -Y 0 -TextContent 'Hi' -Color '#FFFFFF'
)
Set-AwtrixApp -Name 'art' -Draw $drawings
```

### Colored Text Fragments

```powershell
$fragments = @(
    New-AwtrixTextFragment -Text 'CPU: ' -Color 'FFFFFF'
    New-AwtrixTextFragment -Text '47°C' -Color '00FF00'
)
Send-AwtrixNotification -Text $fragments -Duration 10
```

### Indicators

```powershell
# Set a blinking red indicator in the upper-right corner
Set-AwtrixIndicator -Id 1 -Color '#FF0000' -Blink 500

# Clear it
Clear-AwtrixIndicator -Id 1
```

### Mood Lighting

```powershell
# Warm white mood light
Set-AwtrixMoodlight -Brightness 170 -Kelvin 2300

# Disable
Set-AwtrixMoodlight -Disable
```

### Settings

```powershell
# Adjust brightness and transition
Set-AwtrixSetting -Brightness 150 -TransitionEffect 1 -TransitionSpeed 300

# Read current settings
Get-AwtrixSetting
```

### Using `-BaseUri` Without a Session

Every command accepts `-BaseUri` to target a device without calling `Connect-Awtrix` first:

```powershell
Get-AwtrixStats -BaseUri '192.168.1.100'
Send-AwtrixNotification -Text 'Quick message' -BaseUri '10.0.0.50'
```

## Contributing

1. Clone the repository
2. Install dependencies: `./build.ps1 -Bootstrap`
3. Run tests: `./build.ps1 -Task Test`

## License

See [LICENSE](LICENSE) for details.
