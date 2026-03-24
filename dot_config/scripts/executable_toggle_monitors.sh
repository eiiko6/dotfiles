#!/usr/bin/env bash

hyprctl monitors | grep -q "dpmsStatus: 1" \
    && hyprctl dispatch dpms off \
    || hyprctl dispatch dpms on
