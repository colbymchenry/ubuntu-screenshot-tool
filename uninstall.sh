#!/bin/bash
set -e

echo "Uninstalling ubuntu-screenshot-tool..."

# Remove the script
rm -f ~/.local/bin/screenshot-select

# Remove the GNOME keybinding
KEYBIND_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
existing=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings 2>/dev/null || echo "@as []")

# Find and remove any slot pointing to screenshot-select
for i in $(seq 0 20); do
    CUSTOM="${KEYBIND_PATH}/custom${i}/"
    cmd=$(gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM} command 2>/dev/null || true)
    if echo "$cmd" | grep -q "screenshot-select"; then
        # Reset this keybinding
        gsettings reset org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM} name
        gsettings reset org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM} command
        gsettings reset org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM} binding
        # Remove from list
        new_list=$(echo "$existing" | sed "s|, '${CUSTOM}'||" | sed "s|'${CUSTOM}', ||" | sed "s|'${CUSTOM}'||")
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_list"
        echo "Removed keybinding."
        break
    fi
done

echo "Done. Screenshots in ~/Screenshots/ were not removed."
