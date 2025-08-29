#!/bin/bash

im=$(fcitx5-remote -n)
case "$im" in
"keyboard-us") echo "EN" ;;
"keyboard-fr-azerty") echo "FR" ;;
"pinyin") echo "PY" ;;
*) echo "${im:0:2}" ;; # fallback: first 2 chars
esac
