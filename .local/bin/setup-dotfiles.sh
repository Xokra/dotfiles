#!/bin/bash

# Enhanced setup-dotfiles.sh - Fixed Version
# Comprehensive dotfiles setup script for WSL, Mac, and Arch Linux
# Fixes: modify-then-stow problem, Alacritty regex, one-time auto-tmux, error handling

set -euo pipefail


# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"
SETUP_FLAG_FILE="$HOME/.config/.dotfiles-first-run"

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


# Function to check if file is a symlink (to prevent modifying source)
is_symlink() {
    [ -L "$1" ]

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


# Step 1: Platform Recognition with validation
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

# Function to validate required commands
validate_prerequisites() {

    local missing_commands=()
    
    for cmd in stow git; do

        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_commands+=("$cmd")
        fi
    done
    
    if [ ${#missing_commands[@]} -gt 0 ]; then
        error "Missing required commands: ${missing_commands[*]}"
        error "Please install these packages before running the script"
        exit 1
    fi

    
    log "✓ All prerequisites satisfied"
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

# CRITICAL FIX: Modify Alacritty config BEFORE stow to prevent source modification
modify_dotfiles_alacritty_config() {
    local platform="$1"
    local alacritty_config="$DOTFILES_DIR/.config/alacritty/alacritty.toml"
    
    info "Checking Alacritty configuration for platform: $platform"
    
    if [ ! -f "$alacritty_config" ]; then
        warn "Alacritty config not found: $alacritty_config"
        return 1
    fi

    
    # CRITICAL: Check if file is already a symlink - don't modify!

    if is_symlink "$alacritty_config"; then
        warn "Alacritty config is already a symlink - skipping modification to prevent source corruption"
        log "If you need to change platform settings, run this script on a fresh clone"
        return 0
    fi
    
    # Check if shell section exists (commented or uncommented)
    # Fixed regex: handles whitespace and quotes properly
    if ! grep -q "^\s*\[shell\]\|^\s*#\s*\[shell\]" "$alacritty_config"; then
        log "No shell section found in Alacritty config - nothing to modify"
        return 0
    fi
    
    backup_file "$alacritty_config"
    
    case "$platform" in
        wsl)
            # WSL: shell section should NOT be commented
            info "WSL platform: Ensuring shell section is uncommented..."
            
            # Uncomment [shell] line - handle various whitespace patterns
            sed -i 's/^\s*#\s*\(\[shell\]\)/\1/' "$alacritty_config"
            
            # Uncomment program line - handle quotes and whitespace
            sed -i 's/^\s*#\s*\(program\s*=.*\)/\1/' "$alacritty_config"
            
            # Verify the change worked
            if grep -q "^\s*\[shell\]" "$alacritty_config" && grep -q "^\s*program\s*=" "$alacritty_config"; then
                log "✓ Shell section uncommented for WSL"
            else
                warn "Shell section may already be uncommented or pattern didn't match"
            fi
            ;;

        mac|arch|linux)
            # Non-WSL: shell section SHOULD be commented
            info "Non-WSL platform: Ensuring shell section is commented..."
            
            # Comment [shell] line if not already commented
            sed -i 's/^\s*\(\[shell\]\)/#\1/' "$alacritty_config"
            
            # Comment program line if not already commented  
            sed -i 's/^\s*\(program\s*=.*\)/#\1/' "$alacritty_config"
            
            # Verify the change worked
            if grep -q "^\s*#.*\[shell\]" "$alacritty_config" && grep -q "^\s*#.*program\s*=" "$alacritty_config"; then
                log "✓ Shell section commented for non-WSL platform"
            else
                warn "Shell section may already be commented or pattern didn't match"

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
            
            if ! sudo mkdir -p "$zed_script_target" 2>/dev/null; then
                mkdir -p "$zed_script_target" 2>/dev/null || {
                    error "Failed to create zedScript directory"
                    return 1
                }
            fi
            
            if cp -r "$DOTFILES_DIR/zedScript/"* "$zed_script_target/"; then
                log "zedScript copied successfully"

            else
                error "Failed to copy zedScript"
                return 1
            fi
            
            # Create shell:startup shortcuts for VBS files

            local startup_dir="/mnt/c/Users/$windows_user/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
            
            if [ -d "$startup_dir" ]; then
                log "Creating startup shortcuts for VBS files..."
                
                find "$zed_script_target" -name "*.vbs" -type f | while read -r vbs_file; do

                    local vbs_name=$(basename "$vbs_file" .vbs)
                    local batch_file="$startup_dir/${vbs_name}.bat"
                    local windows_vbs_path=$(echo "$vbs_file" | sed 's|/mnt/c/|C:/|' | sed 's|/|\\|g')
                    
                    {
                        echo "@echo off"
                        echo "cscript.exe \"$windows_vbs_path\""
                    } > "$batch_file"
                    
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
        if cp "$dotfiles_config" "$target_config"; then
            log "Alacritty config copied successfully to Windows"
            
            info "Alacritty config ready for Windows. Install Alacritty on Windows if not already installed:"
            echo "  - Download from: https://github.com/alacritty/alacritty/releases"
            echo "  - Or use winget: winget install Alacritty.Alacritty"

        else
            error "Failed to copy Alacritty config to Windows"
            return 1
        fi
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
        
        if git clone https://github.com/tmux-plugins/tpm "$tpm_dir"; then
            log "✓ TPM installed successfully"
        else
            error "Failed to install TPM"
            return 1
        fi
    else
        log "✓ TPM already installed"
    fi
}

# Run smart-stow based on platform
run_smart_stow() {
    local platform="$1"
    
    info "Running smart-stow for platform: $platform"
    
    cd "$DOTFILES_DIR" || {
        error "Cannot change to dotfiles directory: $DOTFILES_DIR"
        exit 1
    }
    
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


# FIXED: One-time auto-tmux setup with flag system
setup_one_time_auto_tmux() {
    local shell_config=""
    
    # Determine which shell config to modify
    if command -v zsh >/dev/null 2>&1; then
        shell_config="$HOME/.zshrc"
    else
        shell_config="$HOME/.bashrc"
    fi
    
    if [ ! -f "$shell_config" ]; then
        warn "Shell config file not found: $shell_config"
        return 1

    fi
    

    # Check if one-time auto-tmux is already set up

    if ! grep -q "# One-time dotfiles setup auto-tmux" "$shell_config"; then

        info "Setting up one-time auto-tmux for first restart..."
        
        # Create the setup flag directory

        mkdir -p "$(dirname "$SETUP_FLAG_FILE")"
        
        # Create the flag file to indicate first run needed
        touch "$SETUP_FLAG_FILE"
        
        cat >> "$shell_config" << 'EOF'

# One-time dotfiles setup auto-tmux
if [ -f "$HOME/.config/.dotfiles-first-run" ] && command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    echo "🚀 First-time dotfiles setup detected - starting tmux with plugin installation..."
    

    # Remove the flag file first
    rm -f "$HOME/.config/.dotfiles-first-run"
    
    # Start tmux session and install TPM plugins
    if tmux new-session -d -s setup 2>/dev/null; then
        # Install TPM plugins in the background
        if [ -d "$HOME/.tmux/plugins/tpm" ] && [ -f "$HOME/.tmux.conf" ]; then
            tmux send-keys -t setup 'echo "Installing tmux plugins..." && ~/.tmux/plugins/tpm/scripts/install_plugins.sh && echo "✓ Plugins installed successfully!"' C-m
        fi
        
        # Attach to the session
        echo "Attaching to setup session..."
        tmux attach-session -t setup
    else
        # Fallback: attach to existing session or create new one
        tmux attach-session -t main 2>/dev/null || tmux new-session -s main
    fi
fi
EOF
        log "✓ One-time auto-tmux setup complete"
        log "After restarting your shell, tmux will auto-start once with plugin installation"
    else
        log "✓ One-time auto-tmux already configured"
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
    
    # Step 0: Validate prerequisites
    validate_prerequisites
    echo "=================================="

    
    # Step 1: Recognize platform
    local platform=$(recognize_platform)
    echo "=================================="
    
    # Step 2: Install TPM before any config modifications
    install_tpm
    echo "=================================="
    
    # Step 3: CRITICAL FIX - Modify Alacritty config BEFORE stow
    info "Handling Alacritty configuration (before stow)..."
    modify_dotfiles_alacritty_config "$platform"
    echo "=================================="
    
    # Step 4: Handle WSL-specific logic (before stow)
    handle_wsl_specific "$platform"
    echo "=================================="
    
    # Step 5: Run smart-stow (after all modifications)
    run_smart_stow "$platform"
    echo "=================================="
    

    # Step 6: Setup one-time auto-tmux (after stow, so configs are linked)
    setup_one_time_auto_tmux
    echo "=================================="

    
    # Step 7: Source configuration files
    source_configs "$platform"
    echo "=================================="
    
    log "Setup complete!"
    log "Platform: $platform"
    

    info "Next steps:"
    echo "  1. Restart your shell or run: exec \$SHELL"
    echo "  2. First terminal after restart will auto-start tmux and install plugins"
    echo "  3. Subsequent terminals will behave normally"
    
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

    
    if [ -f "$SETUP_FLAG_FILE" ]; then
        info "🚀 One-time setup flag created - next shell restart will trigger tmux setup"
    fi
}

# Run main function
main "$@"
