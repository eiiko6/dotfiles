geometry=$(hyprctl monitors | sed -n '2p' | cut -d '@' -f 1 | xargs)
grim -g "0,0 $geometry" "/tmp/lock-background.png"
pidof hyprlock || hyprlock
