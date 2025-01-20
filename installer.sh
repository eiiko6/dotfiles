#!/bin/bash

# Get package list for installation
. ./packages.sh

# Function to detect the Linux distribution
detect_distro() {
  if [ -f /etc/os-release ]; then
    # Extract the ID from /etc/os-release
    . /etc/os-release
    DISTRO=$ID
  else
    # Default to unsupported if the file doesn't exist
    DISTRO="unsupported"
  fi
}

# Function to validate sudo credentials upfront (only ask for password once)
validate_sudo() {
  if [[ $EUID -ne 0 ]]; then
    # Validate sudo and cache the credentials for the session
    echo "Please enter your password to proceed with the installation."
    sudo -v
  fi
}

# Handle Arch
handle_arch() {
  echo "Detected Arch-based system."

  echo "Installing required packages..."
  sudo pacman -Syu --noconfirm || {
    echo "Failed to execute pacman"
    return 1
  }
  sudo pacman -S --needed --noconfirm $PACMAN_PACKAGES
  clear
  echo "Packages installation ended"
  echo "Now installing dotfiles"

  # Install dotfiles
  chezmoi init --apply https://github.com/eiiko6/dotfiles.git
  echo "chezmoi installed and initialized with your dotfiles."
  # Replace my username with current user
  find ~/.config -type f -exec sed -i "s/mxstoto/$(whoami)/g" {} +
  clear
  echo "Dotfiles installation ended"
  echo "Now installing yay"

  # Install yay
  if ! command -v yay &>/dev/null; then
    echo "yay not found. Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd - && rm -rf /tmp/yay
  else
    echo "yay is already installed."
  fi
  clear
  echo "yay installation ended"

  # Install yay packages
  yay -S --noconfirm --needed $YAY_PACKAGES

  # Install my theme switcher
  mkdir "$HOME/.config/scripts"
  git clone https://github.com/eiiko6/theme-switcher.git ~/.config/scripts/theme-switcher

  # Set color themes with default temporary wallpaper
  fish -c 'source ~/.config/fish/config.fish; theme prettydesktop'
  mkdir -p "$HOME/Pictures/Wallpapers"
  cp "$(find "$HOME"/.config/theme-switcher/themes/ -type f -name 'wallpaper.png' | shuf -n 1)" "$HOME/Pictures/Wallpapers/wallpaper.png"
  fish -c 'source ~/.config/fish/functions/palette.fish; palette wallpaper'

  fish
}

install_extra_packages() {
  printf "Do you wish to install the optional $(echo $EXTRA_PACKAGES | wc -l) packages? [y/N] "
  read -r input

  case "$input" in
  [Yy])
    # Install the optional packages
    echo "Installing optional packages..."
    sudo yay -S --noconfirm --needed $EXTRA_PACKAGES
    ;;
  *)
    echo "Skipping installation of optional packages."
    ;;
  esac
}

# Handle unsupported distros
handle_unsupported() {
  echo "Unsupported Linux distribution: $DISTRO"
  echo "Currently, only Arch is supported."
  exit
}

# --------- EXECUTION ----------

# First check the distribution
detect_distro

# Validate sudo credentials upfront
validate_sudo

# Main script execution
case $DISTRO in
arch)
  handle_arch
  install_extra_packages
  ;;
*)
  handle_unsupported
  ;;
esac
