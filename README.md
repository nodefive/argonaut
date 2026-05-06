# Argonaut

A cohesive dark desktop theme suite built around a deep navy/near-black palette. The collection covers every visible layer of a Linux desktop — browser chrome, GTK widgets, window decorations, icons, and code editor — so the visual language stays consistent regardless of what is on screen.

## Themes

### Firefox (`Firefox/`)

A `userChrome.css` override that repaints the Firefox browser chrome to match the Argonaut palette. Toolbar, tab strip, URL bar, bookmarks bar, and context menus all adopt the same deep background (`#0f1419`) as the rest of the desktop, eliminating the contrast break that a default Firefox install creates against a dark GTK theme.

See [Firefox/README.md](Firefox/README.md) for full installation instructions. A one-shot install script is provided at `Firefox/install.sh`.

---

### Gnome GTK Theme (`Gnome/`)

A full GTK theme inspired by the macOS Big Sur aesthetic, adapted to the Argonaut color scheme. Installed as a standard GNOME theme package under `Gnome/Argonaut/`.

**Covered surfaces:**

| Directory | What it styles |
|---|---|
| `gtk-2.0/` | Legacy GTK2 applications |
| `gtk-3.0/` | GTK3 applications (most modern Linux apps) |
| `gtk-4.0/` | GTK4 / libadwaita applications |
| `gnome-shell/` | GNOME Shell UI — top bar, overview, notifications |
| `cinnamon/` | Cinnamon desktop shell (Linux Mint) |
| `metacity-1/` | Metacity / Mutter window decorations |
| `xfwm4/` | XFCE window manager decorations |
| `unity/` | Unity desktop shell elements |
| `plank/` | Plank dock theme |

**Installation:**

```bash
cp -r Gnome/Argonaut ~/.themes/Argonaut
```

Then apply via GNOME Tweaks → Appearance → Shell / Legacy Applications → Argonaut, or:

```bash
gsettings set org.gnome.desktop.interface gtk-theme 'Argonaut'
gsettings set org.gnome.desktop.wm.preferences theme 'Argonaut'
```

---

### Icon Theme (`Icons/`)

A complete icon theme covering actions, apps, devices, emblems, file types, panel icons, and places. Inherits missing icons from Breeze and then hicolor as fallbacks.

**Size coverage:** 8×8 through 128×128, with HiDPI (`@2x`) variants for 16×16 through 64×64.

**Installation:**

```bash
cp -r Icons/Argonaut ~/.local/share/icons/Argonaut
```

Apply via GNOME Tweaks → Appearance → Icons → Argonaut, or:

```bash
gsettings set org.gnome.desktop.interface icon-theme 'Argonaut'
```

---

### Sublime Text (`Sublime/`)

A color scheme and UI theme for Sublime Text 3 / 4.

- `Argonaut.sublime-color-scheme` — syntax highlighting. Deep navy background (`hsl(230, 15%, 4%)`), with warm orange for constants and cursors, muted green for strings, soft pink for tags, and blue-toned punctuation.
- `Argonaut.sublime-theme` — UI chrome (sidebar, tabs, status bar).

**Installation:**

Copy both files into your Sublime Text `User` packages directory:

```bash
cp Sublime/User/Argonaut.sublime-color-scheme Sublime/User/Argonaut.sublime-theme \
   ~/.config/sublime-text/Packages/User/
```

Then set in your Sublime preferences (`Preferences → Settings`):

```json
{
    "color_scheme": "Argonaut.sublime-color-scheme",
    "theme": "Argonaut.sublime-theme"
}
```

---

## Palette

The unifying colors across all themes:

| Role | Value |
|---|---|
| Background (deep) | `#0d0f14` / `hsl(230, 15%, 4%)` |
| Background (elevated) | `#0f1419` |
| Background (selected) | `#1a1f25` |
| Foreground | `hsl(219, 28%, 88%)` |
| Accent / cursor | `hsl(32, 93%, 66%)` (orange) |
| Strings | `hsl(114, 31%, 68%)` (green) |
| Keywords | `hsl(210, 50%, 60%)` (blue) |
| Tags | `hsl(300, 30%, 68%)` (pink) |
| Errors | `hsl(357, 79%, 65%)` (red) |

## License

MIT License — Copyright (c) 2025 nodefive

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
