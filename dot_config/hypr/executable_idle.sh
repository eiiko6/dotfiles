#!/usr/bin/env sh
if [[ $(pgrep hypridle) ]]; then
  pkill hypridle
  notify-send "Idle actions disabled"
  exit
else
  nohup hypridle &
  notify-send "Idle actions enabled"
  exit
fi
