---
name: awtrix
description: >
  Use the awtrix PowerShell module to control AWTRIX 3 pixel clock devices — push custom apps,
  send notifications, set indicators, play sounds, draw pixels, and automate display content.
  Use this skill whenever the user mentions AWTRIX, pixel clock, pixel display, LED matrix notifications,
  or wants to script interactions with an AWTRIX device, even if they don't name the module directly.
  Also use when the user asks to display data, alerts, or dashboards on a small LED/pixel display.
---

# AWTRIX PowerShell Module

Control AWTRIX 3 pixel clock devices from PowerShell. The device is a 32×8 RGB LED matrix
with a REST API. This module wraps that API with idiomatic cmdlets and first-class objects.

## Connection

Always connect first (or pass `-BaseUri` to every call):

```powershell
Connect-Awtrix -BaseUri '192.168.1.100'   # http:// prefix is optional
```

## Core Concepts

There are two ways to put content on the display:

- **Custom Apps** — persistent slots in the device's display loop. They cycle automatically.
  Created with `New-AwtrixApp` or `Set-AwtrixApp`. Stay on the device until removed.
- **Notifications** — one-time interrupts that overlay the current display, then disappear.
  Created with `New-AwtrixNotification` or `Send-AwtrixNotification`.

Both share the same rich set of visual properties (text, color, icon, charts, progress bars,
drawing instructions, effects, etc.).

## Quick Patterns

### Display text on the device

```powershell
# Fire-and-forget (simplest)
Set-AwtrixApp -Name 'hello' -Text 'Hello World' -Color Red -Icon 1

# Object approach (modify locally, then push)
$app = New-AwtrixApp -Name 'weather' -Text '72°F' -Icon 2345 -Color '#00FF00'
$app.Push()

# Update later — only changed properties are sent
$app.Text = '68°F'
$app.Color = 'Blue'
$app.Push($true)   # dirty-only push
```

### Send a notification

```powershell
# One-liner
Send-AwtrixNotification -Text 'Meeting in 5min' -Color Yellow -Sound 'alarm' -DurationSeconds 10

# With hold (stays until dismissed)
Send-AwtrixNotification -Text 'URGENT' -Hold -Wakeup

# Object approach
$n = New-AwtrixNotification -Text 'Build failed!' -Color Red -Icon 123
$n.Sound = 'beep'
$n.Send()
```

### Multi-colored text

```powershell
$fragments = @(
    New-AwtrixTextFragment -Text 'OK: ' -Color Green
    New-AwtrixTextFragment -Text '3' -Color White
    New-AwtrixTextFragment -Text ' FAIL: ' -Color Red
    New-AwtrixTextFragment -Text '1' -Color White
)
Set-AwtrixApp -Name 'ci' -Text $fragments
```

### Charts and progress bars

```powershell
# Bar chart (max 16 values without icon, 11 with)
Set-AwtrixApp -Name 'temps' -Bar @(20, 22, 25, 23, 21, 19, 18) -Autoscale

# Line chart
Set-AwtrixApp -Name 'stock' -Line @(100, 102, 98, 105, 110) -Autoscale -Color Cyan

# Progress bar
Set-AwtrixApp -Name 'deploy' -Text 'Deploy' -Progress 75 -ProgressColor Green
```

### Drawing on the matrix

```powershell
$draws = @(
    New-AwtrixDrawing -FilledRectangle -X 0 -Y 0 -Width 32 -Height 8 -Color Blue
    New-AwtrixDrawing -Circle -X 16 -Y 4 -Radius 3 -Color Yellow
    New-AwtrixDrawing -Text -X 2 -Y 1 -Text 'Hi' -Color White
)
Set-AwtrixApp -Name 'art' -Draw $draws
```

### Indicators (small status dots)

```powershell
Set-AwtrixIndicator -Position Top -Color Red                          # solid
Set-AwtrixIndicator -Position Middle -Color Green -BlinkMilliseconds 500  # blinking
Clear-AwtrixIndicator -Position Bottom
```

### Templates and cloning

```powershell
$template = New-AwtrixApp -Text '' -Icon 1234 -Color White -DurationSeconds 5
$morning = $template.Clone('morning')
$morning.Text = 'Good morning'
$evening = $template.Clone('evening')
$evening.Text = 'Good night'
$evening.Icon = 5678
$morning.Push(); $evening.Push()
```

### Multi-page apps

```powershell
$page1 = New-AwtrixApp -Name 'p1' -Text 'Page 1' -Color Red
$page2 = New-AwtrixApp -Name 'p2' -Text 'Page 2' -Color Blue
$collection = New-AwtrixAppCollection -BaseName 'multi' -Apps @($page1, $page2) -Push
```

### Pipeline updates

```powershell
$app | Update-AwtrixApp -Text 'New text' -Color Green -DirtyOnly
```

### Serialization (save/restore configs)

```powershell
$app.ToJson() | Set-Content config.json
$restored = [AwtrixApp]::FromJson((Get-Content config.json -Raw))
$restored.Push()
```

## All Visual Properties

These work on both apps and notifications:

| Property | Type | Description |
|---|---|---|
| Text | string or fragment[] | Display text (plain string or colored fragments) |
| TextCase | int (0/1/2) | 0=global, 1=uppercase, 2=as-sent |
| Color | color | Text color |
| Gradient | color[2] | Two-color text gradient |
| Background | color | Background color |
| Rainbow | bool | RGB spectrum effect on text |
| BlinkTextMilliseconds | int | Blink interval (alias: BlinkTextMs) |
| FadeTextMilliseconds | int | Fade interval (alias: FadeTextMs) |
| Icon | string | Icon ID, filename, or Base64 8×8 JPG |
| PushIcon | int (0/1/2) | 0=static, 1=scroll once, 2=loop |
| TopText | bool | Draw text above normal position |
| TextOffset | int | X-axis pixel offset |
| Center | bool | Center short text |
| NoScroll | bool | Disable scrolling |
| ScrollSpeed | int | Scroll speed percentage |
| Repeat | int | Scroll count (-1=infinite) |
| DurationSeconds | int | Display time (alias: DurationSec) |
| Bar | int[] | Bar chart data (max 16 values) |
| Line | int[] | Line chart data (max 16 values) |
| Autoscale | bool | Auto-scale chart axes |
| Progress | int | Progress bar 0–100 |
| ProgressColor | color | Progress bar color |
| ProgressBackgroundColor | color | Progress bar background |
| BarBackgroundColor | color | Chart bar background |
| Effect | string | Background effect name |
| EffectSettings | hashtable | Effect customization |
| Draw | hashtable[] | Drawing instructions |
| Overlay | string | clear, snow, rain, drizzle, storm, thunder, frost |

**App-only:** LifetimeSeconds, LifetimeMode (0=delete, 1=stale border), Position, Save (persist to flash)

**Notification-only:** Hold, Sound, Rtttl, LoopSound, Stack, Wakeup, Clients (forward to other devices)

## Color Formats

All color parameters accept any of these:
- Named: `Red`, `Green`, `Blue`, `Yellow`, `Cyan`, `Magenta`, `White`, `Black`, `Orange`, `Purple`, `Pink`
- Hex: `'#FF0000'` or `'FF0000'`
- RGB array: `@(255, 0, 0)`

## Other Useful Cmdlets

```powershell
Get-AwtrixStats                        # battery, RAM, uptime, WiFi
Get-AwtrixAppLoop                      # list apps in display loop
Switch-AwtrixApp -Name 'weather'       # jump to specific app
Switch-AwtrixApp -Next                 # next/previous in loop

Set-AwtrixMoodlight -Color Purple -Brightness 128   # ambient lighting
Set-AwtrixMoodlight -Disable

Send-AwtrixSound -Sound 'alarm'        # play from MELODIES folder
Send-AwtrixRtttl -Rtttl 'Mario:...'    # inline RTTTL melody

Set-AwtrixPower -On / -Off
Start-AwtrixSleep -Seconds 3600        # deep sleep
Show-AwtrixScreen                      # render matrix in terminal (needs PwshSpectreConsole)
Get-AwtrixEffect                       # list available effects
Get-AwtrixTransition                   # list available transitions
Set-AwtrixSetting -Brightness 80       # 40+ device settings
```

## Automation Tips

When building scripts that poll or schedule updates:

- Use `New-AwtrixApp` to create an object once, then update properties and call `.Push($true)` in a loop — this sends only changed values.
- For timed notifications (e.g., calendar reminders), calculate the delay with `New-TimeSpan` or `Start-Sleep`, then call `Send-AwtrixNotification`.
- Use `-Wakeup` on notifications to turn the display on if it may be sleeping.
- Use `-LifetimeSeconds` on apps so stale data auto-removes if your script stops.
- Use `$app.Remove()` or `Remove-AwtrixApp` for cleanup.
- Forward notifications to multiple devices with `-Clients @('192.168.1.101', '192.168.1.102')`.
