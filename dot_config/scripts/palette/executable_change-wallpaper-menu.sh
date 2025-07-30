#!/bin/bash

# Directory containing cached wallpaper icons
CACHE_DIR="$HOME/.cache/palette/wallpapers/"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Generate the Wofi menu with images
SELECTED_ENTRY=$(find "$CACHE_DIR" -type f | while read -r file; do
  # Get relative path from CACHE_DIR
  REL_PATH="${file#"$CACHE_DIR"}"
  echo "img:$file:text:$REL_PATH"
done | wofi --dmenu -H 700 --prompt "Select Wallpaper")

if [ -n "$SELECTED_ENTRY" ]; then
  # Extract only the filename with subdirectory path
  REL_PATH=$(echo "$SELECTED_ENTRY" | awk -F 'text:' '{print $2}')

  # Construct the actual wallpaper path
  WALLPAPER_PATH="$WALLPAPER_DIR/$REL_PATH"

  # notify-send "Wallpaper Selected" "$WALLPAPER_PATH"
  ~/.config/scripts/palette/change-wallpaper.sh -p "$WALLPAPER_PATH"
fi
