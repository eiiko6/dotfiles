#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
  hyprctl --batch "\
        keyword animations:enabled 0;\
        # keyword decoration:drop_shadow 0;\
        # keyword general:gaps_in -1;\
        # keyword general:gaps_out 0;\
        # keyword general:border_size 2;\
        # keyword decoration:blur:enabled 0;\
        # keyword decoration:rounding 0"
  notify-send "Special gamemode enabled"
else
  notify-send "Special gamemode disabled"
  hyprctl reload
fi
