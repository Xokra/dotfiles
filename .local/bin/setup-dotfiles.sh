#!/bin/bash

# Enhanced setup-dotfiles.sh
# Comprehensive dotfiles setup script for WSL, Mac, and Arch Linux

set -euo pipefail

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

AUTO_TMUX_FLAG="$HOME/.setup_auto_tmux"

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


# Check if file is a symlink and resolve target
get_target_file() {
    local file="$1"
    if [ -L "$file" ]; then
        readlink "$file"
    else
        echo "$file"

    fi
}

# Function to modify Alacritty config based on platform (AFTER stow)
modify_alacritty_config() {
    local platform="$1"
    local alacritty_config="$HOME/.config/alacritty/alacritty.toml"

    
    info "Checking Alacritty configuration for platform: $platform"
    
    if [ ! -f "$alacritty_config" ]; then
        warn "Alacritty config not found: $alacritty_config"

        return 1
    fi
    
    # Get actual file (handle symlinks)
    local target_file=$(get_target_file "$alacritty_config")
    
    # Check if shell section exists
    if ! grep -q "^\[shell\]\|^#\[shell\]" "$target_file"; then
        log "No shell section found in Alacritty config - nothing to modify"
        return 0
    fi
    
    backup_file "$target_file"
    
    case "$platform" in
        wsl)
            # WSL: shell section should NOT be commented
            if grep -q "^#\[shell\]" "$target_file"; then
                info "WSL platform: Uncommenting shell section..."
                sed -i 's/^#\[shell\]/[shell]/' "$target_file"

                sed -i 's/^#program = /program = /' "$target_file"
                log "✓ Shell section uncommented for WSL"
            else
                log "✓ WSL platform: shell section already uncommented"

            fi
            ;;
        mac|arch|linux)
            # Non-WSL: shell section SHOULD be commented
            if grep -q "^\[shell\]" "$target_file"; then

                info "Non-WSL platform: Commenting shell section..."
                sed -i 's/^\[shell\]/#[shell]/' "$target_file"
                sed -i '/^program = .*wsl\.exe/s/^/#/' "$target_file"
                log "✓ Shell section commented for non-WSL platform"
            else
                log "✓ Non-WSL platform: shell section already commented"
            fi
            ;;
    esac
    
    # Verify changes
    if [ "$platform" = "wsl" ]; then
        if grep -q "^\[shell\]" "$target_file"; then
            log "✓ Verification: Shell section properly uncommented for WSL"
        else
            warn "Verification failed: Shell section may not be properly configured"
        fi
    else
        if grep -q "^#\[shell\]" "$target_file"; then
            log "✓ Verification: Shell section properly commented for non-WSL"
        else
            warn "Verification failed: Shell section may not be properly configured"
        fi
    fi
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
    local home_config="$HOME/.config/alacritty/alacritty.toml"
    
    log "Target directory for Windows: $target_dir"
    
    if [ ! -d "/mnt/c/Users/$windows_user" ]; then
        error "Windows user directory not found: /mnt/c/Users/$windows_user"
        return 1
    fi
    
    mkdir -p "$target_dir"
    
    if [ -f "$target_config" ]; then

        backup_file "$target_config"
    fi
    
    if [ -f "$home_config" ]; then
        log "Copying Alacritty config from home to Windows..."
        cp "$home_config" "$target_config"
        log "Alacritty config copied successfully to Windows"
        
        info "Alacritty config ready for Windows. Install Alacritty on Windows if not already installed:"
        echo "  - Download from: https://github.com/alacritty/alacritty/releases"
        echo "  - Or use winget: winget install Alacritty.Alacritty"
    else
        warn "No Alacritty config found in home directory"
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

# Run smart-stow based on platform
run_smart_stow() {
    local platform="$1"
    
    info "Running smart-stow for platform: $platform"
    
    cd "$DOTFILES_DIR" || exit 1
    
    if [ -f "$DOTFILES_DIR/.local/bin/smart-stow.sh" ]; then
        log "Executing smart-stow.sh..."
        "$DOTFILES_DIR/.local/bin/smart-stow.sh"
        
        # Verify stow worked
        if [ -L "$HOME/.tmux.conf" ] || [ -f "$HOME/.tmux.conf" ]; then
            log "✓ Stow verification: Config files successfully linked"
        else
            error "Stow verification failed: Expected config files not found"
            return 1

        fi
    else

        error "smart-stow.sh not found in $DOTFILES_DIR/.local/bin/"
        exit 1
    fi

}

# Function to check dependencies
check_dependencies() {
    local missing=()
    
    for cmd in git stow; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing+=("$cmd")
        fi
    done
    
    if [ ${#missing[@]} -gt 0 ]; then
        error "Missing required commands: ${missing[*]}"
        info "Please install missing dependencies first"
        exit 1
    fi
    
    log "✓ All dependencies available: git, stow"
}

# Detect user's preferred shell
detect_shell() {
    local shell_path="${SHELL:-/bin/bash}"
    local shell_name=$(basename "$shell_path")
    
    case "$shell_name" in
        zsh)
            echo "zsh"
            ;;
        bash)
            echo "bash"
            ;;
        *)
            # Default to bash if unknown
            echo "bash"

            ;;
    esac
}

# Setup one-time auto-tmux for first restart
setup_one_time_auto_tmux() {
    local user_shell=$(detect_shell)
    local shell_config=""
    
    case "$user_shell" in
        zsh)
            shell_config="$HOME/.zshrc"
            ;;

        bash)
            shell_config="$HOME/.bashrc"
            ;;
        *)
            warn "Unknown shell, defaulting to .bashrc"
            shell_config="$HOME/.bashrc"
            ;;
    esac

    
    if [ -f "$shell_config" ]; then
        # Check if auto-tmux is already set up
        if ! grep -q "# One-time auto-tmux setup" "$shell_config"; then
            info "Setting up one-time auto-tmux for first restart..."
            
            cat >> "$shell_config" << 'EOF'

# One-time auto-tmux setup (auto-removes after first run)
if [ -f "$HOME/.setup_auto_tmux" ] && command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    echo "Running one-time tmux setup with TPM plugin installation..."
    
    # Install TPM plugins
    if [ -d "$HOME/.tmux/plugins/tpm" ] && [ -f "$HOME/.tmux.conf" ]; then
        tmux new-session -d -s setup 2>/dev/null || tmux new-session -d -s setup

        sleep 1
        tmux send-keys -t setup 'echo "Installing TPM plugins..."; ~/.tmux/plugins/tpm/scripts/install_plugins.sh; echo "Setup complete! Press any key to continue."; read' C-m
        tmux attach-session -t setup
    else
        tmux new-session -s main
    fi

    
    # Remove the flag file and this setup code
    rm -f "$HOME/.setup_auto_tmux"

    
    # Remove this auto-tmux setup from shell config
    sed -i '/# One-time auto-tmux setup/,/^$/d' "$HOME/.zshrc" 2>/dev/null || true
    sed -i '/# One-time auto-tmux setup/,/^$/d' "$HOME/.bashrc" 2>/dev/null || true
    
    echo "One-time setup completed. Future terminals will work normally."
fi
EOF
            
            # Create the flag file
            touch "$AUTO_TMUX_FLAG"

            
            log "✓ One-time auto-tmux setup complete"
        else
            log "✓ Auto-tmux already configured"
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
    
    # Source shell configurations based on detected shell

    local user_shell=$(detect_shell)
    case "$user_shell" in
        zsh)
            safe_source "$HOME/.zshrc" "zsh configuration"
            ;;
        bash)
            safe_source "$HOME/.bashrc" "bash configuration"
            ;;
    esac
    
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
    
    # Step 1: Check dependencies
    check_dependencies
    echo "=================================="
    

    # Step 2: Recognize platform
    local platform=$(recognize_platform)
    echo "=================================="

    
    # Step 3: Install TPM before stow
    install_tpm
    echo "=================================="
    
    # Step 4: Run smart-stow FIRST

    run_smart_stow "$platform"
    echo "=================================="

    
    # Step 5: Handle Alacritty configuration AFTER stow
    info "Handling Alacritty configuration..."

    modify_alacritty_config "$platform"
    echo "=================================="
    

    # Step 6: Handle WSL-specific logic
    handle_wsl_specific "$platform"
    echo "=================================="
    
    # Step 7: Setup one-time auto-tmux
    setup_one_time_auto_tmux
    echo "=================================="
    
    # Step 8: Source configuration files
    source_configs "$platform"
    echo "=================================="
    
    log "Setup complete!"
    log "Platform: $platform"

    log "User shell: $(detect_shell)"

    
    info "Next steps:"
    echo "  1. Restart your shell or run: exec \$SHELL"

    echo "  2. First terminal after restart will auto-setup tmux with plugins"
    echo "  3. After that, terminals will work normally"
    
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
