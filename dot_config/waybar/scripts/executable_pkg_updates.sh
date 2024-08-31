#!/bin/bash

# File to store the count
COUNT_FILE="$HOME/.cache/pkg_updates_count"

update_count() {
  # Update official packages count
  OFFICIAL_COUNT=$(checkupdates 2>/dev/null | wc -l)

  # Update AUR packages count
  AUR_COUNT=$(yay -Qua 2>/dev/null | wc -l)

  TOTAL_COUNT=$((OFFICIAL_COUNT + AUR_COUNT))

  echo $TOTAL_COUNT >$COUNT_FILE
  echo $TOTAL_COUNT
}

update_packages() {
  if [[ "$(cat $COUNT_FILE)" -eq 0 ]]; then
    notify-send "Everything is up to date!" "There is nothing to do."
  else
    # Update everything (official and AUR)
    notify-send "Opening a terminal..."

    kitty --class updates --hold -e bash -c "
        echo '> Updating system...'; 
        yay -Syu; 
        clear
        echo '> Cleaning package cache...'; 
        sudo pacman -Sc --noconfirm; 
        clear
        # echo '> Removing orphaned packages...'; 
        # sudo pacman -Rns \$(pacman -Qdtq) --noconfirm; 
        clear
        echo '> System updated! Press any key to close...'; 
        read -n 1"

    # Update the count file
    update_count
  fi
}

# Check arguments
if [[ $1 == "--update" ]]; then
  update_packages
else
  # Otherwise, just print the update count
  update_count
fi
