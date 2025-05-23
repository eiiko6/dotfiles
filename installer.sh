#!/bin/bash

# --------- PACKAGES -----------

PACMAN_PACKAGES="
  blueman
  brightnessctl
  rustup
  chezmoi
  cliphist
  eza
  fastfetch
  file-roller
  fish
  gnome-themes-extra
  grim
  gtk3
  gvfs
  hyprcursor
  hyprland
  hyprlock
  hypridle
  kitty
  lemurs
  libpulse
  mako
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
  qt6-5compat
  qt6-wayland
  qt6ct
  slurp
  starship
  swappy
  swww
  thunar
  thunar-archive-plugin
  tumbler
  ttf-fira-code
  ttf-hack
  ttf-jetbrains-mono-nerd
  7zip
  waybar
  wayland
  wireplumber
  wofi
  xdg-desktop-portal
  xdg-desktop-portal-hyprland
"

YAY_PACKAGES="
"

EXTRA_PACKAGES="
  arch-install-scripts
  audacious
  btop
  firefox
  less
  man-db
  mvp
  npm
  qemu
  rust-analyzer
  spotify-lauhcher
  stress
  tealdeer
  vesktop
  yt-dlp
"

RUST_PACKAGES="
  yazi
  hyperfine
  dust
  zoxide
  fd
  uutils-coreutils
  sudo-rs
"

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

# Ask for install type: default or extended
choose_install_type() {
  echo "Select install type:"
  echo "1) Default (minimal setup)"
  echo "2) Extended (includes Firefox, Vesktop, Spotify, etc...)"
  read -rp "Enter 1 or 2: " install_choice

  case "$install_choice" in
  2)
    INSTALL_EXTENDED=true
    ;;
  *)
    INSTALL_EXTENDED=false
    ;;
  esac
}

# Ask if the user wants to run the oxidation process
ask_oxidize() {
  read -rp "Do you want to oxidize the install (Rust tools and tweaks)? [y/N] " oxidize
  case "$oxidize" in
  [Yy]*) OXIDIZE_INSTALL=true ;;
  *) OXIDIZE_INSTALL=false ;;
  esac
}

oxidize_install() {
  echo "Installing Rust-powered replacements..."

  yay -S --noconfirm --needed --sudoloop $RUST_PACKAGES

  rustup default stable

  # Create overrides directory
  mkdir -p ~/.local/rust-overrides

  # Add to private fish config
  mkdir -p ~/private
  {
    echo 'set -U fish_user_paths ~/.local/rust-overrides $fish_user_paths'
    echo 'zoxide init fish | source'
  } >>~/private/config.fish

  # Link uu-* binaries
  for bin in /usr/bin/uu-*; do
    base_name=$(basename "$bin" | sed 's/^uu-//')
    ln -sf "$bin" "$HOME/.local/rust-overrides/$base_name"
  done

  # Link sudo-rs and su-rs
  ln -sf /usr/bin/sudo-rs "$HOME/.local/rust-overrides/sudo"
  ln -sf /usr/bin/su-rs "$HOME/.local/rust-overrides/su"

  # Install some additional tools
  cargo install --git "https://github.com/eiiko6/here"
  rm ~/.config/fish/functions/here.fish

  echo "Rust-based tools installed and configured."
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
  # clear
  echo "Packages installation ended"
  echo "Now installing dotfiles"

  # Install dotfiles
  chezmoi init --apply https://github.com/eiiko6/dotfiles.git
  echo "chezmoi installed and initialized with your dotfiles."
  # Replace my username with current user
  find ~/.config -type f -exec sed -i "s/strawberries/$(whoami)/g" {} +
  # clear
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
  # clear
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
  printf "Installing $(echo $EXTRA_PACKAGES | tr ' ' '\n' | wc -l) extra packages"

  # Install the optional packages
  yay -S --noconfirm --needed --sudoloop $EXTRA_PACKAGES
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

# Ask for install type and rust extras
choose_install_type
ask_oxidize

# Get sudo password
validate_sudo

# Main script execution
case $DISTRO in
arch)
  handle_arch

  if $INSTALL_EXTENDED; then
    install_extra_packages
  fi

  if $OXIDIZE_INSTALL; then
    oxidize_install
  fi

  echo "==> Dotfiles installation has ended."
  ;;
*)
  handle_unsupported
  ;;
esac
