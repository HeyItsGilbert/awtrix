# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

PowerShell module for controlling AWTRIX 3 pixel clock devices via their HTTP REST API. Wraps 27+ API endpoints with idiomatic PowerShell cmdlets and first-class object types.

## Build & Test Commands

```powershell
# Bootstrap dependencies (first time setup)
./build.ps1 -Bootstrap

# Run tests (default task)
./build.ps1

# Run specific build task
./build.ps1 -Task Test

# List available tasks
./build.ps1 -Help
```

Build uses psake via `psakeFile.ps1`. Dependencies defined in `requirements.psd1`. Tests use Pester 5.7.1, linting uses PSScriptAnalyzer with settings in `tests/ScriptAnalyzerSettings.psd1`. Test results output to `out/testResults.xml`.

**Important**: Tests import from the built `Output/` directory, not from `awtrix/` source directly.

## Architecture

### Module Loading Chain

1. `awtrix.psd1` runs `ScriptsToProcess: @('Class/AwtrixTypes.ps1')` before module load
2. `awtrix.psm1` dot-sources classes, then all Public/ and Private/ functions
3. Module init wires the static delegate `[AwtrixAppBase]::InvokeApi` so classes can call module-scoped `InvokeAwtrixApi`
4. Type accelerators registered for all exported classes

The delegate pattern exists because classes in `ScriptsToProcess` run before the module scope exists, so they can't directly call module-scoped functions.

### Class Hierarchy (`Class/AwtrixApp.ps1`)

- **AwtrixAppBase**: 24 shared properties, `ToPayload()`, `ToJson()`, `GetDirtyPayload()`, static property map (PowerShell names → API JSON keys)
- **AwtrixApp** (extends AwtrixAppBase): Persistent custom apps with `Push()`, `Remove()`, `SwitchTo()`, `Clone()`, dirty tracking via `_lastPushed` snapshot
- **AwtrixNotification** (extends AwtrixAppBase): One-time interrupts with `Send()`
- **AwtrixAppCollection** (`Class/AwtrixAppCollection.ps1`): Multi-page app batching

### Key Conventions

- **Color handling**: `AwtrixColorTransformAttribute` normalizes enum names, hex strings, and RGB arrays. Applied to all color parameters.
- **Time parameters**: Named with explicit units — `DurationSeconds` (alias `DurationSec`), `BlinkMilliseconds` (alias `BlinkMs`), etc.
- **Connection**: Module-scoped `$script:AwtrixConnection` set by `Connect-Awtrix`. All cmdlets accept `-BaseUri` override.
- **API calls**: All HTTP goes through `Private/InvokeAwtrixApi.ps1`.
- **Payload mapping**: `AwtrixAppBase::GetPropertyMap()` is the canonical source for property-to-JSON-key mapping. Legacy `NewAppPayload` helper still used by older cmdlets.

### Cmdlet Patterns

- `Set-*` / `Send-*`: Procedural fire-and-forget (legacy style, wraps classes internally)
- `New-*`: Factory functions returning typed objects
- `Update-AwtrixApp`: Pipeline cmdlet for property mutation + push
- `-PassThru` switch: Returns object when present on procedural cmdlets

### Testing Pattern

Each test file mocks `Invoke-RestMethod` at module scope and sets up a fake `$script:AwtrixConnection`. Tests run against the built module from `Output/`, not source.
