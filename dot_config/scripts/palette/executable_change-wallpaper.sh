#!/bin/bash

# Function to generate a colorscheme from an image
palette() {
  # Check if no arguments were provided
  if [[ $# -eq 0 ]]; then
    echo "Usage: palette [-p <full-path-to-image>] [image-name]"
    echo "  -p: Specify the full path to the image"
    echo "  image-name: Specify just the image name (without .png) if the image is in \$HOME/Pictures/Wallpapers/"
    return 1
  fi

  # Initialize variable to hold the path
  wallpaper_path=""

  # Check if the first argument is -p (full path option)
  if [[ $1 == "-p" ]]; then
    if [[ $# -lt 2 ]]; then
      echo "Error: Missing path after -p option."
      return 1
    fi
    wallpaper_path="$2"
  else
    # Otherwise, treat it as a file name in the default directory
    wallpaper_path="$HOME/Pictures/Wallpapers/$1.png"
  fi

  # Check if the file exists at the determined path
  if [[ ! -e "$wallpaper_path" ]]; then
    echo "Error: File not found: $wallpaper_path"
    return 1
  fi

  # Generate the colors using wal
  wal -i "$wallpaper_path" -n -q -t --saturate 0.6

  # Set the wallpaper using swww
  swww img "$wallpaper_path" -t none

  # Change the preview
  wallpaper=$(echo "$wallpaper_path" | sed -E 's|.*/Wallpapers/||; s|\.[^.]+$||')
  echo $wallpaper
  ln -sf "$HOME/.cache/palette/wallpapers/$wallpaper.png" ~/.cache/palette/current-preview.png

  # Restart waybar without any output
  pkill waybar && nohup waybar &>/dev/null &

  echo "Colorscheme and background changed!"
}

# Run the function if the script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  palette "$@"
fi
