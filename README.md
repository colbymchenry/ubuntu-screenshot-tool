# Ubuntu Screenshot Tool

Windows-style region select screenshot tool for Ubuntu. Press **Super+Shift+S**, drag to select a region, and the screenshot is saved to a file and copied to your clipboard.

![screenshot-demo](https://img.shields.io/badge/hotkey-Super%2BShift%2BS-blue)

## Features

- **Region select** with dimmed overlay showing your selection in full brightness
- **Saves to file** in `~/Screenshots/screenshot-YYYY-MM-DD_HH-MM-SS.png`
- **Copies image to clipboard** for pasting into any app (browsers, editors, terminals, chat apps)
- **Desktop notification** when screenshot is captured
- **Escape to cancel**
- **Crosshair cursor** during selection
- **Multi-monitor safe** (captures the full virtual screen)
- **Minimal dependencies** — uses Python3/GTK3 and ImageMagick (pre-installed on Ubuntu), only needs `xclip` installed

## Install

```bash
git clone https://github.com/colbymchenry/ubuntu-screenshot-tool.git
cd ubuntu-screenshot-tool
bash install.sh
```

This will:
1. Install `xclip` and `imagemagick` (if not already installed)
2. Copy the script to `~/.local/bin/screenshot-select`
3. Bind **Super+Shift+S** in GNOME settings

## Uninstall

```bash
cd ubuntu-screenshot-tool
bash uninstall.sh
```

## Usage

1. Press **Super+Shift+S**
2. Click and drag to select a region
3. Release to capture

The screenshot is:
- Saved to `~/Screenshots/`
- Copied to your clipboard as an image (paste with **Ctrl+V** anywhere)

Press **Escape** to cancel.

## Requirements

- Ubuntu (or any GNOME-based Linux distro)
- Python 3 (pre-installed)
- GTK 3 / PyGObject (pre-installed: `python3-gi`)
- ImageMagick (pre-installed: `import`, `convert`)
- xclip (installed automatically by `install.sh`)

## License

MIT
