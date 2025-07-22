#!/bin/bash

# Enhanced Cross-Platform System Backup Script
# Supports: WSL, macOS, Arch Linux
# Focus: Only backup packages you actually care about

set -euo pipefail

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Platform detection
detect_platform() {
    if [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -f /proc/version ]] && grep -qi "microsoft\|wsl" /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ $(uname) == "Darwin" ]]; then
        echo "mac"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"

    fi
}

# Smart package discovery - only what you actually want
discover_packages() {
    local platform=$1 pkg_dir=$2
    mkdir -p "$pkg_dir"
    
    # Core cross-platform tools (your personal environment)
    local core_tools="git neovim zsh tmux lazygit nodejs python-pip curl wget jq htop unzip stow zoxide"
    
    # Platform-specific essentials
    case $platform in
        "wsl")
            local platform_tools="fontconfig less"
            ;;

        "mac") 
            local platform_tools="less mas"
            ;;
        "arch")
            local platform_tools="alsa-utils pulsemixer brightnessctl polybar feh alacritty xsel xclip firefox xorg-xrandr fontconfig rustup"
            ;;

    esac
    
    # Combine core + platform tools and save as curated list
    echo "$core_tools $platform_tools" | tr ' ' '\n' | sort -u > "$pkg_dir/packages.curated"

    
    # Scan for dotfile dependencies
    detect_dotfile_deps "$pkg_dir/packages.dotfile-deps"

    
    # Only discover packages from sources you control
    discover_user_packages "$platform" "$pkg_dir"
    
    # Skip system package managers - they're too noisy!
    log_info "📦 Skipping system packages (apt/pacman base) - focusing on your manual choices"
}

# Detect dependencies from your dotfiles
detect_dotfile_deps() {
    local deps_file=$1

    local deps=()
    
    # Alacritty config

    [[ -f ~/.config/alacritty/alacritty.yml || -f ~/.alacritty.yml ]] && deps+=("alacritty")
    
    # Tmux config
    [[ -f ~/.tmux.conf ]] && deps+=("tmux")
    
    # Neovim config
    [[ -d ~/.config/nvim ]] && deps+=("neovim")
    
    # Zsh config
    [[ -f ~/.zshrc ]] && deps+=("zsh")
    
    # Git config
    [[ -f ~/.gitconfig ]] && deps+=("git")
    
    # Save detected dependencies

    if [[ ${#deps[@]} -gt 0 ]]; then
        printf '%s\n' "${deps[@]}" | sort -u > "$deps_file"
        log_info "🔍 Detected ${#deps[@]} dotfile dependencies"
    else
        touch "$deps_file"
    fi
}

# Discover only user-controlled packages
discover_user_packages() {
    local platform=$1 pkg_dir=$2
    
    # Homebrew (macOS) - everything is manual, so include it

    if [[ $platform == "mac" ]]; then
        if command -v brew >/dev/null 2>&1; then
            log_info "🍺 Detecting Homebrew packages..."
            brew list --formula > "$pkg_dir/packages.brew" 2>/dev/null || touch "$pkg_dir/packages.brew"

            brew list --cask > "$pkg_dir/packages.cask" 2>/dev/null || touch "$pkg_dir/packages.cask"
            log_success "📦 Found $(wc -l < "$pkg_dir/packages.brew" 2>/dev/null || echo 0) brew formulas, $(wc -l < "$pkg_dir/packages.cask" 2>/dev/null || echo 0) casks"
        else
            touch "$pkg_dir/packages.brew" "$pkg_dir/packages.cask"
            log_info "🍺 Homebrew not found, skipping"
        fi
        
        if command -v mas >/dev/null 2>&1; then
            mas list > "$pkg_dir/packages.mas" 2>/dev/null || touch "$pkg_dir/packages.mas"
        else
            touch "$pkg_dir/packages.mas"
        fi
    else
        touch "$pkg_dir/packages.brew" "$pkg_dir/packages.cask" "$pkg_dir/packages.mas"
    fi
    
    # User-installed packages from language managers
    # Cargo (Rust)
    if command -v cargo >/dev/null 2>&1; then

        log_info "🦀 Detecting Cargo packages..."
        cargo install --list 2>/dev/null | grep -E "^[a-zA-Z0-9_-]+ v" | cut -d' ' -f1 > "$pkg_dir/packages.cargo" || touch "$pkg_dir/packages.cargo"
        local cargo_count=$(wc -l < "$pkg_dir/packages.cargo" 2>/dev/null || echo 0)
        [[ $cargo_count -gt 0 ]] && log_success "📦 Found $cargo_count cargo packages" || log_info "📦 No cargo packages found"
    else
        touch "$pkg_dir/packages.cargo"
        log_info "🦀 Cargo not found, skipping"
    fi
    
    # Python pip (user packages only)
    if command -v pip3 >/dev/null 2>&1; then
        log_info "🐍 Detecting pip user packages..."
        pip3 list --user --format=freeze 2>/dev/null | cut -d'=' -f1 > "$pkg_dir/packages.pip" || touch "$pkg_dir/packages.pip"
        local pip_count=$(wc -l < "$pkg_dir/packages.pip" 2>/dev/null || echo 0)
        [[ $pip_count -gt 0 ]] && log_success "📦 Found $pip_count pip user packages" || log_info "📦 No pip user packages found"
    else
        touch "$pkg_dir/packages.pip"
        log_info "🐍 pip3 not found, skipping"
    fi
    
    # NPM global packages - FIXED VERSION
    if command -v npm >/dev/null 2>&1; then
        log_info "📦 Detecting npm global packages..."
        
        # Try multiple methods to get npm globals
        {
            # Method 1: Use npm list with better error handling

            npm list -g --depth=0 --parseable 2>/dev/null | 

            grep -E "node_modules/[^/]+$" | 

            sed 's|.*/node_modules/||' |

            grep -v "^npm$" ||

            
            # Method 2: Fallback to direct directory listing
            if command -v npm >/dev/null && npm root -g >/dev/null 2>&1; then

                find "$(npm root -g)" -maxdepth 1 -type d 2>/dev/null | 
                grep -v "^$(npm root -g)$" | 
                xargs -I {} basename {} 2>/dev/null |

                grep -v "^npm$" || true

            fi
        } | sort -u > "$pkg_dir/packages.npm"

        
        local npm_count=$(wc -l < "$pkg_dir/packages.npm" 2>/dev/null || echo 0)
        if [[ $npm_count -gt 0 ]]; then
            log_success "📦 Found $npm_count npm global packages"

        else

            log_warning "⚠️ No npm global packages found (maybe none installed globally, or Mason installs them locally)"
        fi

    else
        touch "$pkg_dir/packages.npm"
        log_info "📦 npm not found, skipping"
        echo "# NOTE: npm not currently installed, but will be installed as dependency of nodejs" > "$pkg_dir/packages.npm"
    fi
    
    # AUR packages (Arch) - these are usually manual choices
    if [[ $platform == "arch" ]]; then
        if command -v yay >/dev/null 2>&1; then
            log_info "🏗️ Detecting AUR packages (yay)..."
            yay -Qm | cut -d' ' -f1 > "$pkg_dir/packages.aur" || touch "$pkg_dir/packages.aur"
        elif command -v paru >/dev/null 2>&1; then

            log_info "🏗️ Detecting AUR packages (paru)..."
            paru -Qm | cut -d' ' -f1 > "$pkg_dir/packages.aur" || touch "$pkg_dir/packages.aur"
        else
            touch "$pkg_dir/packages.aur"
            log_info "🏗️ No AUR helper found, skipping"

        fi
        

        local aur_count=$(wc -l < "$pkg_dir/packages.aur" 2>/dev/null || echo 0)
        [[ $aur_count -gt 0 ]] && log_success "📦 Found $aur_count AUR packages" || log_info "📦 No AUR packages found"
    else
        touch "$pkg_dir/packages.aur"
    fi
}

# Generate system info
get_system_info() {
    local platform=$1 info_file=$2
    cat > "$info_file" << EOF
# System Information - $(date)


PLATFORM=$platform
HOSTNAME=$(hostname)

USER=$(whoami)

KERNEL=$(uname -r)
ARCH=$(uname -m)

BACKUP_DATE=$(date -Iseconds)

EOF

}


# Generate restore script with FIXED package manager bootstrapping
generate_restore_script() {

    local backup_dir=$1
    cat > "$backup_dir/restore.sh" << 'EOF'
#!/bin/bash
set -euo pipefail


RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

detect_platform() {
    if [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -f /proc/version ]] && grep -qi "microsoft\|wsl" /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ $(uname) == "Darwin" ]]; then

        echo "mac"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"

    fi
}

# Cross-platform package name translation

translate_package() {
    local platform=$1 package=$2

    

    case "$platform-$package" in
        # Python pip differences
        "wsl-python-pip") echo "python3-pip" ;;
        "arch-python-pip") echo "python-pip" ;;
        "mac-python-pip") echo "python" ;;
        
        # Node.js differences (this ensures npm gets installed!)
        "wsl-nodejs") echo "nodejs npm" ;;

        "mac-nodejs") echo "node" ;;
        "arch-nodejs") echo "nodejs npm" ;;

        
        # Default: return original
        *) echo "$package" ;;

    esac
}


# FIXED: Ensure package managers are installed before using them
bootstrap_package_managers() {
    local platform=$1

    
    case $platform in

        "mac")
            # Install Homebrew if not present
            if ! command -v brew >/dev/null 2>&1; then
                log_info "🍺 Installing Homebrew..."

                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
                    log_error "Failed to install Homebrew"
                    return 1

                }
                # Add to PATH for current session
                eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null || true
            fi
            ;;
            
        "arch")
            # Install AUR helper if not present
            if ! command -v yay >/dev/null 2>&1 && ! command -v paru >/dev/null 2>&1; then
                log_info "🏗️ Installing yay (AUR helper)..."
                sudo pacman -S --noconfirm git base-devel || {
                    log_error "Failed to install AUR dependencies"
                    return 1
                }

                
                # FIXED: Save current directory and use absolute paths
                local original_dir=$(pwd)
                local temp_dir="/tmp/yay-install-$$"

                
                mkdir -p "$temp_dir" && cd "$temp_dir" || {
                    log_error "Failed to create temp directory"
                    return 1
                }

                
                if git clone https://aur.archlinux.org/yay.git && cd yay; then
                    makepkg -si --noconfirm || {
                        log_error "Failed to build yay"
                        cd "$original_dir"
                        rm -rf "$temp_dir"
                        return 1
                    }

                else

                    log_error "Failed to clone yay repository"
                    cd "$original_dir"
                    rm -rf "$temp_dir"
                    return 1
                fi
                
                # Return to original directory and cleanup
                cd "$original_dir"
                rm -rf "$temp_dir"
                log_success "✅ yay installed successfully"
            fi

            ;;

        "wsl")
            # WSL uses apt, which should be available by default
            log_info "🐧 Using apt package manager"
            ;;
    esac
}

install_nerd_fonts() {
    local platform=$1
    log_info "Installing Meslo Nerd Font..."

    

    local version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest 2>/dev/null | grep '"tag_name"' | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/' 2>/dev/null || echo "v3.2.1")
    local temp_dir="/tmp/nerd-fonts-$$"
    local font_installed=false
    
    mkdir -p "$temp_dir" && cd "$temp_dir" || { log_error "Failed to create temp directory"; return 1; }
    
    if wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/$version/Meslo.zip" 2>/dev/null; then
        case $platform in
            "wsl")
                if unzip -q Meslo.zip "*.ttf" 2>/dev/null && ls *.ttf >/dev/null 2>&1; then

                    # Try Windows directories first
                    for win_dir in "/mnt/c/Windows/Fonts" "/mnt/c/Users/$USER/AppData/Local/Microsoft/Windows/Fonts"; do
                        if [[ -d "$(dirname "$win_dir" 2>/dev/null)" ]]; then

                            mkdir -p "$win_dir" 2>/dev/null || true
                            if cp *.ttf "$win_dir/" 2>/dev/null; then
                                log_success "✅ Fonts installed to Windows: $win_dir"
                                font_installed=true
                                break
                            fi
                        fi

                    done
                    
                    if [[ "$font_installed" != true ]]; then
                        mkdir -p ~/.local/share/fonts 2>/dev/null && cp *.ttf ~/.local/share/fonts/ 2>/dev/null && fc-cache -fv >/dev/null 2>&1 && {
                            log_warning "⚠️ Fonts installed locally. For Windows Alacritty, install manually to Windows fonts."
                            font_installed=true

                        }
                    fi
                fi
                ;;

            "mac")

                if unzip -q Meslo.zip "*.ttf" 2>/dev/null && ls *.ttf >/dev/null 2>&1; then
                    mkdir -p ~/Library/Fonts && cp *.ttf ~/Library/Fonts/ && {
                        log_success "✅ Fonts installed to ~/Library/Fonts"
                        font_installed=true
                    }
                fi

                ;;
            "arch")
                mkdir -p ~/.local/share/fonts 2>/dev/null && unzip -q Meslo.zip -d ~/.local/share/fonts/ 2>/dev/null && fc-cache -fv >/dev/null 2>&1 && {

                    log_success "✅ Fonts installed and font cache updated"
                    font_installed=true
                }
                ;;
        esac
    else

        log_error "❌ Failed to download font archive"
    fi
    
    cd - >/dev/null 2>&1 && rm -rf "$temp_dir" 2>/dev/null || true
    
    if [[ "$font_installed" != true ]]; then
        log_error "❌ Font installation failed"
        return 1

    fi
}

configure_zsh() {
    log_info "Configuring Zsh as default shell..."
    if ! command -v zsh >/dev/null 2>&1; then

        log_warning "⚠️ Zsh not found, skipping shell configuration"
        return 0
    fi
    
    local zsh_path=$(which zsh)
    
    # Add zsh to /etc/shells if not present
    if ! grep -q "^$zsh_path$" /etc/shells 2>/dev/null; then
        echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null || {

            log_error "❌ Failed to add zsh to /etc/shells"

            return 1

        }
    fi
    
    # Change default shell if not already zsh
    if [[ "$SHELL" != "$zsh_path" ]]; then

        log_info "Changing default shell to zsh (may require password)..."
        if sudo chsh -s "$zsh_path" "$USER" 2>/dev/null; then

            log_success "✅ Default shell changed to zsh. Restart terminal to apply."
        else
            log_error "❌ Failed to change default shell to zsh"

            return 1

        fi
    else

        log_success "✅ Zsh is already the default shell"
    fi

}


# FIXED: Collect, translate, dedupe and install in proper order
install_all_packages() {
    local platform=$1
    
    # Step 1: Collect all system packages from all sources
    local all_sys_packages=()
    local all_lang_packages=()
    
    # Collect system packages (curated + dotfile-deps + brew/aur)
    for file in config/packages.{curated,dotfile-deps,brew,aur}; do
        [[ -f "$file" && -s "$file" ]] || continue
        while IFS= read -r pkg; do
            [[ -z "$pkg" || "$pkg" =~ ^[[:space:]]*# ]] && continue
            all_sys_packages+=("$pkg")
        done < "$file"

    done
    
    # Collect language packages separately

    for file in config/packages.{cargo,pip,npm}; do

        [[ -f "$file" && -s "$file" ]] || continue

        local lang=$(basename "$file" | cut -d. -f2)
        while IFS= read -r pkg; do
            [[ -z "$pkg" || "$pkg" =~ ^[[:space:]]*# ]] && continue
            all_lang_packages+=("$lang:$pkg")
        done < "$file"
    done
    
    # Step 2: Translate and deduplicate system packages
    local translated_packages=()
    local seen_packages=()

    

    for pkg in "${all_sys_packages[@]}"; do
        local translated=$(translate_package "$platform" "$pkg")
        for t_pkg in $translated; do
            if [[ ! " ${seen_packages[*]} " =~ " ${t_pkg} " ]]; then
                translated_packages+=("$t_pkg")
                seen_packages+=("$t_pkg")

            fi

        done

    done
    
    # Step 3: Install system packages first
    if [[ ${#translated_packages[@]} -gt 0 ]]; then
        log_info "🔧 Installing ${#translated_packages[@]} system packages..."
        local sys_failed=()
        
        case $platform in
            "arch") 
                for pkg in "${translated_packages[@]}"; do
                    if ! sudo pacman -S --noconfirm "$pkg" 2>/dev/null; then
                        if command -v yay >/dev/null && ! yay -S --noconfirm "$pkg" 2>/dev/null; then

                            command -v paru >/dev/null && ! paru -S --noconfirm "$pkg" 2>/dev/null && sys_failed+=("$pkg")
                        fi
                    fi
                done ;;
            "mac") 

                for pkg in "${translated_packages[@]}"; do
                    brew install "$pkg" 2>/dev/null || sys_failed+=("$pkg")
                done ;;

            "wsl") 
                # Install in batches for efficiency
                if ! sudo apt install -y "${translated_packages[@]}" 2>/dev/null; then
                    # Fallback: install individually
                    for pkg in "${translated_packages[@]}"; do
                        sudo apt install -y "$pkg" 2>/dev/null || sys_failed+=("$pkg")
                    done
                fi ;;
        esac
        

        [[ ${#sys_failed[@]} -gt 0 ]] && log_warning "Failed system packages: ${sys_failed[*]}"
    fi
    
    # Step 4: Verify and setup language package managers
    log_info "🔧 Verifying package managers..."
    

    # Install Rust if needed and cargo packages exist
    if [[ -f config/packages.cargo && -s config/packages.cargo ]] && ! command -v cargo >/dev/null 2>&1; then
        log_info "🦀 Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

        source ~/.cargo/env 2>/dev/null || export PATH="$HOME/.cargo/bin:$PATH"
    fi

    

    # Refresh PATH to pick up newly installed tools
    hash -r 2>/dev/null || true

    
    # Step 5: Install language packages
    if [[ ${#all_lang_packages[@]} -gt 0 ]]; then

        log_info "📦 Installing ${#all_lang_packages[@]} language packages..."
        local lang_failed=()

        
        for lang_pkg in "${all_lang_packages[@]}"; do
            local lang="${lang_pkg%%:*}"

            local pkg="${lang_pkg#*:}"
            
            case $lang in
                "cargo") 
                    command -v cargo >/dev/null && cargo install "$pkg" 2>/dev/null || lang_failed+=("cargo:$pkg") ;;
                "pip") 
                    command -v pip3 >/dev/null && pip3 install --user "$pkg" 2>/dev/null || lang_failed+=("pip:$pkg") ;;

                "npm") 
                    if command -v npm >/dev/null 2>&1 && [[ "$pkg" != "lib" ]]; then
                        npm install -g "$pkg" 2>/dev/null || lang_failed+=("npm:$pkg")
                    fi ;;
            esac
        done
        
        [[ ${#lang_failed[@]} -gt 0 ]] && log_warning "Failed language packages: ${lang_failed[*]}"
    fi

    
    # Step 6: Install cask/mas packages (macOS only)
    if [[ $platform == "mac" ]]; then

        for file in config/packages.{cask,mas}; do

            [[ -f "$file" && -s "$file" ]] || continue
            local type=$(basename "$file" | cut -d. -f2)
            log_info "🍺 Installing $type packages..."
            
            while IFS= read -r pkg; do
                [[ -z "$pkg" || "$pkg" =~ ^[[:space:]]*# ]] && continue

                case $type in
                    "cask") brew install --cask "$pkg" 2>/dev/null || log_warning "Failed: $pkg" ;;
                    "mas") command -v mas >/dev/null && mas install "$pkg" 2>/dev/null || log_warning "Failed: $pkg" ;;
                esac
            done < "$file"
        done
    fi
}


main() {

    local platform=$(detect_platform)
    [[ "$platform" == "unknown" ]] && { log_error "❌ Unsupported platform!"; exit 1; }
    
    log_info "🚀 Restoring system on platform: $platform"
    [[ -f config/system-info.txt ]] && { log_info "📋 Backup info:"; cat config/system-info.txt; echo; }
    
    # FIXED: Bootstrap package managers FIRST
    log_info "🔧 Bootstrapping package managers..."

    if ! bootstrap_package_managers "$platform"; then
        log_error "❌ Failed to bootstrap package managers"
        exit 1

    fi

    

    # Update system

    log_info "📦 Updating system packages..."
    case $platform in
        "wsl") 
            sudo apt update >/dev/null 2>&1 && sudo apt upgrade -y >/dev/null 2>&1 || { log_warning "⚠️ System update failed, continuing..."; }
            ;;
        "mac") 
            if command -v brew >/dev/null; then
                brew update >/dev/null 2>&1 && brew upgrade >/dev/null 2>&1 || { log_warning "⚠️ Homebrew update failed, continuing..."; }
            fi
            ;;
        "arch") 
            sudo pacman -Syu --noconfirm >/dev/null 2>&1 || { log_warning "⚠️ System update failed, continuing..."; }
            ;;
    esac
    

    # Install mas early on macOS
    if [[ $platform == "mac" ]] && ! command -v mas >/dev/null 2>&1; then
        log_info "🏪 Installing mas (Mac App Store CLI)..."
        brew install mas || log_warning "Failed to install mas"
    fi

    
    # FIXED: Install all packages in proper order
    install_all_packages "$platform"
    
    # Post-install configuration
    log_info "🎨 Configuring fonts and shell..."
    local config_failed=0
    
    if ! install_nerd_fonts "$platform"; then
        ((config_failed++))

    fi
    

    if ! configure_zsh "$platform"; then

        ((config_failed++))
    fi
    
    # Final summary
    echo

    if [[ $config_failed -eq 0 ]]; then
        log_success "✅ System restore completed successfully!"
    else
        log_warning "⚠️ System restore completed with some issues"
    fi

    
    echo
    log_info "📋 Manual steps remaining:"
    echo -e "${BLUE}  1.${NC} Restart terminal/Alacritty to apply changes"

    echo -e "${BLUE}  2.${NC} Restore your dotfiles"
    echo -e "${BLUE}  3.${NC} Firefox: Settings > General > Startup > 'Open previous windows and tabs'"
    echo -e "${BLUE}  4.${NC} Verify shell: ${GREEN}echo \$SHELL${NC} (should show zsh path)"
    echo -e "${BLUE}  5.${NC} Install Mason dependencies: ${GREEN}:MasonInstall <package>${NC}"

    

    if [[ "$platform" == "wsl" ]]; then
        echo
        log_info "💡 WSL + Alacritty Notes:"
        echo -e "${YELLOW}  - If fonts don't appear, install manually to Windows fonts directory${NC}"
        echo -e "${YELLOW}  - Use 'MesloLGLDZ Nerd Font' in Alacritty config${NC}"

    fi
}

main "$@"
EOF

    chmod +x "$backup_dir/restore.sh"
}


main() {

    local platform=$(detect_platform)
    [[ "$platform" == "unknown" ]] && { log_error "Unsupported platform!"; exit 1; }
    

    # Create backups in consistent location

    local backup_base_dir="$HOME/system-backups"
    mkdir -p "$backup_base_dir"
    local backup_dir="$backup_base_dir/system-backup-$(date +%Y%m%d_%H%M%S)"
    local config_dir="$backup_dir/config"

    

    log_info "🚀 Creating intelligent system backup for: $platform"
    log_info "📁 Backup location: $backup_dir"
    mkdir -p "$config_dir"
    
    get_system_info "$platform" "$config_dir/system-info.txt"
    discover_packages "$platform" "$config_dir"
    generate_restore_script "$backup_dir"

    

    # Create README
    cat > "$backup_dir/README.md" << EOF

# Enhanced System Backup - $(date)


## Philosophy
This backup focuses on **your personal computing environment** - only the tools you actually chose to install, not system noise.

## Quick Restore


\`\`\`bash
./restore.sh
\`\`\`


## What Gets Backed Up

✅ **Your curated tools**: Development environment, CLI utilities  

✅ **Dotfile dependencies**: Tools your configs require  
✅ **Language packages**: cargo, pip --user, npm -g  

✅ **Manual choices**: Homebrew (macOS), AUR (Arch)  

❌ **System noise**: Base packages, auto-dependencies


## Mason & Language Servers

This script installs **nodejs** (which includes npm), but Mason installs language servers locally in:

- \`~/.local/share/nvim/mason/\`


After restoring, run \`:MasonInstall <package>\` in Neovim to reinstall language servers.

## Features

- 🎯 Smart package detection (20-50 packages vs hundreds)

- 🔄 Cross-platform name translation  
- 🎨 Auto Nerd Fonts + Zsh setup
- 📋 Dotfile dependency scanning

- 🔧 Auto package manager bootstrapping

**Platform**: $platform | **Date**: $(date)
EOF
    
    log_success "✅ Intelligent backup completed: $backup_dir"
    log_info "📦 Package counts:"
    find "$config_dir" -name "packages.*" -exec sh -c 'echo "  $(basename {} | cut -d. -f2): $(wc -l < {} 2>/dev/null || echo 0)"' \;
    
    echo

    log_info "🔧 To restore on any machine:"
    log_info "  1. Copy backup folder to target machine"
    log_info "  2. Run: ./restore.sh"

    log_info "  3. Restore your dotfiles"

    
    # Show backup contents for verification
    echo
    log_info "📂 Backup contents:"
    ls -la "$backup_dir"
    echo
    log_info "📋 Config files:"
    ls -la "$config_dir"
}


main "$@"
