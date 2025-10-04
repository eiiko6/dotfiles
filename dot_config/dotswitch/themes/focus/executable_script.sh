#!/usr/bin/bash

echo "$profile_path" | awk -F '/' '{print $NF}' > $HOME/.config/.current-theme
echo "dynamic" >> $HOME/.config/.current-theme

mako() {
  $HOME/.config/scripts/palette/update-mako.sh "sed -i 's/border-radius=[0-9]\+/border-radius=0/' $HOME/.config/mako/config"
  echo "sed -i 's/border-radius=[0-9]\+/border-radius=0/' $HOME/.config/mako/config" > $HOME/.config/mako/additional-options
}

fuzzel() {
  $HOME/.config/scripts/palette/update-fuzzel.sh "[border]\nradius=0"
  echo "[border]\nradius=0" > $HOME/.config/fuzzel/additional-options
}

mako
fuzzel
