#!/usr/bin/bash

echo "$profile_path" | awk -F '/' '{print $NF}' > $HOME/.config/.current-theme
echo "static" >> $HOME/.config/.current-theme

mako() {
  # Read colors from wal cache
  WAL_COLORS="$HOME/.cache/wal/colors"

  # Load specific colors
  BORDER_COLOR=$(sed -n '3p' "$WAL_COLORS")     # color1
  TEXT_COLOR=$(sed -n '16p' "$WAL_COLORS")      # special (foreground)
  BACKGROUND_COLOR=$(sed -n '1p' "$WAL_COLORS") # background

  # Generate mako config
  cat >"$HOME/.config/mako/config" <<EOF
# Auto-generated mako config

# GLOBAL
max-history=100
sort=-time

# BINDING OPTIONS
on-button-left=dismiss
on-button-middle=none
on-button-right=dismiss-all
on-touch=dismiss
#on-notify=exec mpv /usr/share/sounds/freedesktop/stereo/message.oga

# STYLE OPTIONS
font=Fantasque Sans Mono 14
width=500
height=300
margin=15
outer-margin=30
padding=15
border-size=2
border-radius=10
icons=1
max-icon-size=48
icon-location=left
markup=1
actions=1
history=1
text-alignment=center
default-timeout=2000
ignore-timeout=0
max-visible=6
layer=overlay
anchor=top-right

# Catppuccin

background-color=#eff1f5
text-color=#4c4f69
border-color=#ea76cb
progress-color=over #ccd0da

[urgency=high]
border-color=#fe640b
EOF

  makoctl reload
}

fuzzel() {
  # Read colors from wal cache
  WAL_COLORS="$HOME/.cache/wal/colors"

  # Load specific colors
  BORDER_COLOR=ea76cb
  TEXT_COLOR=4c4f69
  BACKGROUND_COLOR=eff1f5
  MATCH_COLOR=fe640b
  HOVER_COLOR=ccd0da

  # Generate fuzzel config
  cat >"$HOME/.config/fuzzel/fuzzel.ini" <<EOF
# Auto-generated fuzzel config

font=GoMono Nerd Font:size=14
dpi-aware=no
prompt="> "
icon-theme=hicolor
icons-enabled=yes

lines=15
width=50
horizontal-pad=10
vertical-pad=10
inner-pad=10
line-height=18

[colors]
background=${BACKGROUND_COLOR}ff
text=${TEXT_COLOR}ff
match=${MATCH_COLOR}ff
selection-match=${BORDER_COLOR}ff
selection=${HOVER_COLOR}ff
selection-text=${TEXT_COLOR}ff
border=${BORDER_COLOR}ff

[border]
width=2
radius=50
EOF
}

mako
fuzzel

kitty @ set-colors --all "$HOME/.config/kitty/options.conf"
notify-send "May I please have an espresso macchiato 𖹭"
