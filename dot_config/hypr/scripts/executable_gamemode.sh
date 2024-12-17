#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption decoration:blur:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
  hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword general:gaps_in -1;\
        keyword general:gaps_out 0;\
        keyword general:border_size 2;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:rounding 0"
  exit
fi
hyprctl reload

#         keyword decoration:blur:enabled 0;\
