#!/bin/bash

# Detect if the system is a laptop or desktop
detect_host_type() {
  if [[ -e /sys/class/power_supply/BAT0 ]]; then
    echo "laptop"
  else
    echo "desktop"
  fi
  exit
}

# Function to create/replace symlinks
update_files() {
  local theme_dir=$1
  local target_dir=$2
  local ignored_files=("wallpaper.png" "script.sh")

  # Handle shared/common files
  find "$theme_dir/common" -type f -printf '%P\n' | while IFS= read -r file; do
    # Check if the file is in the ignored list
    for ignored in "${ignored_files[@]}"; do
      if [[ "$file" == "$ignored" ]]; then
        continue 2
      fi
    done

    ln -sf "$theme_dir/common/$file" "$HOME/.config/$file"

    if [[ $? -eq 0 && "$quiet" != 1 ]]; then
      echo "Created symlink: $theme_dir/common/$file -> $HOME/.config/$file"
    fi
  done

  # Handle desktop or laptop overrides
  find "$theme_dir/$target_dir" -type f -printf '%P\n' | while IFS= read -r file; do
    # Check if the file is in the ignored list
    for ignored in "${ignored_files[@]}"; do
      if [[ "$file" == "$ignored" ]]; then
        continue 2
      fi
    done

    ln -sf "$theme_dir/$target_dir/$file" "$HOME/.config/$file"

    if [[ $? -eq 0 && "$quiet" != 1 ]]; then
      echo "Created symlink: $theme_dir/$target_dir/$file -> $HOME/.config/$file"
    fi
  done
}

# Function to execute global script
execute_global_script() {
  local wallpaper="$1"
  local theme_name="$2"
  local theme_dir="$3"

  # Check if global script exists and execute it
  if [[ -f "$HOME/.config/theme-switcher/script.sh" ]]; then
    source "$HOME/.config/theme-switcher/script.sh"
  fi
}

# Function to execute the theme's script
execute_theme_script() {
  local wallpaper="$1"
  local theme_name="$2"
  local theme_dir="$3"

  # Check if theme-specific script exists and execute it
  if [[ -f "$theme_dir/script.sh" ]]; then
    source "$theme_dir/script.sh"
  fi
}

# Function to backup existing files
backup_files() {
  local theme_dir=$1
  local backup_dir="$HOME/.cache/theme-switcher/$(date '+%Y-%m-%d_%H:%M:%S')"

  mkdir -p "$backup_dir"
  echo "Backing up existing files to: $backup_dir"

  for target in common desktop laptop; do
    for file in $(find "$theme_dir/$target" -type f -printf '%P\n'); do
      local target_file="$HOME/.config/$file"
      if [[ -f "$target_file" ]]; then
        mkdir -p "$(dirname "$backup_dir/$file")"
        cp "$target_file" "$backup_dir/$file"
        if [[ "$quiet" != 1 ]]; then
          echo "Backed up: $target_file -> $backup_dir/$file"
        fi
      fi
    done
  done
}

# Function to switch themes
switch_theme() {
  local theme_name=$1
  local theme_target=""
  local theme_dir="$THEMES_DIR/$theme_name"

  if [[ ! -d "$theme_dir" ]]; then
    echo "Theme '$theme_name' not found in $THEMES_DIR."
    exit 1
  fi

  theme_target=$(detect_host_type)

  # Backup and update files
  if [[ "$backup" == 1 ]]; then
    echo "=================< -> $theme_dir"
    backup_files "$theme_dir"
    if [[ "$quiet" != 1 ]]; then
      echo ""
    fi
    echo "=> Backup completed"
  fi

  # List files that will be overwritten:
  echo "The following files will be modified:"
  for target in common desktop laptop; do
    for file in $(find "$theme_dir/$target" -type f -printf '%P\n' 2>/dev/null); do
      echo "$HOME/.config/$file"
    done
  done

  # Ask for user confirmation
  read -r -p "Do you want to continue? (y/n) " confirm
  if [[ "$confirm" != "y" ]]; then
    echo "Aborted."
    exit 0
  fi
  echo ""

  echo "=> Updating config files"
  update_files "$theme_dir" "$theme_target"
  echo ""

  # Execute global and theme-specific scripts
  echo "=> Executing global script"
  execute_global_script "$theme_dir/wallpaper.png" "$theme_name" "$theme_dir"
  echo ""

  echo "=> Executing theme script"
  execute_theme_script "$theme_dir/wallpaper.png" "$theme_name" "$theme_dir"
  echo ""

  echo "=> Theme switch complete."
}

# Create default config directory if not present
if [[ ! -d "$HOME/.config/theme-switcher" ]]; then
  echo "Creating theme-switcher config files..."
  mkdir -p "$HOME/.config/theme-switcher"
  cp -r ./config/theme-switcher/* "$HOME/.config/theme-switcher/"
fi

# Load themes.conf
source "$HOME/.config/theme-switcher/themes.conf"

# Create themes directory if it doesn't exist
if [[ ! -d "$THEMES_DIR" ]]; then
  echo "Specified themes directory does not exist. Creating it..."
  THEMES_DIR="$HOME/.config/theme-switcher/themes"
  mkdir -p "$THEMES_DIR"
fi

# Usage
if [[ $# -eq 0 ]]; then
  echo "Usage: $0 [OPTIONS] <theme_name>"
  echo ""
  echo "Options:"
  echo "  -l, --list       (alone) List all available themes in ~/.config/theme-switcher/themes"
  echo "  -q, --quiet      Suppress output for symlink creation and command execution"
  echo "  -q, --backup     Backup existing config files"
  echo "  <theme_name>     Name of the theme to switch to"
  echo ""
  echo "Examples:"
  echo "  $0 -l             # List available themes"
  echo "  $0 -q -b <theme_name> # Backup files, and switch to <theme_name> silently (without output)"
  echo "  $0 <theme_name>    # Switch to <theme_name> and show output"
  exit 1
fi

# Handle parameters
while [[ $# -gt 0 ]]; do
  case $1 in
  -l | --list)
    echo "Themes found in ~/.config/theme-switcher/themes:"
    ls -1 ~/.config/theme-switcher/themes/
    exit 0
    ;;
  -q | --quiet)
    quiet=1
    ;;
  -b | --backup)
    backup=1
    ;;
  *)
    switch_theme "$1"
    ;;
  esac
  shift
done
