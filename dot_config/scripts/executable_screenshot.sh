#!/bin/sh

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
timestamp=$(date +'%Y-%m-%d_%H-%M-%S')

if [ "$1" = "full" ]; then
  geometry=$(hyprctl monitors | sed -n '2p' | cut -d '@' -f 1 | xargs)
  grim -g "0,0 $geometry" "$dir/$timestamp.png"
else
  grim -g "$(slurp)" "$dir/$timestamp.png"
fi

wl-copy <"$dir/$timestamp.png"
