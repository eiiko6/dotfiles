#!/usr/bin/bash

echo "$profile_path" | awk -F '/' '{print $NF}' > $HOME/.config/.current-theme
echo "dynamic" >> $HOME/.config/.current-theme

mako() {
  $HOME/.config/scripts/palette/update-mako.sh
  echo "" > $HOME/.config/mako/additional-options
}

fuzzel() {
  $HOME/.config/scripts/palette/update-fuzzel.sh
  echo "" > $HOME/.config/fuzzel/additional-options
}

mako
fuzzel
