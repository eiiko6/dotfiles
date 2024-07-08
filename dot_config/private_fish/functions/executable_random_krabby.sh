#!/bin/bash

source ~/.config/random-krabby/pokemon-list.conf

random_pokemon=${pokemon[$RANDOM % ${#pokemon[@]}]}

# Determine if "-s" should be added with a 1/10 chance
if [ $((RANDOM % 10)) -eq 0 ]; then
	suffix=" -s"
else
	suffix=""
fi

command="krabby name $random_pokemon$suffix"
$command
if [ "$suffix" = " -s" ]; then
	echo ✨
fi
