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

    
    echo "DEBUG: platform=$platform"
    echo "DEBUG: config file=$alacritty_config"
    echo "DEBUG: file exists=$(test -f "$alacritty_config" && echo YES || echo NO)"
    
    if [ -f "$alacritty_config" ]; then
        echo "DEBUG: checking for shell section..."
        echo "DEBUG: commented check result=$(grep -q "^#\[shell\]" "$alacritty_config" && echo FOUND || echo NOT_FOUND)"
        echo "DEBUG: uncommented check result=$(grep -q "^\[shell\]" "$alacritty_config" && echo FOUND || echo NOT_FOUND)"
    fi

    info "Checking Alacritty configuration for platform: $platform"
    
    if [ ! -f "$alacritty_config" ]; then
        warn "Alacritty config not found: $alacritty_config"
        return 1
    fi
    
    # Check if shell section exists (commented or uncommented)

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
                sed -i 's/^#\[shell\]/[shell]/' "$alacritty_config"
                sed -i 's/^#program = /program = /' "$alacritty_config"
                log "✓ Shell section uncommented for WSL"

            else

                log "✓ WSL platform: shell section already uncommented"

            fi
            ;;
        mac|arch|linux)

            # Non-WSL: shell section SHOULD be commented
            if grep -q "^\[shell\]" "$alacritty_config"; then
                info "Non-WSL platform: Commenting shell section..."
                sed -i 's/^\[shell\]/#[shell]/' "$alacritty_config"

                sed -i 's/^program = /#program = /' "$alacritty_config"

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


# Install TPM plugins automatically
install_tpm_plugins() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    
    if [ -d "$tpm_dir" ] && [ -f "$HOME/.tmux.conf" ]; then
        info "Installing TPM plugins..."
        
        # Run TPM install script
        "$tpm_dir/scripts/install_plugins.sh"
        log "✓ TPM plugins installed"

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

# Setup auto-tmux for new terminals
setup_auto_tmux() {
    local shell_config=""
    

    # Determine which shell config to modify
    if command -v zsh >/dev/null 2>&1; then

        shell_config="$HOME/.zshrc"
    else
        shell_config="$HOME/.bashrc"


    fi
    


    if [ -f "$shell_config" ]; then
        # Check if auto-tmux is already set up

        if ! grep -q "# Auto-start tmux" "$shell_config"; then
            info "Setting up auto-tmux for new terminals..."
            

            cat >> "$shell_config" << 'EOF'

# Auto-start tmux with TPM plugin installation
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    # Install TPM plugins if they haven't been installed yet
    if [ -d "$HOME/.tmux/plugins/tpm" ] && [ -f "$HOME/.tmux.conf" ]; then
        tmux new-session -d -s main 2>/dev/null || true
        tmux send-keys -t main 'source ~/.zshrc' C-m 2>/dev/null || tmux send-keys -t main 'source ~/.bashrc' C-m 2>/dev/null || true
        tmux send-keys -t main '~/.tmux/plugins/tpm/scripts/install_plugins.sh' C-m 2>/dev/null || true
        tmux attach-session -t main 2>/dev/null || tmux new-session
    else
        tmux attach-session -t main 2>/dev/null || tmux new-session -s main

    fi
fi

EOF
            log "✓ Auto-tmux setup complete"
        else
            log "✓ Auto-tmux already configured"

        fi
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

    
    # Step 4: Check and modify Alacritty config

    info "Handling Alacritty configuration..."
    modify_dotfiles_alacritty_config "$platform"
    echo "=================================="

    
    # Step 5: Handle WSL-specific logic

    handle_wsl_specific "$platform"
    echo "=================================="
    
    # Step 6: Run smart-stow
    run_smart_stow "$platform"
    echo "=================================="
    
    # Step 7: Install TPM plugins after configs are linked

    install_tpm_plugins
    echo "=================================="
    
    # Step 8: Setup auto-tmux
    setup_auto_tmux
    echo "=================================="

    
    # Step 9: Source configuration files
    source_configs "$platform"
    echo "=================================="

    
    log "Setup complete!"
    log "Platform: $platform"
    
    info "Next steps:"

    echo "  1. Restart your shell or run: exec \$SHELL"
    echo "  2. New terminals will auto-start tmux with plugins installed"
    
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
