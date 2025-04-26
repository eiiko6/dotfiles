#!/bin/bash

# Function to generate a colorscheme from an image
palette() {
  # Check if no arguments were provided
  if [[ $# -eq 0 ]]; then
    echo "Usage: palette [-v] [-t] [image-name | -p <full-path-to-image>]"
    echo "  -v: Verbose mode"
    echo "  -t: Reload kitty colors with wal colors"
    echo "  image-name: Specify just the image name (without .png) if the image is in \$HOME/Pictures/Wallpapers/"
    echo "  -p: Specify the full path to the image"
    return 1
  fi

  # Initialize variable to hold the path
  wallpaper_path=""
  verbose=false
  path_mode=false
  reload_terminal_wal=false

  # Parse options
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -v)
      verbose=true
      shift
      ;;
    -p)
      path_mode=true
      shift
      ;;
    -t)
      reload_terminal_wal=true
      shift
      ;;
    *)
      break
      ;;
    esac
  done

  # Determine the wallpaper path
  if $path_mode; then
    if [[ $# -lt 1 ]]; then
      echo "Error: Missing path after -p option."
      return 1
    fi
    wallpaper_path="$(realpath "$1")"
  else
    if [[ $# -lt 1 ]]; then
      echo "Error: Missing image name."
      return 1
    fi
    wallpaper_path="$HOME/Pictures/Wallpapers/$1.png"
  fi

  # Check if the file exists at the determined path
  if [[ ! -e "$wallpaper_path" ]]; then
    echo "Error: File not found: $wallpaper_path"
    return 1
  fi

  # Generate the colors using wal
  if $reload_terminal_wal; then
    wal -i "$wallpaper_path" -s -n -q -t --saturate 0.6
  else
    wal -i "$wallpaper_path" -n -q -t --saturate 0.6
  fi

  # Set the wallpaper using swww
  swww img "$wallpaper_path" -t fade

  # Change the preview
  wallpaper=$(echo "$wallpaper_path" | sed -E 's|.*/Wallpapers/||; s|\.[^.]+$||')
  if [[ "$wallpaper_path" == "$HOME/Pictures/Wallpapers/"* ]]; then
    preview_path="$HOME/.cache/palette/wallpapers/$wallpaper.png"
  else
    mkdir -p "$HOME/.cache/palette/others"

    file_path="$(realpath "$wallpaper_path")"
    if $verbose; then
      echo "file_path: $file_path"
    fi

    hash=$(echo -n "$file_path" | sha256sum | cut -d ' ' -f1)
    if $verbose; then
      echo "hash: $hash"
    fi

    preview_path="$HOME/.cache/palette/others/$hash.png"

    "$HOME"/.config/scripts/palette/generate-wallpaper-previews.sh "$file_path"
  fi
  ln -sf "$preview_path" "$HOME/.cache/palette/current-preview.png"

  # Reload waybar
  pkill -SIGUSR2 waybar &>/dev/null

  # Reload hyprland
  hyprctl reload &>/dev/null

  # Reload mako
  if command -v makoctl &>/dev/null; then
    makoctl reload
  fi

  echo "Colorscheme and background changed!"
}

# Run the function if the script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  palette "$@"
  exit
fi
