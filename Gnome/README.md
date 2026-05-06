# Argonaut GNOME Theme

A dark GTK theme inspired by the macOS Big Sur aesthetic, built around elegant flat surfaces and a deep blue-black color palette. The theme ships with style definitions for GTK 2, GTK 3, GTK 4, GNOME Shell, Cinnamon, Metacity, XFCE (xfwm4), and Plank, so it covers the full visual stack of a GNOME or XFCE desktop.


## What this theme includes

| Component          | Purpose                                               |
|--------------------|-------------------------------------------------------|
| `gtk-2.0/`         | Styles legacy GTK 2 applications                      |
| `gtk-3.0/`         | Styles modern GTK 3 applications                      |
| `gtk-4.0/`         | Styles GTK 4 / libadwaita-free applications           |
| `gnome-shell/`     | Styles the GNOME Shell panel, overview, and popups    |
| `cinnamon/`        | Styles the Cinnamon desktop shell                     |
| `metacity-1/`      | Window decorations for the Metacity/Mutter WM         |
| `xfwm4/`           | Window decorations for the XFCE window manager        |
| `plank/`           | Dock theme for the Plank application launcher         |
| `unity/`           | Unity desktop launcher and window button assets       |


## Dependencies

### Required for GTK theming

- **GNOME Tweaks** (package name `gnome-tweaks` on most distributions) - the standard GNOME Settings app does not expose the GTK or Shell theme selectors; Tweaks does.

  ```
  # Debian / Ubuntu / Pop!_OS
  sudo apt install gnome-tweaks

  # Fedora
  sudo dnf install gnome-tweaks

  # Arch Linux
  sudo pacman -S gnome-tweaks
  ```

### Required for GNOME Shell theming

The Shell theme (the panel, the overview, and notification popups) is controlled separately from the GTK theme. Changing it requires the **User Themes** GNOME Shell extension.

1. Install the extension host connector for your browser:

   ```
   # Debian / Ubuntu
   sudo apt install chrome-gnome-shell

   # Fedora
   sudo dnf install gnome-browser-connector

   # Arch Linux
   sudo pacman -S gnome-browser-connector
   ```

2. Visit https://extensions.gnome.org/extension/19/user-themes/ in Firefox or Chromium and enable the extension. Alternatively, install it from the command line:

   ```
   # Requires the gnome-shell-extension-installer tool or manual download
   # The extension UUID is: user-theme@gnome-shell-extensions.gcampax.github.com
   ```

   On some distributions the extension is packaged directly:

   ```
   # Fedora
   sudo dnf install gnome-shell-extension-user-theme

   # Ubuntu (via GNOME Extensions)
   sudo apt install gnome-shell-extensions
   ```

3. After installing the extension, log out and log back in (or restart the Shell with `Alt+F2`, type `r`, press Enter on X11 only).

4. Open GNOME Tweaks, navigate to the Appearance section, and you will find a Shell theme selector alongside the GTK theme selector.

### Recommended: cursor theme

The `index.theme` file references `WhiteSur-cursors` as the companion cursor theme. Without it the cursor will fall back to the system default. You can obtain WhiteSur-cursors from its upstream repository and install it to `~/.local/share/icons/` or `/usr/share/icons/`.

### Optional: Plank dock

If you use the Plank dock, the `plank/` directory contains a matching dock theme. Plank is available in most distribution repositories:

```
# Debian / Ubuntu
sudo apt install plank

# Arch Linux
sudo pacman -S plank
```


## Installation location

GTK themes can be installed at two levels:

- **User-level** (recommended): `~/.local/share/themes/Argonaut/` - affects only your user account, no root required.
- **System-level**: `/usr/share/themes/Argonaut/` - affects all users, requires root.

The install script uses the user-level path by default.


## Manual installation

1. Copy the `Argonaut/` directory to the themes location:

   ```
   cp -r Argonaut ~/.local/share/themes/
   ```

2. Open GNOME Tweaks and go to the Appearance tab.

3. Set the following:
   - **Applications** (GTK theme): Argonaut
   - **Shell** (requires User Themes extension): Argonaut
   - **Legacy Applications** (GTK 2): Argonaut

4. To apply from the command line instead of Tweaks:

   ```
   # GTK theme
   gsettings set org.gnome.desktop.interface gtk-theme 'Argonaut'

   # Icon theme (if you have a matching icon set)
   gsettings set org.gnome.desktop.interface icon-theme 'Argonaut'

   # Shell theme (requires User Themes extension)
   gsettings set org.gnome.shell.extensions.user-theme name 'Argonaut'
   ```

5. If you want to apply the Plank dock theme, open Plank preferences (right-click the dock and choose Preferences) and select Argonaut from the theme list. The Plank theme directory must be at `~/.local/share/plank/themes/Argonaut/`.


## Automated installation

Run the provided script from the `Gnome/` directory:

```
bash install.sh
```

The script will:

1. Create `~/.local/share/themes/` if it does not exist.
2. Copy the `Argonaut/` theme directory there.
3. Apply the GTK theme and color scheme via `gsettings`.
4. Attempt to apply the Shell theme via `gsettings` (succeeds only if the User Themes extension is active).
5. Copy the Plank theme to `~/.local/share/plank/themes/` if Plank is installed.
6. Print instructions for any remaining manual steps (Tweaks, extension activation).


## Reverting

To remove the theme:

```
rm -rf ~/.local/share/themes/Argonaut

# Reset GTK theme to the system default
gsettings reset org.gnome.desktop.interface gtk-theme

# Reset Shell theme
gsettings reset org.gnome.shell.extensions.user-theme name
```


## Compatibility notes

- **GTK 4 / libadwaita**: Applications built on libadwaita ignore external GTK themes by default. To force GTK 4 apps to respect the theme, set the environment variable `GTK_THEME=Argonaut` or use the `adw-gtk3` compatibility shim. Results vary per application.
- **XFCE**: Copy the theme to `~/.themes/` (which is the traditional location also recognized by XFCE), then set the window manager theme in XFCE Settings > Window Manager and the GTK theme in XFCE Settings > Appearance.
- **Cinnamon**: The `cinnamon/` subdirectory is recognized automatically when the theme is in `~/.themes/` or `/usr/share/themes/`. Select it in Cinnamon System Settings > Themes > Desktop.
