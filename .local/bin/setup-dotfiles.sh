#!/bin/bash

# Enhanced setup-dotfiles.sh
# Comprehensive dotfiles setup script for WSL, Mac, and Arch Linux

set -euo pipefail

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"
SETUP_FLAG_FILE="$HOME/.config/dotfiles-setup-flag"

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


# Function to backup file
backup_file() {
    local file="$1"

    if [ -f "$file" ]; then
        local backup_name="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup_name"
        log "Created backup: $backup_name"

    fi
}

# Function to validate critical dependencies
validate_dependencies() {
    local missing_deps=()
    

    if ! command -v git >/dev/null 2>&1; then
        missing_deps+=("git")
    fi
    
    if ! command -v stow >/dev/null 2>&1; then
        missing_deps+=("stow")
    fi
    
    if ! command -v tmux >/dev/null 2>&1; then
        missing_deps+=("tmux")
    fi
    
    if ! command -v zsh >/dev/null 2>&1; then
        missing_deps+=("zsh")
    fi
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        error "Missing required dependencies: ${missing_deps[*]}"
        error "Please install the missing packages and run the script again"
        exit 1
    fi

    
    log "✓ All dependencies validated"
}


# Function to generate platform-specific Alacritty config BEFORE stow
generate_alacritty_config() {
    local platform="$1"
    local template_file="$DOTFILES_DIR/.config/alacritty/alacritty.toml.template"
    local config_file="$DOTFILES_DIR/.config/alacritty/alacritty.toml"
    
    info "Generating platform-specific Alacritty configuration for: $platform"
    

    # Check if template exists
    if [ ! -f "$template_file" ]; then
        # If template doesn't exist but config does, create template from existing config
        if [ -f "$config_file" ]; then
            info "Creating template from existing config..."
            cp "$config_file" "$template_file"
            log "Template created from existing config"
        else
            warn "No Alacritty template or config found - creating default template"
            mkdir -p "$(dirname "$template_file")"
            cat > "$template_file" << 'EOF'
[window]
opacity = 0.77

startup_mode = "Maximized"
decorations = "None"

# SHELL_CONFIG_START

[shell]
program = "wsl.exe ~ -d Ubuntu-24.04"
# SHELL_CONFIG_END

[font]

normal.family = "MesloLGLDZ Nerd Font"
size = 10.5

[colors]
# Primary colors
[colors.primary]
background = '#011423'
foreground = '#CBE0F0'

# Cursor colors
[colors.cursor]

text = "#011423"
cursor = "#47FF9C"

# Normal colors

[colors.normal]
black = "#214969"
red = "#E52E2E"
green = "#44FFB1"
yellow = "#FFE073"
blue = "#0FC5ED"

magenta = "#a277ff"
cyan = "#24EAF7"
white = "#24EAF7"

# Bright colors
[colors.bright]
black = "#21717D"
red = "#E52E2E"
green = "#44FFB1"
yellow = "#FFE073"
blue = "#A277FF"
magenta = "#a277ff"
cyan = "#24EAF7"
white = "#24EAF7"
EOF

            log "Default template created"

        fi
    fi
    
    # Backup existing config if it exists and is not a symlink

    if [ -f "$config_file" ] && [ ! -L "$config_file" ]; then
        backup_file "$config_file"
    fi
    
    # Generate platform-specific config from template

    case "$platform" in
        wsl)
            # WSL: Keep shell section uncommented
            info "WSL platform: Generating config with uncommented shell section..."
            sed '/# SHELL_CONFIG_START/,/# SHELL_CONFIG_END/{
                /^# SHELL_CONFIG_START/d
                /^# SHELL_CONFIG_END/d
                /^#\[shell\]/s/^#//
                /^#program = /s/^#//
            }' "$template_file" > "$config_file"
            log "✓ WSL Alacritty config generated"
            ;;
        mac|arch|linux)
            # Non-WSL: Comment out shell section
            info "Non-WSL platform: Generating config with commented shell section..."
            sed '/# SHELL_CONFIG_START/,/# SHELL_CONFIG_END/{
                /^# SHELL_CONFIG_START/d
                /^# SHELL_CONFIG_END/d
                /^\[shell\]/s/^/#/
                /^program = /s/^/#/
            }' "$template_file" > "$config_file"
            log "✓ Non-WSL Alacritty config generated"
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

# Install TPM plugins automatically
install_tpm_plugins() {

    local tpm_dir="$HOME/.tmux/plugins/tpm"
    
    if [ -d "$tpm_dir" ] && [ -f "$HOME/.tmux.conf" ]; then

        info "Installing TPM plugins..."
        "$tpm_dir/scripts/install_plugins.sh"
        log "✓ TPM plugins installed"
    else
        warn "TPM not installed or .tmux.conf not found - skipping plugin installation"
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
    else
        error "smart-stow.sh not found in $DOTFILES_DIR/.local/bin/"
        exit 1
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

# Setup one-time auto-tmux for new terminals
setup_one_time_auto_tmux() {
    local shell_config=""

    
    # Check if first-time setup is needed
    if [ -f "$SETUP_FLAG_FILE" ]; then

        log "✓ One-time auto-tmux already configured"
        return 0
    fi
    
    # Determine which shell config to modify
    if command -v zsh >/dev/null 2>&1; then

        shell_config="$HOME/.zshrc"
    else
        shell_config="$HOME/.bashrc"

    fi
    

    if [ -f "$shell_config" ]; then
        # Check if auto-tmux is already set up
        if ! grep -q "# One-time dotfiles setup" "$shell_config"; then
            info "Setting up one-time auto-tmux for next restart..."
            

            cat >> "$shell_config" << EOF

# One-time dotfiles setup - will be removed after first run
if [ -f "$SETUP_FLAG_FILE" ] && command -v tmux &> /dev/null && [ -n "\$PS1" ] && [[ ! "\$TERM" =~ screen ]] && [[ ! "\$TERM" =~ tmux ]] && [ -z "\$TMUX" ]; then
    echo "Running one-time tmux setup with plugin installation..."
    
    # Install TPM plugins if they haven't been installed yet
    if [ -d "\$HOME/.tmux/plugins/tpm" ] && [ -f "\$HOME/.tmux.conf" ]; then
        tmux new-session -d -s main 2>/dev/null || true
        tmux send-keys -t main 'source ~/.zshrc || source ~/.bashrc' C-m 2>/dev/null || true
        tmux send-keys -t main '\$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh' C-m 2>/dev/null || true
        tmux send-keys -t main 'clear' C-m 2>/dev/null || true
    fi
    
    # Remove the flag and this auto-setup code
    rm -f "$SETUP_FLAG_FILE"
    
    # Remove this auto-setup block from shell config
    sed -i '/# One-time dotfiles setup/,/^fi$/d' "$shell_config" 2>/dev/null || true
    
    echo "One-time setup complete! Attaching to tmux..."
    tmux attach-session -t main 2>/dev/null || tmux new-session -s main

fi
EOF
            
            # Create the flag file to trigger the setup
            mkdir -p "$(dirname "$SETUP_FLAG_FILE")"
            touch "$SETUP_FLAG_FILE"

            
            log "✓ One-time auto-tmux setup configured"
            log "Setup will run on next shell restart and then remove itself"
        else
            log "✓ Auto-tmux already configured"
        fi
    fi
}

# Check if already stowed (symlink protection)
is_already_stowed() {
    local test_file="$HOME/.zshrc"
    if [ -L "$test_file" ] && [ "$(readlink "$test_file")" = "$DOTFILES_DIR/.zshrc" ]; then
        return 0
    fi
    return 1
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
    
    # Step 2: Validate dependencies
    validate_dependencies

    echo "=================================="
    
    # Step 3: Install TPM before stow

    install_tpm
    echo "=================================="
    
    # Step 4: Generate platform-specific Alacritty config BEFORE stow
    info "Preparing Alacritty configuration..."
    generate_alacritty_config "$platform"
    echo "=================================="

    
    # Step 5: Handle WSL-specific logic

    handle_wsl_specific "$platform"
    echo "=================================="
    
    # Step 6: Check if already stowed

    if is_already_stowed; then
        warn "Dotfiles appear to already be stowed (symlinks detected)"
        warn "Skipping stow to prevent conflicts"
    else
        # Run smart-stow
        run_smart_stow "$platform"
    fi
    echo "=================================="
    
    # Step 7: Install TPM plugins after configs are linked
    install_tpm_plugins
    echo "=================================="
    
    # Step 8: Setup one-time auto-tmux
    setup_one_time_auto_tmux
    echo "=================================="

    
    # Step 9: Source configuration files
    source_configs "$platform"
    echo "=================================="
    
    log "Setup complete!"
    log "Platform: $platform"
    

    info "Next steps:"
    echo "  1. Restart your shell or run: exec \$SHELL"
    echo "  2. First new terminal will auto-start tmux and install plugins"
    
    case "$platform" in
        arch)
            echo "  3. Restart i3 to load new configs: \$mod+Shift+r"
            ;;

        wsl)

            echo "  3. Check Windows startup folder for VBS script shortcuts"
            ;;

        mac)

            echo "  3. You may need to restart Terminal.app for all changes"
            ;;
    esac
}

# Run main function
main "$@"
