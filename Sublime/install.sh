#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COLOR_SCHEME="Argonaut.sublime-color-scheme"
THEME="Argonaut.sublime-theme"
PREFS_FILE="Preferences.sublime-settings"

# ---------------------------------------------------------------------------
# Locate the Packages/User directory
# Sublime Text 4 uses ~/.config/sublime-text/
# Sublime Text 3 uses ~/.config/sublime-text-3/
# ---------------------------------------------------------------------------

find_packages_user() {
    local st4="$HOME/.config/sublime-text/Packages/User"
    local st3="$HOME/.config/sublime-text-3/Packages/User"

    if [[ -d "$st4" ]]; then
        echo "$st4"
    elif [[ -d "$st3" ]]; then
        echo "$st3"
    else
        # Neither directory exists yet; try to create for ST4 (the current version)
        # but only if the parent config dir exists (indicating ST has been run before)
        if [[ -d "$HOME/.config/sublime-text" ]]; then
            mkdir -p "$st4"
            echo "$st4"
        elif [[ -d "$HOME/.config/sublime-text-3" ]]; then
            mkdir -p "$st3"
            echo "$st3"
        else
            echo ""
        fi
    fi
}

PACKAGES_USER="$(find_packages_user)"

if [[ -z "$PACKAGES_USER" ]]; then
    echo "ERROR: Could not locate the Sublime Text Packages/User directory." >&2
    echo "" >&2
    echo "Make sure Sublime Text has been launched at least once so its" >&2
    echo "configuration directory is created." >&2
    echo "" >&2
    echo "Expected locations:" >&2
    echo "  Sublime Text 4: $HOME/.config/sublime-text/Packages/User/" >&2
    echo "  Sublime Text 3: $HOME/.config/sublime-text-3/Packages/User/" >&2
    exit 1
fi

echo "Target directory: $PACKAGES_USER"

# ---------------------------------------------------------------------------
# Copy theme files
# ---------------------------------------------------------------------------

SOURCE_DIR="$SCRIPT_DIR/User"

for f in "$COLOR_SCHEME" "$THEME"; do
    if [[ ! -f "$SOURCE_DIR/$f" ]]; then
        echo "ERROR: Source file not found: $SOURCE_DIR/$f" >&2
        exit 1
    fi
    cp "$SOURCE_DIR/$f" "$PACKAGES_USER/$f"
    echo "Copied $f"
done

# ---------------------------------------------------------------------------
# Patch Preferences.sublime-settings to activate theme and color scheme
# ---------------------------------------------------------------------------

PREFS_PATH="$PACKAGES_USER/$PREFS_FILE"

if [[ ! -f "$PREFS_PATH" ]]; then
    # Create a minimal preferences file if none exists
    printf '{\n\t"color_scheme": "%s",\n\t"theme": "%s"\n}\n' \
        "$COLOR_SCHEME" "$THEME" > "$PREFS_PATH"
    echo "Created $PREFS_FILE with Argonaut settings"
else
    # Use Python to parse and update the JSON safely, preserving existing keys.
    # Sublime Text's preferences file is standard JSON (comments are stripped by ST,
    # but user-written ones may appear — we handle that conservatively).
    python3 - "$PREFS_PATH" "$COLOR_SCHEME" "$THEME" <<'PYEOF'
import sys, json, re

path      = sys.argv[1]
scheme    = sys.argv[2]
theme     = sys.argv[3]

with open(path, "r") as fh:
    raw = fh.read()

# Strip single-line comments so json.loads succeeds on ST-style prefs files
raw_stripped = re.sub(r'//[^\n]*', '', raw)

try:
    prefs = json.loads(raw_stripped)
except json.JSONDecodeError:
    # File is malformed; overwrite with minimal valid content
    prefs = {}

prefs["color_scheme"] = scheme
prefs["theme"]        = theme

with open(path, "w") as fh:
    json.dump(prefs, fh, indent="\t")
    fh.write("\n")

print("Updated " + path)
PYEOF
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo ""
echo "Installation complete."
echo ""
echo "Sublime Text applies theme changes immediately if it is running."
echo ""
echo "To activate manually if needed:"
echo "  Color scheme: Preferences > Color Scheme > Argonaut"
echo "  UI theme:     Preferences > Theme > Argonaut"
