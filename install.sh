#!/bin/bash
set -e

echo "Installing ubuntu-screenshot-tool..."

# Install dependencies
echo "Installing dependencies (xclip, imagemagick)..."
sudo apt install -y xclip imagemagick

# Install the script
mkdir -p ~/.local/bin
cp screenshot-select ~/.local/bin/screenshot-select
chmod +x ~/.local/bin/screenshot-select

# Ensure ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo "Added ~/.local/bin to PATH in ~/.bashrc"
fi

# Create screenshots directory
mkdir -p ~/Screenshots

# Set up GNOME keybinding (Super+Shift+S)
KEYBIND_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# Find the next available custom keybinding slot
existing=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings 2>/dev/null || echo "@as []")
slot=0
while echo "$existing" | grep -q "custom${slot}"; do
    slot=$((slot + 1))
done
CUSTOM="${KEYBIND_PATH}/custom${slot}/"

# Add to keybinding list
if [ "$existing" = "@as []" ] || [ -z "$existing" ]; then
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['${CUSTOM}']"
else
    new_list=$(echo "$existing" | sed "s/]$/, '${CUSTOM}']/" | sed "s/\[, /[/")
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_list"
fi

# Configure the keybinding
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM} name "Screenshot Select"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM} command "$HOME/.local/bin/screenshot-select"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM} binding "<Super><Shift>s"

echo ""
echo "Done! Press Super+Shift+S to take a screenshot."
echo "Screenshots are saved to ~/Screenshots/"
