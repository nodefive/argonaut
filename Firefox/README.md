# Argonaut Firefox Theme

A dark, terminal-inspired Firefox chrome override that replaces the default browser UI colors with a unified near-black palette. The toolbar, tabs, URL bar, bookmarks bar, and context menus all adopt the same deep background as a dark terminal emulator, eliminating visual contrast breaks between your browser and the rest of the desktop.

## What this theme changes

- Toolbar and navigation bar background: `#0f1419`
- Selected tab and URL bar background: `#1a1f25`
- Context menu background: `#151829` with rounded corners and no visible borders
- All focus rings and box shadows removed for a completely flat look
- White text throughout for readability


## Dependencies

- Firefox 70 or newer (the `userChrome.css` mechanism has been present since Firefox 69, but requires explicit opt-in)
- No extensions required


## How userChrome.css works

Firefox loads a file called `userChrome.css` from a `chrome/` subdirectory inside your active profile folder. This file is not loaded by default: you must enable the preference `toolkit.legacyUserProfileCustomizations.stylesheets` in `about:config` for Firefox to read it. Once enabled, the styles apply globally to the browser chrome (not to web page content).


## Finding your Firefox profile directory

Firefox stores profiles under `~/.mozilla/firefox/`. Each profile is a directory named with a random string followed by a descriptive suffix, for example `a1b2c3d4.default-release`. The active profile is identified in `~/.mozilla/firefox/profiles.ini` under the `Path=` key of the section marked `Default=1`.

To find it manually:

```
ls ~/.mozilla/firefox/
```

Look for a directory ending in `.default-release` or `.default`. If there are multiple profiles, open `about:profiles` inside Firefox to see which one is currently active and where it is located on disk.


## Manual installation

1. Close Firefox completely before making any changes to the profile directory.

2. Locate your active Firefox profile directory (see above).

3. Inside the profile directory, create the `chrome` folder if it does not already exist:

   ```
   mkdir -p ~/.mozilla/firefox/YOUR_PROFILE/chrome
   ```

4. Copy `userChrome.css` into that folder:

   ```
   cp chrome/userChrome.css ~/.mozilla/firefox/YOUR_PROFILE/chrome/
   ```

5. Open Firefox and navigate to `about:config`. Accept the risk warning.

6. Search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set it to `true`.

7. Restart Firefox. The theme will be active.


## Automated installation

Run the provided script from the `Firefox/` directory:

```
bash install.sh
```

The script will:

1. Parse `~/.mozilla/firefox/profiles.ini` to find your default profile path automatically.
2. Create the `chrome/` directory inside that profile if it does not exist.
3. Copy `userChrome.css` into place.
4. Attempt to set `toolkit.legacyUserProfileCustomizations.stylesheets=true` in `user.js` inside the profile (Firefox reads `user.js` on startup and applies any preferences defined there).
5. Print a reminder to restart Firefox.

If Firefox is running when you execute the script, you must close and reopen it for the changes to take effect.


## Reverting

To remove the theme, delete `~/.mozilla/firefox/YOUR_PROFILE/chrome/userChrome.css`. If you want to fully restore default behavior, also delete or empty the preference line from `user.js`, or toggle `toolkit.legacyUserProfileCustomizations.stylesheets` back to `false` in `about:config`.


## License

MIT License — Copyright (c) 2025 nodefive

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
