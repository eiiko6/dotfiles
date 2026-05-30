#!/usr/bin/env sh
FCITX5=$(pidof fcitx5)
if [ -z "$FCITX5" ]; then
    nohup fcitx5 --disable=wayland_diagnose &
    notify-send "Started fcitx5"
    exit
else
    pkill fcitx5
    notify-send "Killed fcitx5"
    exit
fi
