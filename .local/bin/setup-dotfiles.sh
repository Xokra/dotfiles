#!/bin/bash

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

DOTFILES_ALACRITTY_DIR="$DOTFILES_DIR/.config/alacritty"


# Function to detect operating system
detect_os() {
    local uname_output=$(uname -s)
    case "$uname_output" in
        Linux*)
            # Check if we're in WSL
            if uname -r | grep -q -i microsoft || uname -r | grep -q -i wsl; then
                echo "wsl"
            else
                echo "linux"
            fi

            ;;
        Darwin*)
            echo "mac"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Function to get Windows username (only for WSL)
get_windows_username() {
    if command -v cmd.exe > /dev/null 2>&1; then
        local username=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n')
        if [ -n "$username" ]; then
            echo "$username"
        else
            echo "dixie"
        fi

    else
        echo "dixie"
    fi
}

# Function to get the correct Alacritty target path based on OS
get_alacritty_target() {
    local os=$(detect_os)
    
    case "$os" in
        wsl)
            local windows_user=$(get_windows_username)
            echo "/mnt/c/Users/$windows_user/AppData/Roaming/Alacritty"
            ;;
        mac|linux)
            echo "$HOME/.config/alacritty"

            ;;
        *)

            echo "$HOME/.config/alacritty"
            ;;
    esac

}


# Create necessary directories
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
    local os=$(detect_os)
    local target_dir=$(get_alacritty_target)
    local target_config="$target_dir/alacritty.toml"

    local dotfiles_config="$DOTFILES_ALACRITTY_DIR/alacritty.toml"
    
    echo "Detected OS: $os"
    echo "Target directory: $target_dir"
    
    # Create target directory
    mkdir -p "$target_dir"
    
    # If target config exists but dotfiles config doesn't, move it to dotfiles first
    if file_exists "$target_config" && ! file_exists "$dotfiles_config"; then
        echo "Moving existing Alacritty config to dotfiles..."

        cp "$target_config" "$dotfiles_config"
        backup_file "$target_config"
    fi
    
    # Always copy from dotfiles to target (dotfiles is the source of truth)
    if file_exists "$dotfiles_config"; then
        echo "Copying Alacritty config from dotfiles to $os..."
        cp "$dotfiles_config" "$target_config"
        echo "Alacritty config copied successfully"
    else
        echo "Error: No Alacritty config found in dotfiles at $dotfiles_config"

        exit 1
    fi
}

# Setup stow for other dotfiles
setup_stow() {
    cd "$DOTFILES_DIR" || exit 1
    echo "Running stow..."
    if [ -f "smart-stow.sh" ]; then
        smart-stow.sh
    else
        echo "Warning: smart-stow.sh not found, skipping stow setup"
    fi
}

# Main execution
echo "Starting dotfiles setup..."
echo "================================"

# Handle Alacritty config first
handle_alacritty_config

echo "================================"


# Run stow for other dotfiles
setup_stow


echo "================================"
echo "Setup complete!"
echo "OS: $(detect_os)"
echo "Alacritty target: $(get_alacritty_target)"
