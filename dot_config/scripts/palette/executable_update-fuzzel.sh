  # Read colors from wal cache
  WAL_COLORS="$HOME/.cache/wal/colors"

  # Load specific colors
  BORDER_COLOR=$(sed -n '3p' "$WAL_COLORS" | tr 'a-z' 'A-Z' | tr -d '#')     # color1
  TEXT_COLOR=$(sed -n '16p' "$WAL_COLORS" | tr 'a-z' 'A-Z' | tr -d '#')      # special (foreground)
  BACKGROUND_COLOR=$(sed -n '1p' "$WAL_COLORS" | tr 'a-z' 'A-Z' | tr -d '#') # background
  MATCH_COLOR=$(sed -n '3p' "$WAL_COLORS" | tr 'a-z' 'A-Z' | tr -d '#') # background
  HOVER_COLOR=$(sed -n '8p' "$WAL_COLORS" | tr 'a-z' 'A-Z' | tr -d '#') # background

  # Optional extra config
  EXTRA_CONFIG="$1"

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
background=${BACKGROUND_COLOR}55
text=${TEXT_COLOR}ff
match=${MATCH_COLOR}ff
selection-match=${BORDER_COLOR}ff
selection=${HOVER_COLOR}44
selection-text=${TEXT_COLOR}ff
border=${BORDER_COLOR}ff

[border]
width=2
radius=50
EOF

  # Append extra config if provided
  if [ -n "$EXTRA_CONFIG" ]; then
    echo -e "\n$EXTRA_CONFIG" >> "$HOME/.config/fuzzel/fuzzel.ini"
  fi
