#!/bin/bash

# Enhanced setup-dotfiles.sh - Fixed Version
# Comprehensive dotfiles setup script for WSL, Mac, and Arch Linux

set -euo pipefail

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"
SETUP_FLAG="$HOME/.dotfiles-setup-flag"

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

# Check if file is a symlink (protection against modifying symlinked files)
is_symlink() {
    [ -L "$1" ]
}

# Validate required commands
validate_requirements() {
    local missing=()
    
    for cmd in stow git; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing+=("$cmd")
        fi
    done
    
    if [ ${#missing[@]} -gt 0 ]; then
        error "Required commands missing: ${missing[*]}"
        error "Please install missing dependencies first"
        exit 1
    fi
    
    log "✓ All required commands available"
}

# Function to modify dotfiles Alacritty config based on platform (BEFORE stow)
modify_dotfiles_alacritty_config() {

    local platform="$1"
    local alacritty_config="$DOTFILES_DIR/.config/alacritty/alacritty.toml"
    
    info "Checking Alacritty configuration for platform: $platform"
    
    if [ ! -f "$alacritty_config" ]; then
        warn "Alacritty config not found: $alacritty_config"
        return 1
    fi
    
    # CRITICAL: Check if this is already a symlink (prevent modifying after stow)
    if is_symlink "$alacritty_config"; then
        warn "Alacritty config is already a symlink - modifications already applied"
        return 0
    fi

    
    # Check if shell section exists (commented or uncommented)
    if ! grep -qE '^\s*(\[shell\]|#\s*\[shell\])' "$alacritty_config"; then
        log "No shell section found in Alacritty config - nothing to modify"
        return 0
    fi
    
    backup_file "$alacritty_config"

    
    case "$platform" in
        wsl)
            # WSL: shell section should NOT be commented
            if grep -qE '^\s*#\s*\[shell\]' "$alacritty_config"; then

                info "WSL platform: Uncommenting shell section..."
                # Uncomment [shell] line
                sed -i 's/^\s*#\s*\[shell\]/[shell]/' "$alacritty_config"
                # Uncomment program line (handles quotes and whitespace)
                sed -i 's/^\s*#\s*program\s*=\s*/program = /' "$alacritty_config"
                log "✓ Shell section uncommented for WSL"
            else
                log "✓ WSL platform: shell section already uncommented"
            fi

            ;;
        mac|arch|linux)
            # Non-WSL: shell section SHOULD be commented
            if grep -qE '^\s*\[shell\]' "$alacritty_config"; then

                info "Non-WSL platform: Commenting shell section..."
                # Comment [shell] line
                sed -i 's/^\s*\[shell\]/#[shell]/' "$alacritty_config"
                # Comment program line (handles quotes and whitespace)
                sed -i 's/^\s*program\s*=\s*/#program = /' "$alacritty_config"
                log "✓ Shell section commented for non-WSL platform"
            else
                log "✓ Non-WSL platform: shell section already commented"
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
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        log "✓ TPM installed successfully"
    else
        log "✓ TPM already installed"
    fi
}

# Run smart-stow based on platform
run_smart_stow() {
    local platform="$1"
    
    info "Running smart-stow for platform: $platform"
    
    cd "$DOTFILES_DIR" || exit 1
    

    if [ -f "$DOTFILES_DIR/.local/bin/smart-stow.sh" ]; then
        log "Executing smart-stow.sh..."
        if "$DOTFILES_DIR/.local/bin/smart-stow.sh"; then
            log "✓ Smart-stow completed successfully"
        else
            error "Smart-stow failed"
            exit 1
        fi
    else
        error "smart-stow.sh not found in $DOTFILES_DIR/.local/bin/"
        exit 1

    fi
}

# Setup one-time auto-tmux with flag system
setup_one_time_auto_tmux() {
    local shell_config=""
    
    # Determine which shell config to modify
    if command -v zsh >/dev/null 2>&1; then
        shell_config="$HOME/.zshrc"
    else

        shell_config="$HOME/.bashrc"
    fi

    
    if [ -f "$shell_config" ]; then
        # Check if one-time auto-tmux is already set up
        if ! grep -q "# One-time dotfiles setup tmux" "$shell_config"; then
            info "Setting up one-time auto-tmux for first restart..."
            
            # Create the setup flag
            touch "$SETUP_FLAG"
            
            cat >> "$shell_config" << 'EOF'


# One-time dotfiles setup tmux (removes itself after first run)
if [ -f "$HOME/.dotfiles-setup-flag" ] && command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    echo "🚀 First-time dotfiles setup: Starting tmux with plugin installation..."
    
    # Remove the flag first
    rm -f "$HOME/.dotfiles-setup-flag"
    
    # Install TPM plugins and start tmux
    if [ -d "$HOME/.tmux/plugins/tpm" ] && [ -f "$HOME/.tmux.conf" ]; then
        # Start detached session, install plugins, then attach
        tmux new-session -d -s main 2>/dev/null || tmux new-session -d -s main -c "$HOME"
        tmux send-keys -t main "~/.tmux/plugins/tpm/scripts/install_plugins.sh" C-m
        sleep 2  # Give plugins time to install
        tmux send-keys -t main "clear" C-m
        echo "✓ TPM plugins installed! Attaching to tmux session..."
        tmux attach-session -t main
    else
        tmux new-session -s main

    fi
fi
EOF
            log "✓ One-time auto-tmux setup complete"
        else
            log "✓ One-time auto-tmux already configured"

        fi
    fi
}

# Source configuration files with proper error handling
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

# Main execution function
main() {

    info "Starting enhanced dotfiles setup..."
    echo "=================================="
    
    if [ ! -d "$DOTFILES_DIR" ]; then
        error "Dotfiles directory not found: $DOTFILES_DIR"
        exit 1
    fi
    
    # Step 1: Validate requirements
    validate_requirements
    echo "=================================="
    
    # Step 2: Recognize platform
    local platform=$(recognize_platform)
    echo "=================================="
    
    # Step 3: Install TPM before any config operations
    install_tpm
    echo "=================================="
    

    # Step 4: CRITICAL - Modify Alacritty config BEFORE stow
    info "Handling Alacritty configuration (BEFORE stow)..."
    modify_dotfiles_alacritty_config "$platform"
    echo "=================================="
    
    # Step 5: Handle WSL-specific logic (before stow for zedScript)
    handle_wsl_specific "$platform"
    echo "=================================="
    
    # Step 6: Run smart-stow (now safe to create symlinks)
    run_smart_stow "$platform"
    echo "=================================="
    
    # Step 7: Setup one-time auto-tmux (after configs are linked)
    setup_one_time_auto_tmux
    echo "=================================="
    
    # Step 8: Source configuration files
    source_configs "$platform"
    echo "=================================="
    

    log "Setup complete!"

    log "Platform: $platform"
    
    info "Next steps:"
    echo "  1. Restart your shell or run: exec \$SHELL"
    echo "  2. First new terminal will auto-start tmux and install plugins (one-time)"
    echo "  3. After first run, tmux behavior returns to normal"
    

    case "$platform" in
        arch)
            echo "  4. Restart i3 to load new configs: \$mod+Shift+r"
            ;;
        wsl)
            echo "  4. Check Windows startup folder for VBS script shortcuts"
            ;;
        mac)
            echo "  4. You may need to restart Terminal.app for all changes"
            ;;
    esac
}

# Run main function
main "$@"
