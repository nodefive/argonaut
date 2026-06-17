# Argonaut Ptyxis Palette

A terminal color palette for Ptyxis, the GNOME terminal emulator, built around the Argonaut deep blue-black color scheme. The palette defines the 16 ANSI colors, foreground, background, cursor, and superuser indicator colors used by every shell session inside Ptyxis.


## What this package includes

| File                        | Purpose                                          |
|-----------------------------|--------------------------------------------------|
| `argonaut-custom.palette`   | Ptyxis custom palette with the full Argonaut color set |

### Color palette overview

- Terminal background: `#0E1019` (near black, dark blue tint)
- Foreground / cursor: `#FFFAF4` (warm white)
- Normal colors: black `#232323`, red `#FF000F`, green `#8CE10B`, yellow `#FFB900`, blue `#008DF8`, magenta `#6D43A6`, cyan `#00D8EB`, white `#FFFFFF`
- Bright colors: black `#444444`, red `#FF2740`, green `#ABE15B`, yellow `#FFD242`, blue `#0092FF`, magenta `#9A5FEB`, cyan `#67FFF0`, white `#FFFFFF`
- Superuser background: `#040408` (deeper black to visually flag root sessions)


## Dependencies

- **Ptyxis** — the GNOME 46+ default terminal emulator, shipped by default on Fedora Workstation 40+ and other GNOME 46 distributions.

  ```
  # Fedora
  sudo dnf install ptyxis

  # Arch Linux
  sudo pacman -S ptyxis
  ```

  On distributions still shipping GNOME Terminal you can install Ptyxis from Flathub:

  ```
  flatpak install flathub app.devsuite.Ptyxis
  ```


## Installation location

Ptyxis reads custom palettes from:

```
~/.local/share/ptyxis/palettes/
```

Placing a `.palette` file in that directory makes it immediately available in Ptyxis preferences without requiring a restart.


## Manual installation

1. Create the palettes directory if it does not exist:

   ```
   mkdir -p ~/.local/share/ptyxis/palettes
   ```

2. Copy the palette file:

   ```
   cp argonaut-custom.palette ~/.local/share/ptyxis/palettes/
   ```

3. Open Ptyxis and go to **Preferences > Profiles > (your profile) > Color Palette**.

4. Select **Argonaut (custom)** from the palette list.


## Automated installation

Run the provided script from the `Ptyxis/` directory:

```
bash install.sh
```

The script will:

1. Create `~/.local/share/ptyxis/palettes/` if it does not exist.
2. Copy `argonaut-custom.palette` into that directory.
3. Print instructions for activating the palette inside Ptyxis preferences.


## Reverting

To remove the palette:

```
rm ~/.local/share/ptyxis/palettes/argonaut-custom.palette
```

Then open **Preferences > Profiles > (your profile) > Color Palette** and select a replacement palette.


## Compatibility notes

- **Ptyxis profile palettes**: palette selection is per-profile. If you have multiple Ptyxis profiles, apply the Argonaut palette to each one individually in preferences.
- **GNOME Terminal**: Ptyxis `.palette` files are not compatible with GNOME Terminal's dconf-based color settings. Use the hex color values listed above to configure GNOME Terminal manually if needed.
