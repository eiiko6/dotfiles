#!/bin/bash

while true; do
  album_art=$(playerctl -p spotify metadata mpris:artUrl)
  if [[ -z $album_art ]]; then
    sleep 10
  fi
  curl -s "${album_art}" --output "/tmp/cover-raw.jpeg"
  magick -size 500x500 xc:none -draw "roundrectangle 0,0,500,500,64,64" /tmp/mask.png
  magick /tmp/cover-raw.jpeg -resize 500x500^ -gravity center -extent 500x500 -alpha set /tmp/mask.png -compose DstIn -composite /tmp/cover.png
  sleep 10
done
