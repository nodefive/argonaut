#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Firefox 147+ uses the XDG location; older versions use ~/.mozilla.
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/mozilla/firefox/profiles.ini" ]]; then
    FIREFOX_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mozilla/firefox"
else
    FIREFOX_DIR="$HOME/.mozilla/firefox"
fi
PROFILES_INI="$FIREFOX_DIR/profiles.ini"

# ---------------------------------------------------------------------------
# Find the default Firefox profile path
#
# Preference order:
#   1. Default= in an [Install*] section (the profile this install uses)
#   2. The [Profile*] section marked Default=1
# ---------------------------------------------------------------------------

resolve_path() {
    local path="$1" is_relative="$2"
    if [[ "$is_relative" == "1" ]]; then
        echo "$FIREFOX_DIR/$path"
    else
        echo "$path"
    fi
}

find_default_profile() {
    if [[ ! -f "$PROFILES_INI" ]]; then
        echo "ERROR: Firefox profiles.ini not found at $PROFILES_INI" >&2
        echo "Make sure Firefox has been launched at least once." >&2
        exit 1
    fi

    local section="" key value
    local install_default=""
    local path="" is_default=0 is_relative=1
    local default_path="" default_relative=1
    declare -A relative_of=()

    flush_profile() {
        if [[ -n "$path" ]]; then
            relative_of["$path"]="$is_relative"
            if [[ "$is_default" -eq 1 && -z "$default_path" ]]; then
                default_path="$path"
                default_relative="$is_relative"
            fi
        fi
        path=""; is_default=0; is_relative=1
    }

    while IFS= read -r line || [[ -n "$line" ]]; do
        line="${line%$'\r'}"
        if [[ "$line" =~ ^\[(.*)\]$ ]]; then
            [[ "$section" == Profile* ]] && flush_profile
            section="${BASH_REMATCH[1]}"
            continue
        fi
        [[ "$line" == *=* ]] || continue
        key="${line%%=*}"
        value="${line#*=}"
        case "$section" in
            Install*)
                [[ "$key" == "Default" && -z "$install_default" ]] && install_default="$value"
                ;;
            Profile*)
                case "$key" in
                    Default)    [[ "$value" == "1" ]] && is_default=1 ;;
                    IsRelative) is_relative="$value" ;;
                    Path)       path="$value" ;;
                esac
                ;;
        esac
    done < "$PROFILES_INI"
    [[ "$section" == Profile* ]] && flush_profile

    if [[ -n "$install_default" ]]; then
        if [[ "$install_default" == /* ]]; then
            echo "$install_default"
        else
            resolve_path "$install_default" "${relative_of[$install_default]:-1}"
        fi
        return
    fi

    if [[ -n "$default_path" ]]; then
        resolve_path "$default_path" "$default_relative"
        return
    fi

    echo "ERROR: Could not determine the default Firefox profile from $PROFILES_INI" >&2
    echo "Open 'about:profiles' in Firefox to find the active profile path manually." >&2
    exit 1
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
