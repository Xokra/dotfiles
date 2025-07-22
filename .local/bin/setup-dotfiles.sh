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

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

error() { echo -e "${RED}[ERROR]${NC} $1"; }
info() { echo -e "${BLUE}[SETUP]${NC} $1"; }


# Function to detect operating system platform
detect_platform() {
    local uname_output=$(uname -s)
    case "$uname_output" in
        Linux*)
            if uname -r | grep -q -i microsoft || uname -r | grep -q -i wsl; then
                echo "wsl"
            elif [ -f /etc/arch-release ]; then
                echo "arch"
            else
                echo "linux"
            fi
            ;;
        Darwin*) echo "mac" ;;
        *) echo "unknown" ;;
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
        wsl) log "Running on WSL (Ubuntu)" ;;
        mac) log "Running on macOS" ;;
        arch) log "Running on Arch Linux (i3)" ;;
        *) error "Unsupported platform: $platform"; exit 1 ;;
    esac
    

    echo "$platform"
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


# FIXED: Function to modify dotfiles Alacritty config based on platform
modify_dotfiles_alacritty_config() {

    local platform="$1"
    local alacritty_config="$DOTFILES_DIR/.config/alacritty/alacritty.toml"
    
    info "Checking Alacritty configuration for platform: $platform"
    
    if [ ! -f "$alacritty_config" ]; then
        warn "Alacritty config not found: $alacritty_config"
        return 1
    fi
    
    # Check if shell section exists
    if ! grep -q "^\[shell\]\|^#\[shell\]" "$alacritty_config"; then

        log "No shell section found in Alacritty config - nothing to modify"
        return 0
    fi
    
    backup_file "$alacritty_config"
    

    case "$platform" in
        wsl)
            # WSL: shell section should NOT be commented

            if grep -q "^#\[shell\]" "$alacritty_config"; then
                info "WSL platform: Uncommenting shell section..."
                sed -i '/^#\[shell\]/,/^#program = / { s/^#//; }' "$alacritty_config"
                log "✓ Shell section uncommented for WSL"
            else
                log "✓ WSL platform: shell section already active"
            fi
            ;;
        mac|arch|linux)

            # Non-WSL: shell section SHOULD be commented
            if grep -q "^\[shell\]" "$alacritty_config"; then
                info "Non-WSL platform: Commenting shell section..."
                sed -i '/^\[shell\]/,/^program = / { s/^/#/; }' "$alacritty_config"
                log "✓ Shell section commented for non-WSL platform"
            else
                log "✓ Non-WSL platform: shell section already commented"

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
            sudo mkdir -p "$zed_script_target" 2>/dev/null || mkdir -p "$zed_script_target"
            cp -r "$DOTFILES_DIR/zedScript/"* "$zed_script_target/"
            log "zedScript copied successfully"
            
            # Create shell:startup shortcuts for VBS files
            local startup_dir="/mnt/c/Users/$windows_user/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
            
            if [ -d "$startup_dir" ]; then
                log "Creating startup shortcuts for VBS files..."

                find "$zed_script_target" -name "*.vbs" -type f | while read -r vbs_file; do
                    local vbs_name=$(basename "$vbs_file" .vbs)
                    local batch_file="$startup_dir/${vbs_name}.bat"
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
    
    if [ ! -d "/mnt/c/Users/$windows_user" ]; then

        error "Windows user directory not found: /mnt/c/Users/$windows_user"
        return 1
    fi
    
    mkdir -p "$target_dir"
    
    if [ -f "$target_config" ]; then
        backup_file "$target_config"

    fi
    

    if [ -f "$dotfiles_config" ]; then
        log "Copying Alacritty config from dotfiles to Windows..."
        cp "$dotfiles_config" "$target_config"

        log "Alacritty config copied successfully to Windows"
        
        info "Alacritty config ready for Windows. Install Alacritty on Windows if not already installed:"
        echo "  - Download from: https://github.com/alacritty/alacritty/releases"
        echo "  - Or use winget: winget install Alacritty.Alacritty"
    else
        warn "No Alacritty config found in dotfiles"
        return 1
    fi
}


# Install TPM (Tmux Plugin Manager)
install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    
    if [ ! -d "$tpm_dir" ]; then
        info "Installing TPM (Tmux Plugin Manager)..."
        
        if command -v git >/dev/null 2>&1; then
            git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
            log "✓ TPM installed successfully"
        else
            error "Git not found - cannot install TPM"
            return 1
        fi
    else
        log "✓ TPM already installed"
    fi
}

# FIXED: Install TPM plugins with better error handling
install_tpm_plugins() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    

    if [ -d "$tpm_dir" ] && [ -f "$HOME/.tmux.conf" ]; then
        info "Installing TPM plugins..."
        
        # Check if tmux is running and kill sessions to avoid conflicts
        if pgrep tmux >/dev/null; then
            warn "Tmux sessions detected, stopping them for plugin installation"
            tmux kill-server 2>/dev/null || true
        fi
        
        # Run TPM install script
        if "$tpm_dir/scripts/install_plugins.sh" 2>/dev/null; then
            log "✓ TPM plugins installed successfully"
        else
            warn "TPM plugin installation had some issues, but will work on next tmux start"
        fi
    else
        warn "TPM not installed or .tmux.conf not found - skipping plugin installation"
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
    
    # Check for git first (needed for TPM)

    if ! command -v git >/dev/null 2>&1; then
        log "git not found, attempting to install..."
        case "$platform" in
            wsl|arch)
                if command -v pacman >/dev/null 2>&1; then
                    sudo pacman -S --noconfirm git
                elif command -v apt >/dev/null 2>&1; then
                    sudo apt update && sudo apt install -y git
                fi
                ;;
            mac)
                if command -v brew >/dev/null 2>&1; then
                    brew install git
                else
                    warn "Please install git manually"
                fi
                ;;
        esac

    else
        log "✓ git is already installed"

    fi
    

    # Check for tmux
    if ! command -v tmux >/dev/null 2>&1; then
        log "tmux not found, attempting to install..."
        case "$platform" in
            wsl|arch)
                if command -v pacman >/dev/null 2>&1; then
                    sudo pacman -S --noconfirm tmux
                elif command -v apt >/dev/null 2>&1; then
                    sudo apt update && sudo apt install -y tmux
                fi
                ;;

            mac)
                if command -v brew >/dev/null 2>&1; then
                    brew install tmux
                else
                    warn "Homebrew not found, please install tmux manually"
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
                    sudo pacman -S --noconfirm zsh
                elif command -v apt >/dev/null 2>&1; then
                    sudo apt update && sudo apt install -y zsh
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
    
    safe_source() {
        local file="$1"
        local description="$2"
        
        if [ -f "$file" ]; then
            if source "$file" 2>/dev/null; then
                log "✓ Successfully sourced $description"
                return 0

            else
                warn "Failed to source $description, but file will be available for next session"
                return 1
            fi
        else
            log "$description not found: $file"
            return 1
        fi
    }
    
    # Source shell configurations
    if [ -n "${ZSH_VERSION:-}" ]; then
        safe_source "$HOME/.zshrc" "zsh configuration"
    elif [ -n "${BASH_VERSION:-}" ]; then
        safe_source "$HOME/.bashrc" "bash configuration"
    fi

    
    safe_source "$HOME/.profile" "shell profile"
    safe_source "$HOME/.aliases" "shell aliases" 
    safe_source "$HOME/.functions" "shell functions"
}

# NEW: Setup one-time auto-tmux for initial setup
setup_one_time_tmux() {
    local shell_config=""
    local setup_flag="$HOME/.dotfiles_initial_setup"
    
    # Determine which shell config to modify
    if command -v zsh >/dev/null 2>&1; then
        shell_config="$HOME/.zshrc"
    else
        shell_config="$HOME/.bashrc"
    fi
    
    if [ -f "$shell_config" ]; then

        info "Setting up one-time auto-tmux for initial setup..."
        
        # Remove any existing auto-tmux setup
        sed -i '/# Auto-start tmux/,/^fi$/d' "$shell_config" 2>/dev/null || true
        
        # Create setup flag
        touch "$setup_flag"
        
        cat >> "$shell_config" << 'EOF'

# One-time auto-start tmux with TPM plugin installation
if [ -f "$HOME/.dotfiles_initial_setup" ] && command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    echo "🚀 Starting tmux and installing plugins (one-time setup)..."
    
    # Remove the setup flag so this only runs once
    rm -f "$HOME/.dotfiles_initial_setup"
    
    # Start tmux and install plugins
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        tmux new-session -d -s setup 2>/dev/null || tmux new-session -d -s setup
        tmux send-keys -t setup 'source ~/.zshrc 2>/dev/null || source ~/.bashrc' C-m
        tmux send-keys -t setup '~/.tmux/plugins/tpm/scripts/install_plugins.sh' C-m
        tmux send-keys -t setup 'echo "✅ TPM plugins installed! Press any key to continue..."' C-m
        tmux send-keys -t setup 'read -n 1' C-m
        tmux attach-session -t setup
    else
        tmux new-session
    fi
fi
EOF
        log "✓ One-time auto-tmux setup complete"
    fi
}


# Main execution function
main() {
    info "Starting enhanced dotfiles setup..."
    echo "=================================="
    
    if [ ! -d "$DOTFILES_DIR" ]; then
        error "Dotfiles directory not found: $DOTFILES_DIR"
        exit 1
    fi
    
    # Step 1: Recognize platform
    local platform=$(recognize_platform)
    echo "=================================="
    
    # Step 2: Install missing packages

    install_missing_packages "$platform"

    echo "=================================="
    
    # Step 3: Install TPM before stow

    install_tpm
    echo "=================================="
    
    # Step 4: Check and modify Alacritty config BEFORE stowing

    info "Handling Alacritty configuration..."
    modify_dotfiles_alacritty_config "$platform"
    echo "=================================="

    
    # Step 5: Handle WSL-specific logic

    handle_wsl_specific "$platform"
    echo "=================================="
    
    # Step 6: Run smart-stow (this links all configs)
    run_smart_stow "$platform"

    echo "=================================="
    
    # Step 7: Install TPM plugins AFTER configs are linked
    install_tmp_plugins
    echo "=================================="

    
    # Step 8: Setup one-time auto-tmux
    setup_one_time_tmux
    echo "=================================="
    
    # Step 9: Source configuration files
    source_configs "$platform"
    echo "=================================="

    
    log "Setup complete!"
    log "Platform: $platform"
    
    info "Next steps:"

    echo "  1. Restart your shell or run: exec \$SHELL"
    echo "  2. Next terminal will auto-start tmux and install plugins (one-time only)"
    
    case "$platform" in
        arch) echo "  3. Restart i3 to load new configs: \$mod+Shift+r" ;;
        wsl) echo "  3. Check Windows startup folder for VBS script shortcuts" ;;

        mac) echo "  3. You may need to restart Terminal.app for all changes" ;;

    esac
}


# Run main function
main "$@"
