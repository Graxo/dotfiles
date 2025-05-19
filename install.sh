#!/usr/bin/env bash

set -euo pipefail

USER_HOME="${HOME}"
DOTFILES_REPO="git@github.com:Graxo/dotfiles.git"
DOTFILES_DIR="${USER_HOME}/.dotfiles"
STOW_DIRS=("bash" "zsh" "git" "nano" "aliases")
P10K_REPO="https://github.com/romkatv/powerlevel10k.git"
P10K_DIR="~/.oh-my-zsh/custom/themes/"
REQUIRED_PACKAGES=("git" "zsh" "stow" "curl")

echo "[+] Installing dotfiles for user: $(whoami)"

# 1. Ensure required packages
for pkg in "${REQUIRED_PACKAGES[@]}"; do
    if ! command -v "$pkg" >/dev/null 2>&1; then
        echo "[*] Installing missing package: $pkg"
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y "$pkg"
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y "$pkg"
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy --noconfirm "$pkg"
        else
            echo "[-] Unsupported package manager. Install $pkg manually."
            exit 1
        fi
    fi
done

# 2. Clone dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "[+] Cloning dotfiles..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "[=] Dotfiles repo already exists. Pulling latest..."
    git -C "$DOTFILES_DIR" pull
fi

# 3. Verify required directories exist
for dir in "${STOW_DIRS[@]}"; do
    if [ ! -d "$DOTFILES_DIR/$dir" ]; then
        echo "[-] Missing directory: $DOTFILES_DIR/$dir"
        echo "    Make sure it exists and contains the appropriate dotfiles."
        exit 1
    fi
done

# 4. Backup conflicting files
for dir in "${STOW_DIRS[@]}"; do
    for file in "$DOTFILES_DIR/$dir"/.*; do
        [ "$(basename "$file")" = "." ] || [ "$(basename "$file")" = ".." ] && continue
        target="${USER_HOME}/$(basename "$file")"
        if [ -f "$target" ] && [ ! -L "$target" ]; then
            echo "[~] Backing up $target to $target.backup"
            mv "$target" "$target.backup"
        fi
    done
done

# 5. Stow dotfiles
echo "[+] Stowing dotfiles..."
cd "$DOTFILES_DIR"
for dir in "${STOW_DIRS[@]}"; do
    [ -d "$dir" ] && stow -t "$USER_HOME" "$dir"
done

# 6. Install Powerlevel10k
if [ ! -d "$P10K_DIR" ]; then
    echo "[+] Installing Powerlevel10k..."
    git clone --depth=1 "$P10K_REPO" "$P10K_DIR"
fi

# 7. Copy .p10k.zsh if present
if [ -f "$DOTFILES_DIR/zsh/.p10k.zsh" ]; then
    echo "[+] Installing .p10k.zsh config"
    cp "$DOTFILES_DIR/zsh/.p10k.zsh" "$USER_HOME/.p10k.zsh"
fi

# 8. Set Zsh as default shell
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "[+] Changing login shell to Zsh"
    chsh -s "$(command -v zsh)"
fi

echo "[✓] Dotfiles installation complete. Please restart your shell or log out/in."
