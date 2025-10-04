# Read colors from wal cache
WAL_COLORS="$HOME/.cache/wal/colors"

# Load specific colors
BORDER_COLOR=$(sed -n '3p' "$WAL_COLORS" | tr 'a-z' 'A-Z' | tr -d '#')     # color1
TEXT_COLOR=$(sed -n '16p' "$WAL_COLORS" | tr 'a-z' 'A-Z' | tr -d '#')      # special (foreground)
BACKGROUND_COLOR=$(sed -n '1p' "$WAL_COLORS" | tr 'a-z' 'A-Z' | tr -d '#') # background

# Optional extra config
EXTRA_CONFIG="$1"

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
on-notify=exec mpv /usr/share/sounds/freedesktop/stereo/message.oga

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

background-color=#${BACKGROUND_COLOR}55
text-color=#${TEXT_COLOR}
border-color=#${BORDER_COLOR}
progress-color=over #89b4fa

[urgency=low]
border-color=#${BORDER_COLOR}
default-timeout=2000

[urgency=normal]
border-color=#${BORDER_COLOR}
default-timeout=5000

[urgency=high]
border-color=#f38ba8
text-color=#f38ba8
default-timeout=0

[category=mpd]
border-color=#f9e2af
default-timeout=2000
group-by=category
EOF

# Append extra config if provided
if [ -n "$EXTRA_CONFIG" ]; then
  bash -c "$EXTRA_CONFIG"
fi

makoctl reload
