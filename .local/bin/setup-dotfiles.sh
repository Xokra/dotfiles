#!/bin/bash

# Enhanced setup-dotfiles.sh
# Comprehensive dotfiles setup script for WSL, Mac, and Arch Linux

set -euo pipefail

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"


# Colors for output

RED='\033[0;31m'
GREEN='\033[0;32m'

YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {

    echo -e "${RED}[ERROR]${NC} $1"
}

info() {
    echo -e "${BLUE}[SETUP]${NC} $1"
}

# Function to detect operating system platform
detect_platform() {
    local uname_output=$(uname -s)

    case "$uname_output" in
        Linux*)
            # Check if we're in WSL
            if uname -r | grep -q -i microsoft || uname -r | grep -q -i wsl; then
                echo "wsl"
            elif [ -f /etc/arch-release ]; then
                echo "arch"
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

# Step 1: Platform Recognition
recognize_platform() {

    local platform=$(detect_platform)
    info "Platform detected: $platform"
    
    case "$platform" in
        wsl)
            log "Running on WSL (Ubuntu)"
            ;;
        mac)
            log "Running on macOS"
            ;;

        arch)
            log "Running on Arch Linux (i3)"
            ;;

        *)
            error "Unsupported platform: $platform"
            exit 1
            ;;

    esac
    
    echo "$platform"
}

# Step 2: Make bin scripts executable

make_bin_executable() {
    info "Making all scripts in ~/.local/bin executable..."
    

    if [ -d "$DOTFILES_DIR/.local/bin" ]; then

        chmod +x "$DOTFILES_DIR/.local/bin/"*
        log "Made all scripts in $DOTFILES_DIR/.local/bin executable"
    else
        warn "Directory $DOTFILES_DIR/.local/bin not found"
    fi
}

# Step 3 & 4: WSL-specific logic
handle_wsl_specific() {
    local platform="$1"
    

    if [ "$platform" = "wsl" ]; then
        info "Executing WSL-specific setup..."
        
        # Copy zedScript to Windows directory
        local windows_user=$(get_windows_username)
        local zed_script_target="/mnt/c/zedScript"
        
        if [ -d "$DOTFILES_DIR/zedScript" ]; then
            log "Copying zedScript to $zed_script_target..."
            
            # Create target directory if it doesn't exist
            sudo mkdir -p "$zed_script_target" 2>/dev/null || mkdir -p "$zed_script_target"
            
            # Copy the entire zedScript directory
            cp -r "$DOTFILES_DIR/zedScript/"* "$zed_script_target/"
            log "zedScript copied successfully"
            
            # Create shell:startup shortcuts for VBS files
            local startup_dir="/mnt/c/Users/$windows_user/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
            
            if [ -d "$startup_dir" ]; then
                log "Creating startup shortcuts for VBS files..."
                
                # Find all VBS files in zedScript and create shortcuts
                find "$zed_script_target" -name "*.vbs" -type f | while read -r vbs_file; do
                    local vbs_name=$(basename "$vbs_file" .vbs)
                    local shortcut_path="$startup_dir/${vbs_name}.lnk"

                    
                    # Create a simple batch file to run the VBS (Windows will handle the .lnk creation)
                    local batch_file="$startup_dir/${vbs_name}.bat"

                    echo "@echo off" > "$batch_file"
                    echo "cscript.exe \"$vbs_file\"" >> "$batch_file"
                    
                    log "Created startup script: $batch_file"

                done
            else
                warn "Startup directory not found: $startup_dir"
            fi
        else
            warn "zedScript directory not found in dotfiles"
        fi
    else
        log "Not on WSL, skipping Windows-specific setup"

    fi
}

# Function to get the correct Alacritty target path based on platform
get_alacritty_target() {
    local platform="$1"
    

    case "$platform" in
        wsl)
            local windows_user=$(get_windows_username)
            echo "/mnt/c/Users/$windows_user/AppData/Roaming/Alacritty"
            ;;
        mac|arch|linux)
            echo "$HOME/.config/alacritty"
            ;;
        *)
            echo "$HOME/.config/alacritty"
            ;;
    esac
}

# Function to backup file
backup_file() {
    local file="$1"
    cp "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
    log "Created backup: ${file}.backup.$(date +%Y%m%d_%H%M%S)"
}

# Handle Alacritty configuration
handle_alacritty_config() {
    local platform="$1"
    local target_dir=$(get_alacritty_target "$platform")

    local target_config="$target_dir/alacritty.toml"
    local dotfiles_config="$DOTFILES_DIR/.config/alacritty/alacritty.toml"
    

    info "Setting up Alacritty configuration for $platform..."
    log "Target directory: $target_dir"
    
    # Create dotfiles alacritty directory
    mkdir -p "$DOTFILES_DIR/.config/alacritty"
    
    # Create target directory
    mkdir -p "$target_dir"
    
    # If target config exists but dotfiles config doesn't, move it to dotfiles first
    if [ -f "$target_config" ] && [ ! -f "$dotfiles_config" ]; then
        log "Moving existing Alacritty config to dotfiles..."
        cp "$target_config" "$dotfiles_config"
        backup_file "$target_config"
    fi

    
    # Always copy from dotfiles to target (dotfiles is the source of truth)
    if [ -f "$dotfiles_config" ]; then
        log "Copying Alacritty config from dotfiles to $platform..."
        cp "$dotfiles_config" "$target_config"
        log "Alacritty config copied successfully"
    else
        warn "No Alacritty config found in dotfiles at $dotfiles_config"
    fi
}

# Step 5: Run smart-stow based on platform
run_smart_stow() {
    local platform="$1"

    
    info "Running smart-stow for platform: $platform"
    
    cd "$DOTFILES_DIR" || exit 1
    
    if [ -f "$DOTFILES_DIR/.local/bin/smart-stow.sh" ]; then
        log "Executing smart-stow.sh..."
        "$DOTFILES_DIR/.local/bin/smart-stow.sh"
    else
        error "smart-stow.sh not found in $DOTFILES_DIR/.local/bin/"
        exit 1
    fi
}

# Step 6: Source configuration files
source_configs() {
    info "Sourcing configuration files..."
    
    # List of files to source
    local config_files=(
        "$HOME/.zshrc"
        "$HOME/.tmux.conf"
    )
    
    # Additional platform-specific configs
    local platform=$(detect_platform)

    case "$platform" in
        arch)
            # Add i3 config sourcing if needed
            if [ -f "$HOME/.config/i3/config" ]; then

                log "i3 config found (will be loaded on next i3 restart)"

            fi
            ;;
        mac)
            # Add macOS-specific configs
            if [ -f "$HOME/.bash_profile" ]; then
                config_files+=("$HOME/.bash_profile")
            fi
            ;;
    esac
    
    # Source each config file
    for config_file in "${config_files[@]}"; do
        if [ -f "$config_file" ]; then
            log "Sourcing $config_file..."

            case "$config_file" in
                *.zshrc)
                    # Source zshrc in current shell if using zsh
                    if [ "$SHELL" = "$(which zsh)" ] || [ -n "${ZSH_VERSION:-}" ]; then
                        source "$config_file" 2>/dev/null || warn "Failed to source $config_file"
                    else

                        log "Not in zsh, $config_file will be sourced on next zsh session"
                    fi
                    ;;
                *.tmux.conf)
                    # Reload tmux config if tmux is running
                    if command -v tmux > /dev/null 2>&1 && tmux info > /dev/null 2>&1; then
                        tmux source-file "$config_file" 2>/dev/null || warn "Failed to reload tmux config"
                        log "Tmux config reloaded"
                    else
                        log "Tmux not running, $config_file will be loaded on next tmux session"
                    fi
                    ;;
                *)
                    source "$config_file" 2>/dev/null || warn "Failed to source $config_file"
                    ;;
            esac
        else
            warn "Config file not found: $config_file"
        fi
    done
}

# Additional files that might need sourcing
source_additional_configs() {
    info "Checking for additional configuration files..."

    
    local additional_configs=(
        "$HOME/.bashrc"
        "$HOME/.profile"
        "$HOME/.vimrc"
        "$HOME/.config/nvim/init.lua"
        "$HOME/.aliases"
        "$HOME/.functions"
    )
    
    for config in "${additional_configs[@]}"; do
        if [ -f "$config" ]; then
            case "$config" in
                *.bashrc|*.profile|*.aliases|*.functions)
                    log "Found $config (will be loaded in next shell session)"
                    ;;
                *.vimrc)
                    log "Found $config (will be loaded in next vim session)"
                    ;;
                *nvim/init.lua)
                    log "Found $config (will be loaded in next nvim session)"
                    ;;

            esac
        fi

    done
}

# Main execution function
main() {
    info "Starting enhanced dotfiles setup..."
    echo "=================================="
    
    # Check if dotfiles directory exists
    if [ ! -d "$DOTFILES_DIR" ]; then
        error "Dotfiles directory not found: $DOTFILES_DIR"

        exit 1
    fi
    
    # Step 1: Recognize platform

    local platform=$(recognize_platform)
    
    echo "=================================="

    
    # Step 2: Make bin scripts executable
    make_bin_executable
    
    echo "=================================="
    
    # Step 3 & 4: Handle WSL-specific logic
    handle_wsl_specific "$platform"
    
    echo "=================================="
    
    # Handle Alacritty configuration
    handle_alacritty_config "$platform"
    
    echo "=================================="
    
    # Step 5: Run smart-stow

    run_smart_stow "$platform"
    
    echo "=================================="
    
    # Step 6: Source configuration files
    source_configs
    
    echo "=================================="
    
    # Check for additional configs
    source_additional_configs
    
    echo "=================================="
    log "Setup complete!"
    log "Platform: $platform"
    
    # Final instructions
    info "Next steps:"
    echo "  1. Restart your shell or run: source ~/.zshrc"
    echo "  2. If using tmux, restart tmux or run: tmux source-file ~/.tmux.conf"
    
    case "$platform" in
        arch)
            echo "  3. Restart i3 to load new configs: \$mod+Shift+r"
            ;;
        wsl)
            echo "  3. Check Windows startup folder for VBS script shortcuts"
            ;;
        mac)
            echo "  3. You may need to restart Terminal.app for all changes to take effect"
            ;;
    esac
}

# Run main function
main "$@"
