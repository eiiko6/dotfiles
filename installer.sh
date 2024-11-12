#!/bin/bash

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

# Define SUDO variable based on whether the script is running as root
SUDO=""
if [[ $EUID -ne 0 ]]; then
  SUDO="sudo"
fi

# Handle Arch (work in progress)
handle_arch() {
  echo "Detected Arch-based system."

  # Install chezmoi without asking for confirmation
  $SUDO pacman -Sy --noconfirm chezmoi

  # Initialize chezmoi with your dotfiles repo
  chezmoi init --apply https://github.com/eiiko6/dotfiles.git

  echo "chezmoi installed and initialized with your dotfiles."

  fish

  theme -s wal-focus-desktop
}

# Handle unsupported distros
handle_unsupported() {
  echo "Unsupported Linux distribution: $DISTRO"
  echo "Currently, only Arch is supported."
  exit
}

# Main script execution
detect_distro

case $DISTRO in
arch)
  handle_arch
  ;;
*)
  handle_unsupported
  ;;
esac
