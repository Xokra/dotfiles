#!/bin/bash

# Cross-Platform System Backup Script
# Supports: WSL (Ubuntu), macOS, Arch Linux (i3)
# Author: Auto-generated backup solution

set -euo pipefail

# Configuration
MAIN_BACKUP_DIR="system-backups"
BACKUP_DIR="$MAIN_BACKUP_DIR/backup-$(date +%Y%m%d_%H%M%S)"
RESTORE_SCRIPT="restore-system.sh"
PACKAGE_LIST="packages.txt"
PLATFORM_INFO="platform-info.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Platform detection function
detect_platform() {

    # Check for WSL first (multiple detection methods)

    if [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -n "${WSL_INTEROP:-}" ]]; then
        echo "wsl"
    elif [[ -f /proc/version ]] && grep -qi "microsoft\|wsl" /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ -f /proc/sys/kernel/osrelease ]] && grep -qi "microsoft\|wsl" /proc/sys/kernel/osrelease 2>/dev/null; then
        echo "wsl"
    # Check for macOS
    elif [[ $(uname) == "Darwin" ]]; then
        echo "mac"
    # Check for Arch Linux
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    # Fallback: check if it's Ubuntu/Debian (likely WSL if other methods failed)
    elif [[ -f /etc/os-release ]] && grep -qi "ubuntu\|debian" /etc/os-release 2>/dev/null && command -v apt >/dev/null 2>&1; then
        echo "wsl"
    else

        echo "unknown"
    fi
}

# Get system information
get_system_info() {
    local platform=$1
    local info_file=$2
    
    echo "# System Information - $(date)" > "$info_file"
    echo "PLATFORM=$platform" >> "$info_file"

    echo "HOSTNAME=$(hostname)" >> "$info_file"
    echo "USER=$(whoami)" >> "$info_file"

    echo "KERNEL=$(uname -r)" >> "$info_file"
    echo "ARCH=$(uname -m)" >> "$info_file"
    
    case $platform in
        "wsl")
            echo "OS_VERSION=$(lsb_release -d 2>/dev/null | cut -f2)" >> "$info_file"
            ;;
        "mac")
            echo "OS_VERSION=$(sw_vers -productVersion)" >> "$info_file"
            ;;
        "arch")
            echo "OS_VERSION=$(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)" >> "$info_file"
            ;;
    esac

}


# Discover packages based on platform
discover_packages() {
    local platform=$1
    local package_file=$2
    
    log_info "Discovering packages for platform: $platform"
    
    case $platform in

        "wsl")
            log_info "Getting APT packages..."
            # Get manually installed packages only
            apt-mark showmanual > "$package_file.apt" 2>/dev/null || {
                log_warning "apt-mark showmanual failed, using alternative method"
                apt list --installed 2>/dev/null | grep -v "WARNING" | cut -d'/' -f1 | tail -n +2 > "$package_file.apt"
            }
            
            # Get snap packages if available
            if command -v snap >/dev/null 2>&1; then
                log_info "Getting Snap packages..."

                snap list | tail -n +2 | awk '{print $1}' > "$package_file.snap" 2>/dev/null || touch "$package_file.snap"
            else
                touch "$package_file.snap"
            fi
            ;;
            
        "mac")

            log_info "Getting Homebrew packages..."
            if command -v brew >/dev/null 2>&1; then
                # Get formulae and casks separately
                brew list --formula > "$package_file.brew" 2>/dev/null || touch "$package_file.brew"

                brew list --cask > "$package_file.cask" 2>/dev/null || touch "$package_file.cask"
            else
                log_warning "Homebrew not found"
                touch "$package_file.brew"
                touch "$package_file.cask"
            fi
            
            # Get Mac App Store apps if mas is installed
            if command -v mas >/dev/null 2>&1; then
                log_info "Getting Mac App Store apps..."
                mas list > "$package_file.mas" 2>/dev/null || touch "$package_file.mas"
            else

                touch "$package_file.mas"

            fi
            ;;
            
        "arch")
            log_info "Getting Pacman packages..."
            # Get explicitly installed packages only

            pacman -Qe | cut -d' ' -f1 > "$package_file.pacman"
            

            # Get AUR packages if yay is available
            if command -v yay >/dev/null 2>&1; then
                log_info "Getting AUR packages..."
                yay -Qm | cut -d' ' -f1 > "$package_file.aur" 2>/dev/null || touch "$package_file.aur"
            else
                touch "$package_file.aur"
            fi
            ;;
            
        *)
            log_error "Unsupported platform: $platform"
            return 1

            ;;
    esac
    
    log_success "Package discovery completed"
}

# Generate the restore script
generate_restore_script() {
    local platform=$1
    local restore_script=$2
    
    log_info "Generating restore script..."
    
    cat > "$restore_script" << 'EOF'
#!/bin/bash

# Cross-Platform System Restore Script
# Generated by cross-platform backup solution

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

BLUE='\033[0;34m'

NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"

}


log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"

}


log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Platform detection
detect_platform() {

    # Check for WSL first (multiple detection methods)

    if [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -n "${WSL_INTEROP:-}" ]]; then
        echo "wsl"
    elif [[ -f /proc/version ]] && grep -qi "microsoft\|wsl" /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ -f /proc/sys/kernel/osrelease ]] && grep -qi "microsoft\|wsl" /proc/sys/kernel/osrelease 2>/dev/null; then

        echo "wsl"
    # Check for macOS
    elif [[ $(uname) == "Darwin" ]]; then
        echo "mac"
    # Check for Arch Linux
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    # Fallback: check if it's Ubuntu/Debian (likely WSL if other methods failed)
    elif [[ -f /etc/os-release ]] && grep -qi "ubuntu\|debian" /etc/os-release 2>/dev/null && command -v apt >/dev/null 2>&1; then
        echo "wsl"
    else

        echo "unknown"
    fi
}

# Package name translation map (only for packages with different names)
declare -A PACKAGE_MAP=(
    # Web browsers
    ["google-chrome-stable"]="google-chrome:chromium:google-chrome"
    ["chromium-browser"]="chromium:chromium:chromium"
    
    # Development tools
    ["nodejs"]="nodejs:node:nodejs"
    ["python3"]="python3:python@3.11:python"

    ["python3-pip"]="python3-pip:python@3.11:python-pip"
    
    # Text editors

    ["code"]="code:visual-studio-code:code"
    ["sublime-text"]="sublime-text:sublime-text:sublime-text-4"
)

# Get package name for current platform

get_package_name() {
    local original_name=$1
    local platform=$2
    
    if [[ -n "${PACKAGE_MAP[$original_name]:-}" ]]; then
        local alternatives="${PACKAGE_MAP[$original_name]}"
        case $platform in
            "wsl") echo "$alternatives" | cut -d':' -f1 ;;
            "mac") echo "$alternatives" | cut -d':' -f2 ;;

            "arch") echo "$alternatives" | cut -d':' -f3 ;;
        esac
    else

        echo "$original_name"
    fi
}

# Update package managers
update_package_managers() {
    local platform=$1
    
    log_info "Updating package managers..."

    
    case $platform in

        "wsl")
            sudo apt update && sudo apt upgrade -y
            ;;
        "mac")
            if command -v brew >/dev/null 2>&1; then
                brew update && brew upgrade
            else
                log_warning "Homebrew not installed. Installing..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi

            ;;
        "arch")
            sudo pacman -Syu --noconfirm
            ;;
    esac
}

# Install packages for WSL

install_wsl_packages() {

    local failed_packages=()
    
    if [[ -f packages.txt.apt ]]; then
        log_info "Installing APT packages..."
        while IFS= read -r package; do
            [[ -z "$package" ]] && continue

            translated_name=$(get_package_name "$package" "wsl")
            log_info "Installing: $translated_name"
            if ! sudo apt install -y "$translated_name" 2>/dev/null; then
                log_warning "Failed to install: $translated_name"

                failed_packages+=("$package")
            fi

        done < packages.txt.apt
    fi
    
    if [[ -f packages.txt.snap ]]; then
        log_info "Installing Snap packages..."
        while IFS= read -r package; do
            [[ -z "$package" ]] && continue
            if ! sudo snap install "$package" 2>/dev/null; then
                log_warning "Failed to install snap: $package"

                failed_packages+=("$package")
            fi

        done < packages.txt.snap
    fi
    
    return 0
}


# Install packages for macOS
install_mac_packages() {
    local failed_packages=()

    
    if [[ -f packages.txt.brew ]]; then
        log_info "Installing Homebrew formulae..."
        while IFS= read -r package; do
            [[ -z "$package" ]] && continue
            translated_name=$(get_package_name "$package" "mac")

            log_info "Installing: $translated_name"
            if ! brew install "$translated_name" 2>/dev/null; then

                log_warning "Failed to install: $translated_name"
                failed_packages+=("$package")
            fi
        done < packages.txt.brew
    fi

    
    if [[ -f packages.txt.cask ]]; then
        log_info "Installing Homebrew casks..."

        while IFS= read -r package; do
            [[ -z "$package" ]] && continue
            log_info "Installing cask: $package"
            if ! brew install --cask "$package" 2>/dev/null; then
                log_warning "Failed to install cask: $package"

                failed_packages+=("$package")
            fi

        done < packages.txt.cask
    fi
    
    if [[ -f packages.txt.mas ]]; then
        log_info "Installing Mac App Store apps..."
        if command -v mas >/dev/null 2>&1; then
            while IFS= read -r line; do
                [[ -z "$line" ]] && continue
                app_id=$(echo "$line" | awk '{print $1}')
                if ! mas install "$app_id" 2>/dev/null; then
                    log_warning "Failed to install MAS app: $app_id"
                    failed_packages+=("$app_id")

                fi
            done < packages.txt.mas
        else
            log_info "Installing mas (Mac App Store CLI)..."
            brew install mas
        fi
    fi
    
    return 0
}

# Install packages for Arch
install_arch_packages() {
    local failed_packages=()
    
    if [[ -f packages.txt.pacman ]]; then

        log_info "Installing Pacman packages..."

        while IFS= read -r package; do
            [[ -z "$package" ]] && continue
            translated_name=$(get_package_name "$package" "arch")
            log_info "Installing: $translated_name"
            if ! sudo pacman -S --noconfirm "$translated_name" 2>/dev/null; then
                log_warning "Failed to install: $translated_name"

                failed_packages+=("$package")
            fi

        done < packages.txt.pacman
    fi
    
    if [[ -f packages.txt.aur ]]; then
        log_info "Installing AUR packages..."
        if command -v yay >/dev/null 2>&1; then
            while IFS= read -r package; do
                [[ -z "$package" ]] && continue
                log_info "Installing AUR package: $package"
                if ! yay -S --noconfirm "$package" 2>/dev/null; then
                    log_warning "Failed to install AUR package: $package"
                    failed_packages+=("$package")
                fi
            done < packages.txt.aur
        else
            log_info "Installing yay (AUR helper)..."
            sudo pacman -S --noconfirm git base-devel
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si --noconfirm
            cd ..
            rm -rf yay
        fi
    fi
    
    return 0
}

# Main restore function
main() {
    log_info "Starting cross-platform system restore..."
    
    # Detect current platform
    CURRENT_PLATFORM=$(detect_platform)
    log_info "Detected platform: $CURRENT_PLATFORM"
    
    if [[ "$CURRENT_PLATFORM" == "unknown" ]]; then

        log_error "Unsupported platform detected!"
        exit 1
    fi
    
    # Show backup information
    if [[ -f platform-info.txt ]]; then
        log_info "Backup information:"
        cat platform-info.txt
        echo
    fi
    
    # Update package managers
    update_package_managers "$CURRENT_PLATFORM"
    
    # Install packages based on platform
    case $CURRENT_PLATFORM in
        "wsl")
            install_wsl_packages
            ;;
        "mac")

            install_mac_packages
            ;;
        "arch")
            install_arch_packages
            ;;
    esac
    
    log_success "System restore completed!"
    log_info "Note: Don't forget to restore your dotfiles from your dotfiles repository"

}


# Run main function

main "$@"

EOF

    chmod +x "$restore_script"
    log_success "Restore script generated"
}


# Create README
create_readme() {
    local backup_dir=$1
    local original_platform=$2
    
    cat > "$backup_dir/README.md" << EOF
# System Backup - $(date)

## Backup Information
- **Original Platform**: $original_platform
- **Backup Date**: $(date)
- **Hostname**: $(hostname)
- **User**: $(whoami)


## Contents
- \`restore-system.sh\` - Main restore script
- \`platform-info.txt\` - System information
- \`packages.txt.*\` - Package lists by package manager

## Usage
1. Clone this repository to your new system
2. Run: \`./restore-system.sh\`
3. The script will automatically detect your platform and install appropriate packages

## Supported Platforms
- WSL (Ubuntu)
- macOS
- Arch Linux


## Notes
- This backup only includes packages and dependencies
- Dotfiles should be restored separately from your dotfiles repository
- Some packages may have different names across platforms (handled automatically)
- Failed installations will be logged but won't stop the process

## Manual Steps After Restore

1. Restore dotfiles from your dotfiles repository
2. Configure any platform-specific settings
3. Set up SSH keys and authentication

4. Configure development environments
EOF
}

# Main function
main() {
    log_info "Starting cross-platform system backup..."
    
    # Detect current platform
    PLATFORM=$(detect_platform)
    log_info "Detected platform: $PLATFORM"
    
    if [[ "$PLATFORM" == "unknown" ]]; then
        log_error "Unsupported platform detected!"
        log_error "This script supports: WSL (Ubuntu), macOS, and Arch Linux"
        exit 1
    fi
    
    # Create backup directory
    mkdir -p "$BACKUP_DIR"
    log_success "Created backup directory: $BACKUP_DIR"
    
    # Get system information
    get_system_info "$PLATFORM" "$BACKUP_DIR/$PLATFORM_INFO"
    
    # Discover packages
    discover_packages "$PLATFORM" "$BACKUP_DIR/$PACKAGE_LIST"
    
    # Generate restore script

    generate_restore_script "$PLATFORM" "$BACKUP_DIR/$RESTORE_SCRIPT"
    

    # Create README
    create_readme "$BACKUP_DIR" "$PLATFORM"
    
    # Show summary
    log_success "Backup completed successfully!"
    echo
    log_info "Backup summary:"
    echo "  Main directory: $MAIN_BACKUP_DIR"

    echo "  This backup: $BACKUP_DIR"
    echo "  Platform: $PLATFORM"
    echo "  Files created:"
    ls -la "$BACKUP_DIR"
    echo
    log_info "All your backups are organized in: $MAIN_BACKUP_DIR/"
    echo "  $(ls -1 "$MAIN_BACKUP_DIR" | wc -l) backup(s) total:"
    ls -1 "$MAIN_BACKUP_DIR"
    echo
    log_info "Next steps:"
    echo "  1. cd $BACKUP_DIR"
    echo "  2. git init && git add . && git commit -m 'System backup'"
    echo "  3. Push to your backup repository"
    echo "  4. On new system: git clone <repo> && cd <repo> && ./restore-system.sh"

}


# Run main function

main "$@"
