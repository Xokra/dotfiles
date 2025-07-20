#!/bin/bash

# Enhanced Cross-Platform System Backup Script
# Supports: WSL (Ubuntu), macOS, Arch Linux
# Author: Enhanced backup solution with modular design and Nerd Fonts

set -euo pipefail

# Configuration

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_BACKUP_DIR="system-backups"
BACKUP_DIR="$MAIN_BACKUP_DIR/backup-$(date +%Y%m%d_%H%M%S)"
CONFIG_DIR="$BACKUP_DIR/config"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Platform detection
detect_platform() {

    if [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -n "${WSL_INTEROP:-}" ]] || 
       [[ -f /proc/version ]] && grep -qi "microsoft\|wsl" /proc/version 2>/dev/null; then
        echo "wsl"

    elif [[ $(uname) == "Darwin" ]]; then
        echo "mac"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    elif [[ -f /etc/os-release ]] && grep -qi "ubuntu\|debian" /etc/os-release 2>/dev/null; then
        echo "wsl"
    else

        echo "unknown"
    fi
}

# Package manager definitions
declare -A PACKAGE_MANAGERS=(

    ["wsl"]="apt snap cargo pip npm flatpak"
    ["mac"]="brew cask mas cargo pip npm"
    ["arch"]="pacman aur cargo pip npm flatpak"
)

# Essential packages needed before backup restore
declare -A ESSENTIAL_PACKAGES=(
    ["wsl"]="git curl build-essential unzip wget"
    ["mac"]="git curl unzip wget"
    ["arch"]="git base-devel curl unzip wget"
)

# Curated essential packages for each platform (always install these)
declare -A CURATED_PACKAGES=(
    ["wsl"]="neovim tmux zsh curl wget git htop jq unzip python3-pip nodejs npm fontconfig"
    ["mac"]="neovim tmux zsh curl wget git htop jq unzip python nodejs npm"
    ["arch"]="git xsel alsa-utils brightnessctl polybar feh rustup nodejs npm lazygit neovim python-pip zsh fontconfig unzip jq pulsemixer htop xclip alacritty firefox wget curl xorg-xrandr stow zoxide tmux"
)

# Package discovery functions
discover_apt() {
    local output_file=$1
    log_info "Discovering APT packages..."
    {
        apt-mark showmanual 2>/dev/null || 
        dpkg --get-selections | grep -v deinstall | cut -f1
    } | sort > "$output_file" 2>/dev/null || touch "$output_file"
}

discover_snap() {
    local output_file=$1
    if command -v snap >/dev/null 2>&1; then
        log_info "Discovering Snap packages..."
        snap list | tail -n +2 | awk '{print $1}' > "$output_file" 2>/dev/null || touch "$output_file"

    else
        touch "$output_file"
    fi
}

discover_cargo() {
    local output_file=$1
    if command -v cargo >/dev/null 2>&1; then

        log_info "Discovering Cargo packages..."

        cargo install --list | grep -E "^[a-zA-Z0-9_-]+ v[0-9]" | cut -d' ' -f1 > "$output_file" 2>/dev/null || touch "$output_file"
    else
        touch "$output_file"
    fi
}

discover_pip() {
    local output_file=$1

    if command -v pip3 >/dev/null 2>&1; then
        log_info "Discovering global pip packages..."
        pip3 list --user --format=freeze 2>/dev/null | cut -d'=' -f1 > "$output_file" || 
        pip3 list --format=freeze 2>/dev/null | grep -v "^-e " | cut -d'=' -f1 > "$output_file" || 
        touch "$output_file"
    else
        touch "$output_file"
    fi
}

discover_npm() {
    local output_file=$1
    if command -v npm >/dev/null 2>&1; then
        log_info "Discovering global npm packages..."
        npm list -g --depth=0 --parseable 2>/dev/null | grep -v "^$" | xargs basename | grep -v "^npm$" > "$output_file" || touch "$output_file"
    else
        touch "$output_file"
    fi
}

discover_flatpak() {
    local output_file=$1
    if command -v flatpak >/dev/null 2>&1; then
        log_info "Discovering Flatpak packages..."
        flatpak list --app --columns=application | tail -n +1 > "$output_file" 2>/dev/null || touch "$output_file"
    else
        touch "$output_file"
    fi
}

discover_brew() {
    local output_file=$1

    if command -v brew >/dev/null 2>&1; then
        log_info "Discovering Homebrew formulae..."
        brew list --formula > "$output_file" 2>/dev/null || touch "$output_file"
    else
        touch "$output_file"
    fi
}


discover_cask() {
    local output_file=$1
    if command -v brew >/dev/null 2>&1; then
        log_info "Discovering Homebrew casks..."
        brew list --cask > "$output_file" 2>/dev/null || touch "$output_file"
    else
        touch "$output_file"
    fi
}

discover_mas() {
    local output_file=$1
    if command -v mas >/dev/null 2>&1; then
        log_info "Discovering Mac App Store apps..."

        mas list > "$output_file" 2>/dev/null || touch "$output_file"
    else
        touch "$output_file"
    fi
}

discover_pacman() {
    local output_file=$1
    log_info "Discovering Pacman packages..."
    pacman -Qe | cut -d' ' -f1 > "$output_file" 2>/dev/null || touch "$output_file"
}


discover_aur() {
    local output_file=$1
    if command -v yay >/dev/null 2>&1; then

        log_info "Discovering AUR packages..."

        yay -Qm | cut -d' ' -f1 > "$output_file" 2>/dev/null || touch "$output_file"
    elif command -v paru >/dev/null 2>&1; then
        log_info "Discovering AUR packages (paru)..."
        paru -Qm | cut -d' ' -f1 > "$output_file" 2>/dev/null || touch "$output_file"

    else
        touch "$output_file"
    fi
}

# Generate curated packages list
generate_curated_packages() {
    local platform=$1
    local pkg_dir=$2
    
    # Create curated essential packages list
    if [[ -n "${CURATED_PACKAGES[$platform]:-}" ]]; then
        echo "${CURATED_PACKAGES[$platform]}" | tr ' ' '\n' > "$pkg_dir/packages.curated"
        log_info "Generated curated packages list (${CURATED_PACKAGES[$platform]// /,})"
    fi
}


# Main package discovery

discover_packages() {
    local platform=$1
    local pkg_dir=$2
    
    mkdir -p "$pkg_dir"
    
    # Generate curated packages first
    generate_curated_packages "$platform" "$pkg_dir"
    
    # Get package managers for this platform
    local managers=(${PACKAGE_MANAGERS[$platform]})
    
    for manager in "${managers[@]}"; do
        local output_file="$pkg_dir/packages.$manager"
        case $manager in
            "apt") discover_apt "$output_file" ;;
            "snap") discover_snap "$output_file" ;;
            "cargo") discover_cargo "$output_file" ;;
            "pip") discover_pip "$output_file" ;;

            "npm") discover_npm "$output_file" ;;
            "flatpak") discover_flatpak "$output_file" ;;

            "brew") discover_brew "$output_file" ;;
            "cask") discover_cask "$output_file" ;;
            "mas") discover_mas "$output_file" ;;

            "pacman") discover_pacman "$output_file" ;;
            "aur") discover_aur "$output_file" ;;
        esac
    done

}


# System information
get_system_info() {
    local platform=$1
    local info_file=$2

    
    cat > "$info_file" << EOF
# System Information - $(date)

PLATFORM=$platform
HOSTNAME=$(hostname)

USER=$(whoami)

KERNEL=$(uname -r)
ARCH=$(uname -m)

BACKUP_DATE=$(date -Iseconds)
EOF

    case $platform in
        "wsl")

            echo "OS_VERSION=$(lsb_release -d 2>/dev/null | cut -f2 || echo 'Unknown')" >> "$info_file"
            ;;
        "mac")
            echo "OS_VERSION=$(sw_vers -productVersion)" >> "$info_file"
            ;;
        "arch")
            echo "OS_VERSION=$(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)" >> "$info_file"
            ;;

    esac
}


# Generate compact restore script
generate_restore_script() {
    local platform=$1
    local restore_script=$2
    
    cat > "$restore_script" << 'EOF'
#!/bin/bash

# Enhanced Cross-Platform System Restore Script with Nerd Fonts
set -euo pipefail

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Platform detection
detect_platform() {
    if [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -n "${WSL_INTEROP:-}" ]] || 
       [[ -f /proc/version ]] && grep -qi "microsoft\|wsl" /proc/version 2>/dev/null; then

        echo "wsl"
    elif [[ $(uname) == "Darwin" ]]; then
        echo "mac"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

# Get latest Nerd Fonts version from GitHub API
get_latest_nerd_fonts_version() {
    local version
    version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep '"tag_name"' | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/')
    [[ -n "$version" ]] && echo "$version" || echo "v3.2.1"

}


# Install Nerd Fonts
install_nerd_fonts() {
    local platform=$1
    local font_name="Meslo"
    local version=$(get_latest_nerd_fonts_version)

    local temp_dir="/tmp/nerd-fonts-$$"
    
    log_info "Installing $font_name Nerd Font ($version)..."

    
    mkdir -p "$temp_dir"
    cd "$temp_dir"
    
    case $platform in
        "wsl")
            # For WSL with Alacritty on Windows, try Windows Fonts directory first
            local windows_fonts_dir="/mnt/c/Windows/Fonts"
            local windows_user_fonts="/mnt/c/Users/$(whoami)/AppData/Local/Microsoft/Windows/Fonts"

            local installed_to_windows=false
            

            if wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$font_name.zip"; then
                unzip -q "$font_name.zip" "*.ttf" 2>/dev/null || true
                if ls *.ttf >/dev/null 2>&1; then
                    # Try Windows system fonts directory first (requires admin)
                    if [[ -d "$windows_fonts_dir" ]] && [[ -w "$windows_fonts_dir" ]]; then
                        log_info "Installing fonts to Windows system directory..."
                        for font in *.ttf; do
                            if cp "$font" "$windows_fonts_dir/" 2>/dev/null; then
                                installed_to_windows=true
                            fi
                        done
                    fi
                    
                    # Try Windows user fonts directory (no admin required)
                    if [[ "$installed_to_windows" == false ]] && [[ -d "$(dirname "$windows_user_fonts")" ]]; then
                        mkdir -p "$windows_user_fonts" 2>/dev/null || true
                        if [[ -d "$windows_user_fonts" ]] && [[ -w "$windows_user_fonts" ]]; then
                            log_info "Installing fonts to Windows user directory..."
                            for font in *.ttf; do
                                if cp "$font" "$windows_user_fonts/" 2>/dev/null; then
                                    installed_to_windows=true
                                fi
                            done
                        fi
                    fi
                    
                    # Fallback to Linux local fonts
                    if [[ "$installed_to_windows" == false ]]; then
                        log_warning "Could not access Windows fonts directories, installing locally..."
                        mkdir -p ~/.local/share/fonts
                        cp *.ttf ~/.local/share/fonts/

                        fc-cache -fv >/dev/null 2>&1
                        log_success "Fonts installed locally. Note: Alacritty on Windows may not see these fonts."
                    else
                        log_success "Fonts installed to Windows. Restart Alacritty to use new fonts."
                        log_info "💡 If fonts don't appear, you may need to run Windows as administrator and install manually"

                    fi

                else
                    log_warning "No TTF fonts found in archive"

                fi
            else

                log_error "Failed to download font archive"
            fi
            ;;
        "mac")

            local font_dir="$HOME/Library/Fonts"
            mkdir -p "$font_dir"
            if wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$font_name.zip"; then
                unzip -q "$font_name.zip" "*.ttf" 2>/dev/null || true

                if ls *.ttf >/dev/null 2>&1; then

                    cp *.ttf "$font_dir/"

                    log_success "Fonts installed to ~/Library/Fonts"
                else
                    log_warning "No TTF fonts found in archive"
                fi
            else
                log_error "Failed to download font archive"

            fi
            ;;
        "arch")

            mkdir -p ~/.local/share/fonts
            if wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/$version/$font_name.zip"; then
                unzip -q "$font_name.zip" -d ~/.local/share/fonts/

                fc-cache -fv >/dev/null 2>&1
                log_success "Fonts installed and font cache updated"
            else

                log_error "Failed to download font archive"
            fi
            ;;
    esac
    
    cd - >/dev/null
    rm -rf "$temp_dir"
}

# Configure Zsh as default shell

configure_zsh() {

    local platform=$1

    

    log_info "Configuring Zsh as default shell..."
    

    # Check if zsh is available
    if ! command -v zsh >/dev/null 2>&1; then

        log_warning "Zsh not found, skipping shell configuration"

        return
    fi
    
    local zsh_path=$(which zsh)

    
    # Check if zsh is in /etc/shells

    if ! grep -q "^$zsh_path$" /etc/shells 2>/dev/null; then
        log_info "Adding $zsh_path to /etc/shells..."
        echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
    fi
    
    # Change default shell if not already zsh
    if [[ "$SHELL" != "$zsh_path" ]]; then
        log_info "Changing default shell to zsh..."

        chsh -s "$zsh_path"
        log_success "Default shell changed to zsh. Please restart your terminal."
    else
        log_success "Zsh is already the default shell"
    fi
}

# Package installation functions
install_package_manager() {
    local platform=$1
    local manager=$2
    
    case "$platform-$manager" in
        "wsl-snap")
            if ! command -v snap >/dev/null 2>&1; then
                log_info "Installing snapd..."
                sudo apt install -y snapd
            fi
            ;;
        "mac-brew")
            if ! command -v brew >/dev/null 2>&1; then
                log_info "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                # Add brew to PATH for current session
                eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null || true

            fi

            ;;
        "mac-mas")
            if ! command -v mas >/dev/null 2>&1; then
                log_info "Installing mas..."
                brew install mas
            fi
            ;;
        "*-cargo")
            if ! command -v cargo >/dev/null 2>&1; then
                if command -v rustup >/dev/null 2>&1; then
                    log_info "Installing rust toolchain..."
                    rustup default stable
                else
                    log_info "Installing rustup..."
                    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
                    source ~/.cargo/env

                fi
            fi
            ;;
        "arch-aur")

            if ! command -v yay >/dev/null 2>&1 && ! command -v paru >/dev/null 2>&1; then
                log_info "Installing yay..."
                sudo pacman -S --noconfirm git base-devel
                cd /tmp

                git clone https://aur.archlinux.org/yay.git

                cd yay && makepkg -si --noconfirm
                cd .. && rm -rf yay
            fi
            ;;

    esac
}


install_packages() {
    local platform=$1
    local manager=$2
    local package_file="config/packages.$manager"
    
    [[ ! -f "$package_file" ]] && return 0
    [[ ! -s "$package_file" ]] && return 0
    
    log_info "Installing $manager packages..."
    install_package_manager "$platform" "$manager"

    
    local failed=0
    while IFS= read -r package; do
        [[ -z "$package" ]] && continue
        
        case $manager in
            "curated") 
                # For curated packages, try platform-specific package manager first
                if [[ "$platform" == "arch" ]]; then
                    sudo pacman -S --noconfirm "$package" 2>/dev/null || {

                        if command -v yay >/dev/null 2>&1; then
                            yay -S --noconfirm "$package" 2>/dev/null || ((failed++))
                        elif command -v paru >/dev/null 2>&1; then
                            paru -S --noconfirm "$package" 2>/dev/null || ((failed++))

                        else
                            ((failed++))

                        fi
                    }
                elif [[ "$platform" == "mac" ]]; then
                    brew install "$package" 2>/dev/null || ((failed++))

                elif [[ "$platform" == "wsl" ]]; then
                    sudo apt install -y "$package" 2>/dev/null || ((failed++))
                fi

                ;;
            "apt") sudo apt install -y "$package" 2>/dev/null || ((failed++)) ;;
            "snap") sudo snap install "$package" 2>/dev/null || ((failed++)) ;;

            "cargo") cargo install "$package" 2>/dev/null || ((failed++)) ;;
            "pip") pip3 install --user "$package" 2>/dev/null || ((failed++)) ;;

            "npm") npm install -g "$package" 2>/dev/null || ((failed++)) ;;
            "flatpak") flatpak install -y flathub "$package" 2>/dev/null || ((failed++)) ;;
            "brew") brew install "$package" 2>/dev/null || ((failed++)) ;;
            "cask") brew install --cask "$package" 2>/dev/null || ((failed++)) ;;

            "mas") mas install "$package" 2>/dev/null || ((failed++)) ;;
            "pacman") sudo pacman -S --noconfirm "$package" 2>/dev/null || ((failed++)) ;;
            "aur") 

                if command -v yay >/dev/null 2>&1; then
                    yay -S --noconfirm "$package" 2>/dev/null || ((failed++))
                elif command -v paru >/dev/null 2>&1; then
                    paru -S --noconfirm "$package" 2>/dev/null || ((failed++))

                fi
                ;;
        esac
    done < "$package_file"
    
    [[ $failed -gt 0 ]] && log_warning "$failed packages failed to install for $manager"
}

update_system() {
    local platform=$1
    
    log_info "Updating system..."
    case $platform in
        "wsl") sudo apt update && sudo apt upgrade -y ;;
        "mac") 
            # Only update brew if it exists, don't install it here
            if command -v brew >/dev/null 2>&1; then
                brew update && brew upgrade
            fi
            ;;
        "arch") sudo pacman -Syu --noconfirm ;;
    esac

}


main() {
    local platform=$(detect_platform)
    [[ "$platform" == "unknown" ]] && { log_error "Unsupported platform!"; exit 1; }
    
    log_info "Restoring system on platform: $platform"
    
    # Show backup info
    [[ -f config/system-info.txt ]] && { log_info "Backup info:"; cat config/system-info.txt; echo; }

    
    # Update system first
    update_system "$platform"

    

    # Install all packages first
    log_info "🚀 Installing packages..."
    local managers=("curated" "apt" "pacman" "brew" "snap" "cargo" "pip" "npm" "cask" "mas" "aur" "flatpak")
    for manager in "${managers[@]}"; do
        install_packages "$platform" "$manager"
    done
    

    # After all packages are installed, do post-install configuration
    log_info "🎨 Configuring fonts and shell..."
    
    # Install Nerd Fonts
    install_nerd_fonts "$platform"
    
    # Configure Zsh (depends on zsh being installed first)
    configure_zsh "$platform"
    
    log_success "System restore completed!"

    log_info "📝 Post-install checklist:"
    echo "  ✅ System updated"
    echo "  ✅ Packages installed"
    echo "  ✅ Nerd Fonts installed"
    echo "  ✅ Zsh configured as default shell"
    echo "  📋 Manual steps needed:"
    echo "     - Restore your dotfiles"
    echo "     - Restart terminal/Alacritty to use new fonts"
    echo "     - In Firefox: Settings > General > Startup > 'Open previous windows and tabs'"
    echo "     - Verify shell with: echo \$SHELL (should show zsh path)"

    

    # WSL-specific notes
    if [[ "$platform" == "wsl" ]]; then
        echo "  💡 WSL Notes:"
        echo "     - If fonts don't appear in Alacritty, try running Windows as administrator"
        echo "     - Alternatively, manually install fonts from downloaded files"
    fi
}


main "$@"
EOF
    
    chmod +x "$restore_script"
}

# Generate essential packages list

generate_essentials() {
    local platform=$1

    local essentials_file=$2

    
    cat > "$essentials_file" << EOF

# Essential packages to install BEFORE running the restore script
# These are needed to clone the backup repository and run the restore


Platform: $platform
Essential packages: ${ESSENTIAL_PACKAGES[$platform]}


# Installation commands:
EOF

    case $platform in
        "wsl")
            echo "sudo apt update && sudo apt install -y ${ESSENTIAL_PACKAGES[$platform]}" >> "$essentials_file"
            ;;
        "mac")
            echo "# Xcode command line tools should be installed automatically when running git" >> "$essentials_file"
            ;;
        "arch")
            echo "sudo pacman -S --noconfirm ${ESSENTIAL_PACKAGES[$platform]}" >> "$essentials_file"
            ;;
    esac
}

# Create README

create_readme() {

    local backup_dir=$1
    local platform=$2
    
    cat > "$backup_dir/README.md" << EOF
# Enhanced System Backup with Nerd Fonts - $(date)


## Quick Start
\`\`\`bash
# 1. Install essential packages first (see ESSENTIALS.txt)
# 2. Clone this backup

git clone <your-backup-repo>

cd <backup-folder>


# 3. Restore everything (includes Nerd Fonts + Zsh setup)
./restore.sh
\`\`\`

## What's Backed Up & Restored
- **Package Managers**: APT, Snap, Homebrew, Cargo, pip, npm, Flatpak, AUR, MAS

- **System Info**: Platform, version, architecture
- **Nerd Fonts**: Auto-detects latest version and installs Meslo

- **Zsh Configuration**: Sets Zsh as default shell
- **Smart Detection**: Automatically handles platform differences

## Special Features

- **WSL + Windows Alacritty**: Installs fonts to Windows (system or user directory)
- **Permission handling**: Falls back gracefully if no admin access
- **Auto-version detection**: Always gets latest Nerd Fonts release

- **Cross-platform**: Same script works on all supported platforms

## Font Installation Details
For WSL users with Windows Alacritty:
1. Tries `C:\Windows\Fonts` first (requires admin)
2. Falls back to `%LOCALAPPDATA%\Microsoft\Windows\Fonts` (user directory)
3. If both fail, installs locally (fonts won't be visible to Alacritty)


## Backup Contents
- \`restore.sh\` - Main restore script (cross-platform)
- \`config/\` - Package lists and system info

- \`ESSENTIALS.txt\` - Must-install packages before restore


## Original System
- **Platform**: $platform  
- **Date**: $(date)

- **Hostname**: $(hostname)


## Supported Platforms

✅ WSL (Ubuntu/Debian) - with Windows Alacritty font support  

✅ macOS (with Homebrew)  
✅ Arch Linux (with AUR)  


## Post-Install Manual Steps
1. Restart terminal/Alacritty to use new fonts

2. Restore your dotfiles
3. Firefox: Settings > General > Startup > "Open previous windows and tabs"
4. Verify shell: \`echo \$SHELL\` (should show zsh path)

## Font Configuration

For Alacritty on Windows (WSL), use this config in \`C:\Users\<username>\AppData\Roaming\Alacritty\alacritty.toml\`:
\`\`\`toml
[shell]
program = "wsl.exe"

args = ["~", "-d", "Ubuntu-24.04"]


[font]
normal.family = "MesloLGLDZ Nerd Font"
size = 10.5
\`\`\`

## Notes
- The restore script auto-detects your current platform
- Missing package managers are automatically installed
- Failed packages are logged but don't stop the process
- Nerd Fonts are installed to the appropriate system location
- Zsh is automatically configured as default shell
EOF
}

# Main function
main() {

    log_info "Starting enhanced system backup..."

    
    # Detect platform

    PLATFORM=$(detect_platform)
    log_info "Detected platform: $PLATFORM"
    
    [[ "$PLATFORM" == "unknown" ]] && {
        log_error "Unsupported platform! Supported: WSL, macOS, Arch Linux"

        exit 1
    }
    
    # Create backup structure
    mkdir -p "$BACKUP_DIR" "$CONFIG_DIR"

    log_success "Created backup directory: $BACKUP_DIR"
    

    # Get system information
    get_system_info "$PLATFORM" "$CONFIG_DIR/system-info.txt"
    
    # Discover all packages
    discover_packages "$PLATFORM" "$CONFIG_DIR"
    
    # Generate restore script
    generate_restore_script "$PLATFORM" "$BACKUP_DIR/restore.sh"
    
    # Generate essentials list
    generate_essentials "$PLATFORM" "$BACKUP_DIR/ESSENTIALS.txt"
    
    # Create documentation
    create_readme "$BACKUP_DIR" "$PLATFORM"

    

    # Show summary
    log_success "Backup completed!"
    echo
    log_info "📁 Backup location: $BACKUP_DIR"
    log_info "🔧 Files created:"
    find "$BACKUP_DIR" -type f | sed 's|^|  |'
    echo
    log_info "📦 Package counts:"
    find "$CONFIG_DIR" -name "packages.*" -exec basename {} \; | while read file; do

        manager=${file#packages.}

        count=$(wc -l < "$CONFIG_DIR/$file" 2>/dev/null || echo 0)
        echo "  $manager: $count packages"
    done

    echo
    log_info "🚀 Next steps:"

    echo "  1. cd $BACKUP_DIR"
    echo "  2. git init && git add . && git commit -m 'System backup $(date +%Y-%m-%d)'"

    echo "  3. git remote add origin <your-repo-url> && git push -u origin main"
    echo "  4. On new system: Read ESSENTIALS.txt first, then run ./restore.sh"
    echo "  5. The restore script will automatically:"
    echo "     - Install all your packages"

    echo "     - Install latest Meslo Nerd Font"

    echo "     - Configure Zsh as default shell"

    echo "     - Handle platform-specific font installation"
}

main "$@"
