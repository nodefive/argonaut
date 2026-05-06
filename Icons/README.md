# Argonaut Icon Theme

A comprehensive icon theme designed to complement the Argonaut GTK theme. Built around a consistent visual language across all icon sizes (8×8 through 128×128) with full HiDPI (@2x) variants, symbolic icons, and coverage for actions, applications, categories, devices, emblems, mimetypes, places, and status contexts.


## What this theme includes

| Size range        | Variants included                                      |
|-------------------|--------------------------------------------------------|
| 8×8               | Emblems                                                |
| 16×16 – 32×32     | Full context set + @2x HiDPI + symbolic                |
| 42×42 – 48×48     | Apps, full context set + @2x HiDPI                     |
| 64×64 – 128×128   | Apps, categories, devices, mimetypes, places           |

The theme inherits from `breeze` and `hicolor` as fallbacks, so any icon not provided directly will fall through to those themes.


## Installation location

Icon themes are installed at:

- **User-level** (recommended): `~/.local/share/icons/Argonaut/` — affects only your user account, no root required.
- **System-level**: `/usr/share/icons/Argonaut/` — affects all users, requires root.

The install script uses the user-level path by default.


## Manual installation

1. Copy the `Argonaut/` directory to the icons location:

   ```
   cp -r Argonaut ~/.local/share/icons/
   ```

2. Update the icon cache so the desktop environment picks up the new theme:

   ```
   gtk-update-icon-cache -f -t ~/.local/share/icons/Argonaut
   ```

3. Apply the icon theme via the command line:

   ```
   gsettings set org.gnome.desktop.interface icon-theme 'Argonaut'
   ```

   Or open GNOME Tweaks > Appearance > Icons and select **Argonaut**.


## Automated installation

Run the provided script from the `Icons/` directory:

```
bash install.sh
```

The script will:

1. Create `~/.local/share/icons/` if it does not exist.
2. Copy the `Argonaut/` icon directory there.
3. Rebuild the icon cache with `gtk-update-icon-cache`.
4. Apply the icon theme via `gsettings`.


## Dependencies

- **GNOME Tweaks** — needed to select the icon theme through a GUI if you prefer not to use the command line.

  ```
  # Debian / Ubuntu / Pop!_OS
  sudo apt install gnome-tweaks

  # Fedora
  sudo dnf install gnome-tweaks

  # Arch Linux
  sudo pacman -S gnome-tweaks
  ```


## Reverting

To remove the theme and revert to the system default:

```
rm -rf ~/.local/share/icons/Argonaut

# Reset icon theme to the system default
gsettings reset org.gnome.desktop.interface icon-theme
```


## Compatibility notes

- **KDE Plasma**: Copy the theme to `~/.local/share/icons/` and select it in System Settings > Appearance > Icons.
- **XFCE**: Copy the theme to `~/.local/share/icons/` and select it in XFCE Settings > Appearance > Icons.
- **Cinnamon**: Copy the theme to `~/.local/share/icons/` and select it in Cinnamon System Settings > Themes > Icons.
- **HiDPI displays**: The `@2x` directories are picked up automatically by GTK on HiDPI sessions. No extra configuration is required.
