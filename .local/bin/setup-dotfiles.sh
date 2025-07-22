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
    
    backup_file "$alacritty_config"
    
    case "$platform" in
        wsl)
            # WSL: Uncomment shell section
            if grep -q "^#\[shell\]" "$alacritty_config" || grep -q "^#program.*wsl\.exe" "$alacritty_config"; then
                info "WSL platform: Uncommenting shell section..."
                sed -i 's/^#\[shell\]/[shell]/' "$alacritty_config"
                sed -i 's/^#program = "\(.*wsl\.exe.*\)"/program = "\1"/' "$alacritty_config"
                log "✓ Uncommented shell section for WSL"
            else
                log "✓ WSL platform: Shell section already properly configured"
            fi
            ;;
        mac|arch|linux)
            # Non-WSL: Comment shell section
            if grep -q "^\[shell\]" "$alacritty_config" || grep -q "^program.*wsl\.exe" "$alacritty_config"; then
                info "Non-WSL platform: Commenting shell section..."
                sed -i '/^\[shell\]/s/^/#/' "$alacritty_config"
                sed -i '/^program.*wsl\.exe/s/^/#/' "$alacritty_config"
                log "✓ Commented shell section for non-WSL platform"
            else
                log "✓ Non-WSL platform: Shell section already properly commented"
            fi
            ;;
    esac

}


# WSL-specific logic
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
    
    # Create directory structure
    mkdir -p "$target_dir" || {
        error "Failed to create Alacritty directory: $target_dir"
        return 1
    }
    
    # Backup and copy config
    if [ -f "$target_config" ]; then
        backup_file "$target_config"
    fi
    
    if [ -f "$dotfiles_config" ]; then
        cp "$dotfiles_config" "$target_config"

        log "Alacritty config copied successfully to Windows"
        info "Install Alacritty on Windows: winget install Alacritty.Alacritty"
    else
        warn "No Alacritty config found in dotfiles"
    fi
}

# Install TPM (Tmux Plugin Manager)
install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    

    info "Installing TPM (Tmux Plugin Manager)..."

    
    if [ -d "$tmp_dir" ]; then
        log "TPM already exists, updating..."
        cd "$tpm_dir" && git pull
    else
        log "Cloning TPM..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
    
    log "✓ TPM installed/updated successfully"
}

# Run smart-stow based on platform

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

# Install missing packages
install_missing_packages() {
    local platform="$1"
    
    info "Checking and installing missing packages..."
    

    # Install tmux
    if ! command -v tmux >/dev/null 2>&1; then
        log "Installing tmux..."
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
                    warn "Install Homebrew first, then: brew install tmux"
                fi
                ;;
        esac
    else

        log "✓ tmux already installed"
    fi
    
    # Install zsh
    if ! command -v zsh >/dev/null 2>&1; then
        log "Installing zsh..."
        case "$platform" in
            wsl|arch)
                if command -v pacman >/dev/null 2>&1; then
                    sudo pacman -S --noconfirm zsh
                elif command -v apt >/dev/null 2>&1; then
                    sudo apt update && sudo apt install -y zsh
                fi
                ;;
            mac)
                log "✓ zsh available on macOS by default"
                ;;

        esac
    else
        log "✓ zsh already installed"
    fi
}

# Setup auto-tmux for new terminals
setup_auto_tmux() {

    local platform="$1"
    
    info "Setting up auto-tmux for new terminals..."
    
    local auto_tmux_script='
# Auto-start tmux and install plugins

if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ] && [ -t 0 ]; then
    # Install TPM plugins if tmux config exists
    if [ -f ~/.tmux.conf ] && [ -d ~/.tmux/plugins/tpm ]; then
        tmux new-session -d -s auto_setup "~/.tmux/plugins/tpm/scripts/install_plugins.sh" \; kill-session -t auto_setup 2>/dev/null || true
    fi
    
    # Start tmux session

    if ! tmux has-session -t main 2>/dev/null; then

        tmux new-session -d -s main
    fi
    exec tmux attach-session -t main
fi'
    
    # Add to .zshrc if it exists

    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -q "Auto-start tmux" "$HOME/.zshrc"; then
            echo "$auto_tmux_script" >> "$HOME/.zshrc"
            log "Added auto-tmux to .zshrc"
        fi
    fi
    
    # Add to .bashrc as fallback
    if [ -f "$HOME/.bashrc" ]; then
        if ! grep -q "Auto-start tmux" "$HOME/.bashrc"; then
            echo "$auto_tmux_script" >> "$HOME/.bashrc"
            log "Added auto-tmux to .bashrc"

        fi
    fi
}

# Source configuration files
source_configs() {

    local platform="$1"
    
    info "Sourcing configuration files..."
    
    # Source shell configs
    if [ -n "${ZSH_VERSION:-}" ] && [ -f "$HOME/.zshrc" ]; then
        source "$HOME/.zshrc" 2>/dev/null && log "✓ Sourced .zshrc" || warn "Failed to source .zshrc"

    elif [ -n "${BASH_VERSION:-}" ] && [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc" 2>/dev/null && log "✓ Sourced .bashrc" || warn "Failed to source .bashrc"
    fi
    
    # Handle tmux configuration
    if [ -f "$HOME/.tmux.conf" ] && command -v tmux >/dev/null 2>&1; then
        if [ -n "${TMUX:-}" ]; then
            tmux source-file "$HOME/.tmux.conf" 2>/dev/null && log "✓ Reloaded tmux config"
        else
            log "✓ tmux config ready for next session"
        fi
    fi
}

# Main execution function
main() {
    info "Starting enhanced dotfiles setup..."
    echo "=================================="
    
    # Check dotfiles directory
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
    
    # Step 3: Install TPM before modifying configs
    install_tpm
    echo "=================================="
    
    # Step 4: Check and modify Alacritty config
    modify_dotfiles_alacritty_config "$platform"
    echo "=================================="

    
    # Step 5: Handle WSL-specific logic

    handle_wsl_specific "$platform"
    echo "=================================="
    
    # Step 6: Run smart-stow
    run_smart_stow "$platform"
    echo "=================================="
    
    # Step 7: Setup auto-tmux
    setup_auto_tmux "$platform"
    echo "=================================="
    
    # Step 8: Source configs
    source_configs "$platform"
    echo "=================================="
    
    log "Setup complete!"
    log "Platform: $platform"

    
    info "Next steps:"
    echo "  1. Restart your shell: exec \$SHELL"
    echo "  2. New terminals will auto-start tmux with plugins installed"

    
    case "$platform" in
        arch)
            echo "  3. Restart i3: \$mod+Shift+r"
            ;;
        wsl)
            echo "  3. VBS scripts ready for Windows startup"

            ;;
    esac
}

# Run main function
main "$@"
