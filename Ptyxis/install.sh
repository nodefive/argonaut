#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PALETTE_FILE="argonaut-custom.palette"
PALETTE_SOURCE="$SCRIPT_DIR/$PALETTE_FILE"

# ---------------------------------------------------------------------------
# Validate source
# ---------------------------------------------------------------------------

if [[ ! -f "$PALETTE_SOURCE" ]]; then
    echo "ERROR: Palette file not found: $PALETTE_SOURCE" >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# Install palette
# ---------------------------------------------------------------------------

PALETTES_DIR="$HOME/.local/share/ptyxis/palettes"
mkdir -p "$PALETTES_DIR"

echo "Installing palette to $PALETTES_DIR/$PALETTE_FILE ..."
cp "$PALETTE_SOURCE" "$PALETTES_DIR/$PALETTE_FILE"
echo "Palette installed."

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo ""
echo "Installation complete."
echo ""
echo "To activate the palette in Ptyxis:"
echo "  1. Open Ptyxis and go to Preferences > Profiles > (your profile) > Color Palette"
echo "  2. Select 'Argonaut (custom)' from the palette list"
echo ""
echo "The palette is available immediately — no restart required."
echo ""
echo "To remove the palette:"
echo "  rm $PALETTES_DIR/$PALETTE_FILE"
