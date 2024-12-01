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

# Handle Arch
handle_arch() {
  echo "Detected Arch-based system."

  echo "Installing required packages..."
  $SUDO pacman -Syu --noconfirm
  $SUDO pacman -S --needed --noconfirm acpid blueman chezmoi cliphist eza fish fuse2 grim gtk3 hyprland kitty less lxappearance-gtk3 mako man-db mupdf neovim network-manager-applet noto-fonts-emoji npm nwg-look pamixer pavucontrol python-pywal qt5ct qt5-graphicaleffects qt5-quickcontrols2 qt5-wayland qt6-5compat qt6ct qt6-wayland rust-analyzer slurp starship swappy sway swww thunar thunar-archive-plugin ttf-fira-code ttf-hack ttf-jetbrains-mono-nerd unrar unzip waybar wayland wireplumber wofi xdg-desktop-portal-hyprland xfce4-settings xorg-server xorg-xinit
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
    $SUDO pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd - && rm -rf /tmp/yay
  else
    echo "yay is already installed."
  fi
  clear
  echo "yay installation ended"

  # Intall yay packages
  yay -S --noconfirm --needed krabby-bin swaylock-effects

  # Install my theme switcher
  mkdir "$HOME/.config/scripts"
  git clone https://github.com/eiiko6/theme-switcher.git ~/.config/scripts/theme-switcher

  # Set color themes with default temporary wallpaper
  fish -c 'source ~/.config/fish/config.fish; theme prettydesktop'
  mkdir -p "$HOME/Pictures/Wallpapers"
  cp "$HOME/Themes/prettydesktop/wallpaper.png" "$HOME/Pictures/Wallpapers/aura.png"
  fish -c 'source ~/.config/fish/functions/palette.fish; palette aura'

  fish
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

# Define SUDO variable based on whether the script is running as root
SUDO=""
if [[ $EUID -ne 0 ]]; then
  SUDO="sudo"
fi

# Main script execution
case $DISTRO in
arch)
  handle_arch
  ;;
*)
  handle_unsupported
  ;;
esac
