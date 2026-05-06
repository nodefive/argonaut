#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ICON_THEME_NAME="Argonaut"
ICON_SOURCE="$SCRIPT_DIR/$ICON_THEME_NAME"

# ---------------------------------------------------------------------------
# Validate source
# ---------------------------------------------------------------------------

if [[ ! -d "$ICON_SOURCE" ]]; then
    echo "ERROR: Icon theme directory not found: $ICON_SOURCE" >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# Install icon theme
# ---------------------------------------------------------------------------

ICONS_DIR="$HOME/.local/share/icons"
mkdir -p "$ICONS_DIR"

echo "Installing icon theme to $ICONS_DIR/$ICON_THEME_NAME ..."
rm -rf "$ICONS_DIR/$ICON_THEME_NAME"
cp -r "$ICON_SOURCE" "$ICONS_DIR/$ICON_THEME_NAME"
echo "Icon theme installed."

# ---------------------------------------------------------------------------
# Rebuild icon cache
# ---------------------------------------------------------------------------

if command -v gtk-update-icon-cache &>/dev/null; then
    gtk-update-icon-cache -f -t "$ICONS_DIR/$ICON_THEME_NAME"
    echo "Icon cache updated."
else
    echo "NOTE: gtk-update-icon-cache not found. The icon theme may not appear until"
    echo "you log out and back in, or run: gtk-update-icon-cache -f -t $ICONS_DIR/$ICON_THEME_NAME"
fi

# ---------------------------------------------------------------------------
# Apply icon theme via gsettings
# ---------------------------------------------------------------------------

if command -v gsettings &>/dev/null; then
    if gsettings get org.gnome.desktop.interface icon-theme &>/dev/null 2>&1; then
        gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME_NAME"
        echo "Applied icon theme via gsettings: $ICON_THEME_NAME"
    fi
else
    echo "gsettings not found. Skipping automatic icon theme application."
    echo "Apply the theme manually using GNOME Tweaks or your desktop's appearance settings."
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo ""
echo "Installation complete."
echo ""
echo "If GNOME Tweaks is installed, open it and verify under Appearance > Icons:"
echo "  Icons: $ICON_THEME_NAME"
echo ""
echo "To install GNOME Tweaks if it is not present:"
echo "  Debian/Ubuntu:  sudo apt install gnome-tweaks"
echo "  Fedora:         sudo dnf install gnome-tweaks"
echo "  Arch Linux:     sudo pacman -S gnome-tweaks"
