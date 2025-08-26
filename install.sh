#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from the dotfiles repo to their proper locations

DOTFILES_DIR="$HOME/dotfiles"

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory not found at $DOTFILES_DIR"
    exit 1
fi

echo "Installing dotfiles from $DOTFILES_DIR"

# Home directory dotfiles
HOME_FILES=(
    ".zshrc"
    ".zimrc"
    ".tmux.conf"
    ".bashrc"
    "starship.toml"
)

# Config directory dotfiles
CONFIG_DIRS=(
    "btop"
    "ghostty"
    "nvim"
)

# Create symlinks for home directory files
echo "Creating symlinks for home directory files..."
for file in "${HOME_FILES[@]}"; do
    source="$DOTFILES_DIR/home/$file"
    target="$HOME/$file"
    
    if [ -L "$target" ]; then
        echo "Removing existing symlink: $target"
        rm "$target"
    elif [ -f "$target" ]; then
        echo "Backing up existing file: $target -> $target.backup"
        mv "$target" "$target.backup"
    fi
    
    if [ -f "$source" ]; then
        ln -s "$source" "$target"
        echo "Created symlink: $target -> $source"
    else
        echo "Warning: Source file not found: $source"
    fi
done

# Create symlinks for config directory
echo "Creating symlinks for .config directory..."
mkdir -p "$HOME/.config"

for dir in "${CONFIG_DIRS[@]}"; do
    source="$DOTFILES_DIR/config/$dir"
    target="$HOME/.config/$dir"
    
    if [ -L "$target" ]; then
        echo "Removing existing symlink: $target"
        rm "$target"
    elif [ -d "$target" ]; then
        echo "Backing up existing directory: $target -> $target.backup"
        mv "$target" "$target.backup"
    fi
    
    if [ -d "$source" ]; then
        ln -s "$source" "$target"
        echo "Created symlink: $target -> $source"
    else
        echo "Warning: Source directory not found: $source"
    fi
done

echo "Dotfiles installation complete!"
echo "You may need to restart your shell or source your .zshrc/.bashrc"
