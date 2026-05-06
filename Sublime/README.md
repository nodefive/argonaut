# Argonaut Sublime Text Theme

A dark Sublime Text color scheme and UI theme built around a deep blue-black palette. The color scheme defines syntax highlighting colors for code, and the UI theme styles the editor chrome: sidebar, tabs, status bar, panels, and input fields.


## What this package includes

| File                            | Purpose                                                  |
|---------------------------------|----------------------------------------------------------|
| `Argonaut.sublime-color-scheme` | Syntax highlighting colors for all supported languages   |
| `Argonaut.sublime-theme`        | UI theme controlling sidebar, tabs, panels, and overlays |

The two files work independently: you can use the color scheme with a different UI theme, or the UI theme with a different color scheme, but they are designed together and share the same palette.

### Color palette overview

- Editor background: `#0e1019` (near black, dark blue tint)
- Sidebar and panel backgrounds: `#0e1019` to `#1a1e33` gradient of dark blues
- Accent color: `#027ad7` (bright blue)
- Syntax colors: green `#8ce10b`, orange `#ffb900`, cyan `#00d8eb`, purple `#9a5feb`, red `#ff000f`


## Dependencies

- **Sublime Text 3** (build 3143 or newer) or **Sublime Text 4**

No package manager or third-party extensions are required. The `.sublime-color-scheme` and `.sublime-theme` formats are built into Sublime Text.


## Finding the Packages/User directory

Sublime Text stores user configuration in a `Packages/User/` directory whose exact path depends on the version and operating system:

| Version         | Path                                              |
|-----------------|---------------------------------------------------|
| Sublime Text 4  | `~/.config/sublime-text/Packages/User/`           |
| Sublime Text 3  | `~/.config/sublime-text-3/Packages/User/`         |

You can always confirm the correct path from inside Sublime Text by going to **Preferences > Browse Packages...**. This opens the `Packages/` directory in your file manager; the `User/` subdirectory is inside it.

From the terminal:

```
# Sublime Text 4
ls ~/.config/sublime-text/Packages/User/

# Sublime Text 3
ls ~/.config/sublime-text-3/Packages/User/
```


## Manual installation

1. Locate your `Packages/User/` directory (see above).

2. Copy both theme files into it:

   ```
   # Sublime Text 4
   cp User/Argonaut.sublime-color-scheme ~/.config/sublime-text/Packages/User/
   cp User/Argonaut.sublime-theme        ~/.config/sublime-text/Packages/User/

   # Sublime Text 3
   cp User/Argonaut.sublime-color-scheme ~/.config/sublime-text-3/Packages/User/
   cp User/Argonaut.sublime-theme        ~/.config/sublime-text-3/Packages/User/
   ```

3. Activate the color scheme: open **Preferences > Color Scheme...** and select **Argonaut**.

4. Activate the UI theme: open **Preferences > Theme...** and select **Argonaut**.

   Alternatively, add both lines directly to your `Preferences.sublime-settings` file (open it via **Preferences > Settings**):

   ```json
   {
       "color_scheme": "Argonaut.sublime-color-scheme",
       "theme": "Argonaut.sublime-theme"
   }
   ```

   Sublime Text applies changes to `Preferences.sublime-settings` immediately without requiring a restart.


## Automated installation

Run the provided script from the `Sublime/` directory:

```
bash install.sh
```

The script will:

1. Detect whether Sublime Text 4 or Sublime Text 3 is installed by checking the standard configuration directories.
2. Copy `Argonaut.sublime-color-scheme` and `Argonaut.sublime-theme` into the correct `Packages/User/` directory.
3. Patch `Preferences.sublime-settings` to set `color_scheme` and `theme` to the Argonaut values, preserving any existing settings.
4. Print a confirmation with the target path.

Sublime Text picks up changes to the `Packages/User/` directory in real time; no restart is needed.


## Reverting

To remove the theme, delete the two files from `Packages/User/`:

```
# Sublime Text 4
rm ~/.config/sublime-text/Packages/User/Argonaut.sublime-color-scheme
rm ~/.config/sublime-text/Packages/User/Argonaut.sublime-theme
```

Then open **Preferences > Color Scheme** and **Preferences > Theme** to select a replacement, or remove the `color_scheme` and `theme` keys from `Preferences.sublime-settings`.
