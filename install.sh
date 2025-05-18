#!/usr/bin/env bash

set -euo pipefail

echo "[+] Starting dotfiles installation..."

### CONFIG ###
DOTFILES_DIR="$HOME/.dotfiles"
STOW_FOLDERS=("bash" "zsh" "git" "nano" "aliases")
REQUIRED_APPS=("zsh" "git" "stow" "curl")
DEFAULT_SHELL="$(command -v zsh)"
################

# Function to install a package depending on OS
install_package() {
    local pkg=$1
    echo "[*] Installing $pkg..."
    if command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y "$pkg"
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y "$pkg"
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Syu --noconfirm "$pkg"
    elif command -v brew >/dev/null 2>&1; then
        brew install "$pkg"
    else
        echo "[!] Unsupported package manager. Please install $pkg manually."
        exit 1
    fi
}

# Check and install required apps
for app in "${REQUIRED_APPS[@]}"; do
    if ! command -v "$app" >/dev/null 2>&1; then
        install_package "$app"
    else
        echo "[+] $app is already installed."
    fi
done

# Use GNU Stow to symlink configs
echo "[+] Stowing dotfiles..."
cd "$DOTFILES_DIR"
for folder in "${STOW_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        stow "$folder"
    else
        echo "[!] Warning: Folder '$folder' does not exist in $DOTFILES_DIR"
    fi
done

# Change default shell to Zsh if not already
if [ "$SHELL" != "$DEFAULT_SHELL" ]; then
    echo "[+] Changing default shell to Zsh..."
    chsh -s "$DEFAULT_SHELL"
    echo "[!] Default shell changed. Please log out and back in to apply."
else
    echo "[+] Zsh is already the default shell."
fi

echo "[✓] Dotfiles installation complete!"
