#!/bin/sh

emojis="$(cat ~/.config/scripts/emojis.txt)"

choice="$(printf "%s\n" "$emojis" | fuzzel --dmenu --match-mode=exact --prompt 'Pick emoji: ')"

# if cancelled
[ -z "$choice" ] && exit

# extract the first "word" (the emoji)
emoji="$(printf "%s" "$choice" | awk '{print $1}')"

# copy to clipboard and store in cliphist
printf "%s" "$emoji" | wl-copy
