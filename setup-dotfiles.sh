#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
WINDOWS_ALACRITTY_DIR="/mnt/c/Users/dixie/AppData/Roaming/Alacritty"
DOTFILES_ALACRITTY_DIR="$DOTFILES_DIR/alacritty/.config/alacritty"

# Create necessary directories if they don't exist
mkdir -p "$DOTFILES_ALACRITTY_DIR"

# Function to check if file exists
file_exists() {
    [ -f "$1" ]
}

# Function to backup file
backup_file() {
    local file="$1"
    cp "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Created backup: ${file}.backup.$(date +%Y%m%d_%H%M%S)"
}

# Main logic for handling Alacritty config
handle_alacritty_config() {
    local windows_config="$WINDOWS_ALACRITTY_DIR/alacritty.toml"
    local dotfiles_config="$DOTFILES_ALACRITTY_DIR/alacritty.toml"


    # If Windows config exists but dotfiles config doesn't
    if file_exists "$windows_config" && ! file_exists "$dotfiles_config"; then
        echo "Moving existing Alacritty config to dotfiles..."
        cp "$windows_config" "$dotfiles_config"
        backup_file "$windows_config"
        rm "$windows_config"
    fi

    # Create symlink if it doesn't exist
    if [ ! -L "$windows_config" ]; then
        echo "Creating symlink for Alacritty config..."
        ln -s "$dotfiles_config" "$windows_config"
    fi
}

# Setup stow for other dotfiles
setup_stow() {
    cd "$DOTFILES_DIR" || exit 1
    echo "Running stow..."
    stow --adopt .
}

# Main execution
echo "Starting dotfiles setup..."


# Handle Alacritty config first

handle_alacritty_config

# Run stow for other dotfiles
setup_stow

echo "Setup complete!"
