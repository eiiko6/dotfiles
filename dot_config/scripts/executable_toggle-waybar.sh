#!/usr/bin/env sh
WAYBAR=$(pidof waybar)
if [ -z "$WAYBAR" ]; then
  nohup waybar &
  exit
else
  pkill waybar
  exit
fi
