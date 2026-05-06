#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILES_INI="$HOME/.mozilla/firefox/profiles.ini"

# ---------------------------------------------------------------------------
# Find the default Firefox profile path
# ---------------------------------------------------------------------------

find_default_profile() {
    if [[ ! -f "$PROFILES_INI" ]]; then
        echo "ERROR: Firefox profiles.ini not found at $PROFILES_INI" >&2
        echo "Make sure Firefox has been launched at least once." >&2
        exit 1
    fi

    local path=""
    local is_default=0
    local is_relative=1
    local found_path=""

    while IFS='=' read -r key value; do
        key="${key// /}"
        value="${value// /}"

        case "$key" in
            \[Profile*)
                # New section: reset state from previous profile block
                if [[ "$is_default" -eq 1 && -n "$path" ]]; then
                    found_path="$path"
                    break
                fi
                path=""
                is_default=0
                is_relative=1
                ;;
            Default)
                [[ "$value" == "1" ]] && is_default=1
                ;;
            IsRelative)
                is_relative="$value"
                ;;
            Path)
                path="$value"
                ;;
        esac
    done < "$PROFILES_INI"

    # Handle last block in file
    if [[ "$is_default" -eq 1 && -n "$path" && -z "$found_path" ]]; then
        found_path="$path"
    fi

    if [[ -z "$found_path" ]]; then
        echo "ERROR: Could not determine the default Firefox profile from $PROFILES_INI" >&2
        echo "Open 'about:profiles' in Firefox to find the active profile path manually." >&2
        exit 1
    fi

    if [[ "$is_relative" -eq 1 ]]; then
        echo "$HOME/.mozilla/firefox/$found_path"
    else
        echo "$found_path"
    fi
}

PROFILE_DIR="$(find_default_profile)"

if [[ ! -d "$PROFILE_DIR" ]]; then
    echo "ERROR: Profile directory not found: $PROFILE_DIR" >&2
    exit 1
fi

echo "Using Firefox profile: $PROFILE_DIR"

# ---------------------------------------------------------------------------
# Copy userChrome.css
# ---------------------------------------------------------------------------

CHROME_DIR="$PROFILE_DIR/chrome"
mkdir -p "$CHROME_DIR"

SOURCE_CSS="$SCRIPT_DIR/chrome/userChrome.css"
if [[ ! -f "$SOURCE_CSS" ]]; then
    echo "ERROR: Source file not found: $SOURCE_CSS" >&2
    exit 1
fi

cp "$SOURCE_CSS" "$CHROME_DIR/userChrome.css"
echo "Copied userChrome.css to $CHROME_DIR/"

# ---------------------------------------------------------------------------
# Enable toolkit.legacyUserProfileCustomizations.stylesheets via user.js
# ---------------------------------------------------------------------------

USER_JS="$PROFILE_DIR/user.js"
PREF_LINE='user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);'

if [[ -f "$USER_JS" ]] && grep -qF 'toolkit.legacyUserProfileCustomizations.stylesheets' "$USER_JS"; then
    # Update existing line in place
    sed -i 's|.*toolkit\.legacyUserProfileCustomizations\.stylesheets.*|'"$PREF_LINE"'|' "$USER_JS"
    echo "Updated existing preference in $USER_JS"
else
    echo "$PREF_LINE" >> "$USER_JS"
    echo "Added preference to $USER_JS"
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo ""
echo "Installation complete."
echo ""
echo "Next step: restart Firefox. The Argonaut theme will be active on launch."
echo ""
echo "If the theme does not appear, open about:config in Firefox and verify that"
echo "toolkit.legacyUserProfileCustomizations.stylesheets is set to true."
