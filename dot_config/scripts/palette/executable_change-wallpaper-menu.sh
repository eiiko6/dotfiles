#!/bin/bash

# Directory containing cached wallpaper icons
CACHE_DIR="$HOME/.cache/palette/wallpapers/"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Default menu command (wofi)
MENU_CMD=(wofi --dmenu -H 700 --prompt "Select Wallpaper")

# Check if '--fuzzel' flag is passed
USE_FUZZEL=false
if [[ "$1" == "--fuzzel" ]]; then
    USE_FUZZEL=true
    MENU_CMD=(fuzzel --dmenu --prompt "Select Wallpaper: ")
fi
if [[ "$1" == "--noctalia" ]]; then
    noctalia msg panel-toggle wallpaper
    exit
fi
if [[ "$1" == "--noctalia-wallhaven" ]]; then
    noctalia msg panel-toggle noctalia/wallhaven:browser
    exit
fi

if $USE_FUZZEL; then
    # Fuzzel: show just relative paths (no images)
    SELECTED_REL=$(find "$CACHE_DIR" -type f -printf "%P\n" | "${MENU_CMD[@]}")
else
    # Wofi: show image previews
    SELECTED_ENTRY=$(find "$CACHE_DIR" -type f | while read -r file; do
            REL_PATH="${file#"$CACHE_DIR"}"
            echo "img:$file:text:$REL_PATH"
    done | "${MENU_CMD[@]}")
    SELECTED_REL=$(echo "$SELECTED_ENTRY" | awk -F 'text:' '{print $2}')
fi

if [ -n "$SELECTED_REL" ]; then
    WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTED_REL"
    ~/.config/scripts/palette/change-wallpaper.sh -p "$WALLPAPER_PATH"
    # noctalia msg wallpaper-set "$WALLPAPER_PATH"
fi
