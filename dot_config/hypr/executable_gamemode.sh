#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
  pkill waybar
  hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:rounding 0"
  exit
else
  nohup waybar &
fi
hyprctl reload

#         keyword decoration:blur:enabled 0;\
