#!/usr/bin/env sh
FCITX5=$(pidof fcitx5)
if [ -z "$FCITX5" ]; then
  nohup fcitx5 &
  exit
else
  pkill fcitx5
  exit
fi
