#!/bin/bash

# Function to create/replace symlinks
update_files() {
  local theme_dir=$1
  for file in $(find "$theme_dir" -type f -printf '%P\n'); do
    ln -sf "$theme_dir/$file" "$HOME/.config/$file"

    if [[ $? -eq 0 && "$quiet" != 1 ]]; then
      echo "Created symlink: $theme_dir/$file -> $HOME/.config/$file"
    fi
  done
}

# Function to execute global commands
execute_global_commands() {
  local wallpaper="$1"
  local theme_name="$2"

  # Iterate over each global command
  while IFS= read -r command; do
    # Skip empty lines
    [[ -z "$command" ]] && continue

    # Replace placeholders and execute
    local expanded_command=$(echo "$command" | sed \
      -e "s|\$wallpaper|$wallpaper|g" \
      -e "s|\$theme_name|$theme_name|g")

    if [[ "$quiet" != 1 ]]; then
      echo "Executing: $expanded_command"
    fi

    eval "$expanded_command"
  done <<<"$GLOBAL_COMMANDS"
}

# Function to backup existing files
backup_files() {
  local theme_dir=$1
  local backup_dir="$HOME/.cache/theme-switcher/$(date '+%Y-%m-%d_%H:%M:%S')"

  mkdir -p "$backup_dir"
  echo "Backing up existing files to: $backup_dir"

  for file in $(find "$theme_dir" -type f -printf '%P\n'); do
    local target_file="$HOME/.config/$file"
    if [[ -f "$target_file" ]]; then
      mkdir -p "$(dirname "$backup_dir/$file")"
      cp "$target_file" "$backup_dir/$file"
      if [[ "$quiet" != 1 ]]; then
        echo "Backed up: $target_file -> $backup_dir/$file"
      fi
    fi
  done
}

# Function to switch themes
switch_theme() {
  local theme_name=$1
  local theme_wallpaper=""
  local theme_config_dir=""

  # Automatically detect theme directories
  local theme_dir="$HOME/.config/theme-switcher/themes/$theme_name"

  if [[ ! -d "$theme_dir" ]]; then
    echo "Theme '$theme_name' not found in ~/.config/theme-switcher/themes."
    exit 1
  fi

  # Look for the wallpaper and config details in the theme directory
  theme_wallpaper="$theme_dir/wallpaper.png"
  theme_config_dir="$theme_dir"

  if [[ "$backup" == 1 ]]; then
    backup_files "$theme_config_dir"
    if [[ "$quiet" != 1 ]]; then
      echo ""
    fi
    echo "=> Backup completed"
  fi

  # List files that will be overwritten:
  echo "The following files will be modified:"
  for file in $(find "$theme_dir" -type f -printf '%P\n'); do
    echo "$HOME/.config/$file"
  done

  # Ask for user confirmation
  read -p "Do you want to continue? (y/n) " confirm
  if [[ "$confirm" != "y" ]]; then
    echo "Aborted."
    exit 0
  fi

  update_files "$theme_config_dir"
  if [[ "$quiet" != 1 ]]; then
    echo ""
  fi
  echo "=> Updated config files"

  execute_global_commands "$theme_wallpaper" "$theme_name"
  if [[ "$quiet" != 1 ]]; then
    echo ""
  fi
  echo "=> Executed global commands."
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
  echo "Creating themes directory..."
  THEMES_DIR="$HOME/.config/theme-switcher/themes"
  mkdir -p "$THEMES_DIR"
fi

# List themes if requested
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
