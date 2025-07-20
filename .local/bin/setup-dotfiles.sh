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

# Function to check if Alacritty config already has shell section commented out
is_alacritty_shell_commented() {
    local config_file="$1"
    
    if [ ! -f "$config_file" ]; then
        return 1  # File doesn't exist, so not commented
    fi
    
    # Check if the shell section is commented out
    # Look for either a commented [shell] section or commented program line
    if grep -q "^#\[shell\]" "$config_file" || grep -q "^#program = \"wsl\.exe" "$config_file"; then
        return 0  # Already commented

    else
        return 1  # Not commented
    fi
}

# Function to backup file

backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local backup_name="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup_name"
        log "Created backup: $backup_name"
    fi

}


# Function to modify dotfiles Alacritty config based on platform
modify_dotfiles_alacritty_config() {
    local platform="$1"

    local alacritty_config="$DOTFILES_DIR/.config/alacritty/alacritty.toml"
    
    info "Checking Alacritty configuration for platform: $platform"
    

    if [ ! -f "$alacritty_config" ]; then
        warn "Alacritty config not found: $alacritty_config"
        return 1
    fi
    
    # Check current state of the config
    local is_commented
    if is_alacritty_shell_commented "$alacritty_config"; then
        is_commented="true"
    else
        is_commented="false"
    fi
    
    log "Current state - Shell section commented: $is_commented"
    log "Platform: $platform"
    
    # Platform-based logic: WSL should be uncommented, non-WSL should be commented
    case "$platform" in
        wsl)
            # WSL: shell section should NOT be commented

            if [ "$is_commented" = "true" ]; then
                info "WSL platform: shell section should be uncommented - fixing..."
                backup_file "$alacritty_config"
                
                # Uncomment the shell section for WSL
                sed -i 's/^#\[shell\]/[shell]/' "$alacritty_config"
                sed -i 's/^#program = "wsl\.exe/program = "wsl.exe/' "$alacritty_config"
                

                log "✓ Uncommented shell section for WSL"
            else
                log "✓ WSL platform: shell section already uncommented - correct state"
            fi
            ;;
        mac|arch|linux)
            # Non-WSL: shell section SHOULD be commented
            if [ "$is_commented" = "false" ]; then
                info "Non-WSL platform: shell section should be commented - fixing..."
                backup_file "$alacritty_config"
                

                # Comment out the shell section for non-WSL platforms
                sed -i '/^\[shell\]/s/^/#/' "$alacritty_config"
                sed -i '/^program = "wsl\.exe/s/^/#/' "$alacritty_config"
                
                log "✓ Commented out shell section for non-WSL platform"
            else
                log "✓ Non-WSL platform: shell section already commented - correct state"
            fi
            ;;
    esac
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
                
                # Find all VBS files in zedScript subdirectories and create shortcuts

                find "$zed_script_target" -name "*.vbs" -type f | while read -r vbs_file; do
                    local vbs_name=$(basename "$vbs_file" .vbs)
                    local batch_file="$startup_dir/${vbs_name}.bat"
                    
                    # Convert WSL path to Windows path

                    local windows_vbs_path=$(echo "$vbs_file" | sed 's|/mnt/c/|C:/|' | sed 's|/|\\|g')
                    
                    echo "@echo off" > "$batch_file"
                    echo "cscript.exe \"$windows_vbs_path\"" >> "$batch_file"
                    
                    log "Created startup script: $batch_file"
                done
            else
                warn "Startup directory not found: $startup_dir"
            fi

        else
            warn "zedScript directory not found in dotfiles"
        fi
        
        # Handle Alacritty configuration for WSL (copy to Windows)
        handle_alacritty_wsl_copy
    else
        log "Not on WSL, skipping Windows-specific setup"
    fi
}

# Handle Alacritty configuration copy for WSL
handle_alacritty_wsl_copy() {
    info "Copying Alacritty configuration to Windows..."
    

    local windows_user=$(get_windows_username)
    local target_dir="/mnt/c/Users/$windows_user/AppData/Roaming/Alacritty"
    local target_config="$target_dir/alacritty.toml"
    local dotfiles_config="$DOTFILES_DIR/.config/alacritty/alacritty.toml"

    
    log "Target directory for Windows: $target_dir"
    
    # Check if Windows user directory exists
    if [ ! -d "/mnt/c/Users/$windows_user" ]; then

        error "Windows user directory not found: /mnt/c/Users/$windows_user"
        error "Make sure Windows drive is mounted and user exists"
        return 1
    fi
    
    # Create AppData structure if it doesn't exist
    local windows_appdata="/mnt/c/Users/$windows_user/AppData"
    if [ ! -d "$windows_appdata" ]; then
        warn "AppData directory not found, creating: $windows_appdata"
        mkdir -p "$windows_appdata" || {
            error "Failed to create AppData directory: $windows_appdata"
            return 1

        }
    fi
    
    # Create Roaming directory if it doesn't exist
    if [ ! -d "$windows_appdata/Roaming" ]; then
        log "Creating Roaming directory: $windows_appdata/Roaming"
        mkdir -p "$windows_appdata/Roaming" || {
            error "Failed to create Roaming directory: $windows_appdata/Roaming"
            return 1
        }
    fi
    
    # Create Alacritty directory if it doesn't exist
    if [ ! -d "$target_dir" ]; then
        log "Creating Alacritty directory: $target_dir"
        mkdir -p "$target_dir" || {

            error "Failed to create Alacritty directory: $target_dir"
            return 1
        }
    else
        log "Alacritty directory already exists: $target_dir"
    fi
    
    # Backup existing Windows config if it exists
    if [ -f "$target_config" ]; then
        backup_file "$target_config"
    fi
    
    # Copy dotfiles config to Windows
    if [ -f "$dotfiles_config" ]; then
        log "Copying Alacritty config from dotfiles to Windows..."
        cp "$dotfiles_config" "$target_config" || {
            error "Failed to copy Alacritty config to Windows"
            return 1
        }
        log "Alacritty config copied successfully to Windows"
        
        # Provide installation hint
        info "Alacritty config ready for Windows. Install Alacritty on Windows if not already installed:"
        echo "  - Download from: https://github.com/alacritty/alacritty/releases"
        echo "  - Or use winget: winget install Alacritty.Alacritty"

    else
        warn "No Alacritty config found in dotfiles"
        return 1
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

# Function to install packages based on platform
install_missing_packages() {
    local platform="$1"
    
    info "Checking and installing missing packages..."
    
    # Check for tmux
    if ! command -v tmux >/dev/null 2>&1; then
        log "tmux not found, attempting to install..."
        case "$platform" in
            wsl|arch)
                if command -v pacman >/dev/null 2>&1; then
                    sudo pacman -S --noconfirm tmux || warn "Failed to install tmux via pacman"
                elif command -v apt >/dev/null 2>&1; then
                    sudo apt update && sudo apt install -y tmux || warn "Failed to install tmux via apt"
                else
                    warn "No supported package manager found for tmux installation"
                fi
                ;;

            mac)
                if command -v brew >/dev/null 2>&1; then
                    brew install tmux || warn "Failed to install tmux via brew"
                else

                    warn "Homebrew not found, please install tmux manually: brew install tmux"
                fi
                ;;
        esac
    else
        log "✓ tmux is already installed"
    fi
    
    # Check for zsh
    if ! command -v zsh >/dev/null 2>&1; then
        log "zsh not found, attempting to install..."
        case "$platform" in
            wsl|arch)
                if command -v pacman >/dev/null 2>&1; then
                    sudo pacman -S --noconfirm zsh || warn "Failed to install zsh via pacman"
                elif command -v apt >/dev/null 2>&1; then
                    sudo apt update && sudo apt install -y zsh || warn "Failed to install zsh via apt"
                else
                    warn "No supported package manager found for zsh installation"
                fi
                ;;
            mac)
                log "✓ zsh should be available on macOS by default"
                ;;
        esac
    else
        log "✓ zsh is already installed"
    fi
}

# Step 6: Source configuration files with proper error handling
source_configs() {
    local platform="$1"
    
    info "Sourcing configuration files..."
    
    # Function to safely source a file with better error handling
    safe_source() {
        local file="$1"
        local description="$2"
        local critical="${3:-false}"
        
        if [ -f "$file" ]; then
            log "Attempting to source $description: $file"
            
            # Test the file syntax first

            if bash -n "$file" 2>/dev/null; then
                # Syntax is OK, try to source it
                if source "$file" 2>/dev/null; then

                    log "✓ Successfully sourced $description"
                    return 0
                else
                    if [ "$critical" = "true" ]; then
                        error "Critical failure sourcing $description - this may cause issues"
                    else
                        warn "Failed to source $description, but file will be available for next session"
                    fi

                    return 1
                fi
            else
                error "Syntax error in $description - please check the file"
                return 1
            fi
        else
            if [ "$critical" = "true" ]; then
                warn "$description not found: $file (this is expected after first run)"
            else
                log "$description not found: $file"
            fi
            return 1
        fi
    }
    
    # Source shell configurations based on current shell and available shells

    if [ -n "${ZSH_VERSION:-}" ]; then
        # We're in zsh
        safe_source "$HOME/.zshrc" "zsh configuration" "true"
    elif [ -n "${BASH_VERSION:-}" ]; then
        # We're in bash
        safe_source "$HOME/.bashrc" "bash configuration" "true"
    else
        # Unknown shell, try both
        log "Unknown shell environment, will try available configs"
        safe_source "$HOME/.bashrc" "bash configuration"

        if command -v zsh >/dev/null 2>&1; then
            log "zsh available but not current shell - configs will load when switching to zsh"
        fi
    fi
    
    # Source additional shell configurations (these are usually safe to source from any shell)
    safe_source "$HOME/.profile" "shell profile"

    safe_source "$HOME/.aliases" "shell aliases" 
    safe_source "$HOME/.functions" "shell functions"
    
    # Handle tmux configuration with proper installation and session management
    handle_tmux_config "$platform"
    
    # Check for editor configurations (these can't be sourced but we can verify they exist)
    check_editor_configs
}

# Handle tmux configuration properly
handle_tmux_config() {
    local platform="$1"
    
    if [ -f "$HOME/.tmux.conf" ]; then
        if command -v tmux >/dev/null 2>&1; then
            # Check if we're inside tmux

            if [ -n "${TMUX:-}" ]; then
                log "Inside tmux session - reloading configuration..."

                if tmux source-file "$HOME/.tmux.conf" 2>/dev/null; then
                    log "✓ Successfully reloaded tmux configuration"
                else
                    warn "Failed to reload tmux config in current session"
                fi
            else
                # Not in tmux, but tmux is available
                log "tmux available but not currently running"

                info "To test tmux config, run: tmux new-session -d 'tmux source-file ~/.tmux.conf && sleep 1' && tmux kill-server"
                
                # Test if config is valid

                if tmux -f "$HOME/.tmux.conf" list-sessions 2>/dev/null >/dev/null; then
                    log "✓ tmux configuration syntax appears valid"
                else
                    warn "tmux configuration may have syntax errors"
                fi
            fi
        else
            warn "tmux configuration found but tmux not installed"

            info "Install tmux to use the configuration:"

            case "$platform" in
                wsl|arch)
                    echo "  - Arch: sudo pacman -S tmux"
                    echo "  - Ubuntu/Debian: sudo apt install tmux"
                    ;;
                mac)
                    echo "  - macOS: brew install tmux"
                    ;;
            esac
        fi
    else
        log "No tmux configuration found"
    fi
}

# Check editor configurations
check_editor_configs() {
    local configs_to_check=(
        "$HOME/.vimrc:vim configuration"
        "$HOME/.config/nvim/init.lua:neovim configuration"
        "$HOME/.config/nvim/init.vim:neovim configuration (vim format)"
    )
    
    local found_configs=0
    for config_info in "${configs_to_check[@]}"; do
        local config_file="${config_info%%:*}"
        local config_desc="${config_info##*:}"
        
        if [ -f "$config_file" ]; then
            log "✓ Found $config_desc: $config_file"
            ((found_configs++))
        fi
    done
    
    if [ $found_configs -eq 0 ]; then
        log "No editor configurations found (this is normal if you don't use vim/neovim)"

    fi
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

    
    # Step 1: Recognize platform (only call once)
    local platform=$(recognize_platform)

    
    echo "=================================="
    
    # Step 2: Install missing packages
    install_missing_packages "$platform"
    
    echo "=================================="
    
    # Step 3: Check and modify Alacritty config based on platform
    info "Handling Alacritty configuration..."
    modify_dotfiles_alacritty_config "$platform"
    
    echo "=================================="
    
    # Step 4 & 5: Handle WSL-specific logic (including Windows Alacritty copy)
    handle_wsl_specific "$platform"
    
    echo "=================================="
    
    # Step 6: Run smart-stow
    run_smart_stow "$platform"
    
    echo "=================================="
    
    # Step 7: Source configuration files
    source_configs "$platform"
    

    echo "=================================="
    log "Setup complete!"
    log "Platform: $platform"
    
    # Final instructions
    info "Next steps:"

    echo "  1. Restart your shell or run: exec \$SHELL"
    echo "  2. For zsh users: source ~/.zshrc"
    echo "  3. If using tmux, restart tmux or run: tmux source-file ~/.tmux.conf"
    
    case "$platform" in
        arch)

            echo "  4. Restart i3 to load new configs: \$mod+Shift+r"

            ;;
        wsl)
            echo "  4. Check Windows startup folder for VBS script shortcuts"

            echo "  5. VBS scripts found in subdirectories will be executed at Windows startup"

            echo "  6. Alacritty config copied to Windows AppData/Roaming/Alacritty/"

            ;;
        mac)
            echo "  4. You may need to restart Terminal.app for all changes to take effect"
            ;;
    esac
    
    info "Current shell: $SHELL"
    if command -v zsh >/dev/null 2>&1; then
        info "zsh is available - recommended to switch if not already using it"

    fi
}

# Run main function
main "$@"
