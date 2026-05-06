#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="Argonaut"
THEME_SOURCE="$SCRIPT_DIR/$THEME_NAME"

# ---------------------------------------------------------------------------
# Validate source
# ---------------------------------------------------------------------------

if [[ ! -d "$THEME_SOURCE" ]]; then
    echo "ERROR: Theme directory not found: $THEME_SOURCE" >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# Install GTK theme
# ---------------------------------------------------------------------------

GTK_THEMES_DIR="$HOME/.local/share/themes"
mkdir -p "$GTK_THEMES_DIR"

echo "Installing GTK theme to $GTK_THEMES_DIR/$THEME_NAME ..."
rm -rf "$GTK_THEMES_DIR/$THEME_NAME"
cp -r "$THEME_SOURCE" "$GTK_THEMES_DIR/$THEME_NAME"
echo "GTK theme installed."

# ---------------------------------------------------------------------------
# Apply GTK theme via gsettings (works on GNOME and compatible desktops)
# ---------------------------------------------------------------------------

if command -v gsettings &>/dev/null; then
    if gsettings get org.gnome.desktop.interface gtk-theme &>/dev/null 2>&1; then
        gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
        echo "Applied GTK theme via gsettings: $THEME_NAME"
    fi

    # Color scheme hint (supported by GTK 4 / newer GNOME)
    if gsettings get org.gnome.desktop.interface color-scheme &>/dev/null 2>&1; then
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        echo "Set color-scheme to prefer-dark"
    fi

    # Attempt to set the Shell theme (requires User Themes extension to be active)
    SHELL_SCHEMA="org.gnome.shell.extensions.user-theme"
    if gsettings list-schemas 2>/dev/null | grep -qF "$SHELL_SCHEMA"; then
        gsettings set "$SHELL_SCHEMA" name "$THEME_NAME"
        echo "Applied Shell theme via gsettings: $THEME_NAME"
    else
        echo ""
        echo "NOTE: GNOME Shell theme could not be applied automatically."
        echo "The 'User Themes' GNOME Shell extension is not active."
        echo ""
        echo "To enable Shell theming:"
        echo "  1. Install the 'User Themes' extension from https://extensions.gnome.org/extension/19/user-themes/"
        echo "  2. Log out and back in (or press Alt+F2, type 'r', press Enter on X11)"
        echo "  3. Open GNOME Tweaks > Appearance > Shell and select Argonaut"
    fi
else
    echo "gsettings not found. Skipping automatic theme application."
    echo "Apply the theme manually using GNOME Tweaks or your desktop's appearance settings."
fi

# ---------------------------------------------------------------------------
# Install Plank dock theme (if Plank is present)
# ---------------------------------------------------------------------------

if command -v plank &>/dev/null; then
    PLANK_THEMES_DIR="$HOME/.local/share/plank/themes"
    mkdir -p "$PLANK_THEMES_DIR/$THEME_NAME"
    PLANK_SOURCE="$THEME_SOURCE/plank/dock.theme"
    if [[ -f "$PLANK_SOURCE" ]]; then
        cp "$PLANK_SOURCE" "$PLANK_THEMES_DIR/$THEME_NAME/dock.theme"
        echo "Installed Plank theme to $PLANK_THEMES_DIR/$THEME_NAME/dock.theme"
        echo "To apply: right-click the Plank dock > Preferences > Theme > Argonaut"
    fi
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo ""
echo "Installation complete."
echo ""
echo "If GNOME Tweaks is installed, open it and verify the following under Appearance:"
echo "  - Applications (GTK theme): $THEME_NAME"
echo "  - Shell (if User Themes extension is active): $THEME_NAME"
echo "  - Legacy Applications (GTK 2): $THEME_NAME"
echo ""
echo "To install GNOME Tweaks if it is not present:"
echo "  Debian/Ubuntu:  sudo apt install gnome-tweaks"
echo "  Fedora:         sudo dnf install gnome-tweaks"
echo "  Arch Linux:     sudo pacman -S gnome-tweaks"
echo ""
echo "Recommended companion cursor theme: WhiteSur-cursors"
echo "Install it to ~/.local/share/icons/ and select it in GNOME Tweaks > Appearance > Cursor."
