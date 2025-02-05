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

# Function to get sudo credentials (only ask for password once)
validate_sudo() {
  if [[ $EUID -ne 0 ]]; then
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
  yay -S --noconfirm --needed --sudoloop $YAY_PACKAGES

  # Set color themes with default temporary wallpaper
  fish -c 'source ~/.config/fish/config.fish; theme prettydesktop'
  mkdir -p "$HOME/Pictures/Wallpapers"
  cp "$(find "$HOME"/.config/theme-switcher/themes/ -type f -name 'wallpaper.png' | shuf -n 1)" "$HOME/Pictures/Wallpapers/wallpaper.png"
  ~/.config/scripts/palette/change-wallpaper.sh wallpaper

  # Setup directories
  mkdir -p ~/.local/share/icons ~/Desktop/

  sudo mv /usr/share/icons/rose-pine-hyprcursor/ ~/.local/share/icons/
}

install_extra_packages() {
  printf "Do you wish to install the optional $(echo $EXTRA_PACKAGES | wc -l) packages? [y/N] "
  read -r input

  case "$input" in
  [Yy])
    # Install the optional packages
    echo "Installing optional packages..."
    yay -S --noconfirm --needed --sudoloop $EXTRA_PACKAGES
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

# --------- PACKAGES -----------

PACMAN_PACKAGES="
acpid
audacious
blueman
brightnessctl
chezmoi
cliphist
eza
fastfetch
file-roller
fish
fuse2
gnome-themes-extra
grim
gtk-engine-murrine
gtk3
gvfs
hyprcursor
hyprland
kitty
lemurs
libpulse
mako
mupdf
neovim
network-manager-applet
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
nwg-look
pacman-contrib
pamixer
pavucontrol
pipewire
pipewire-pulse
python-pywal
qt5-graphicaleffects
qt5-quickcontrols2
qt5-wayland
qt5ct
qt6-5compat
qt6-wayland
qt6ct
slurp
starship
swappy
sway
swww
thunar
thunar-archive-plugin
ttf-fira-code
ttf-hack
ttf-jetbrains-mono-nerd
unrar
unzip
waybar
wayland
wireplumber
wofi
xdg-desktop-portal
xdg-desktop-portal-hyprland
xfce4-settings
xorg-server
xorg-xinit
"

YAY_PACKAGES="
rose-pine-hyprcursor
swaylock-effects
"

EXTRA_PACKAGES="
arch-install-scripts
btop
firefox
graphite-gtk-theme
krabby-bin
less
man-db
mvp
npm
qemu-full
rust-analyzer
spotify-lauhcher
stress
tealdeer
vesktop
yt-dlp
"

# --------- EXECUTION ----------

# First check the distribution
detect_distro

# Get sudo password
validate_sudo

# Main script execution
case $DISTRO in
arch)
  handle_arch
  install_extra_packages

  echo "==> Dotfiles installation has ended."
  ;;
*)
  handle_unsupported
  ;;
esac
