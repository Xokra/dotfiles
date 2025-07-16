#!/bin/bash

# Cross-Platform System Backup Script
# Supports Windows (WSL), macOS, and Linux (including Arch)
# Creates comprehensive backup of installed packages, configurations, and dependencies

set -e  # Exit on error


# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$HOME/system-backup"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$OUTPUT_DIR/backup_$DATE"


# Create output directory
mkdir -p "$BACKUP_DIR"

# Colors for output
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
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if grep -q Microsoft /proc/version 2>/dev/null; then
            echo "wsl"
        elif [ -f /etc/arch-release ]; then
            echo "arch"
        elif [ -f /etc/debian_version ]; then
            echo "debian"
        elif [ -f /etc/redhat-release ]; then
            echo "redhat"
        else
            echo "linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# Distribution detection for Linux
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        echo "$DISTRIB_ID" | tr '[:upper:]' '[:lower:]'

    else
        echo "unknown"
    fi
}

PLATFORM=$(detect_platform)
DISTRO=$(detect_distro)


log_info "Starting cross-platform system backup..."
log_info "Platform: $PLATFORM"
log_info "Distribution: $DISTRO"

log_info "Output directory: $BACKUP_DIR"

# System Information

collect_system_info() {
    log_info "Collecting system information..."
    
    {
        echo "=== System Information ==="
        echo "Date: $(date)"
        echo "Platform: $PLATFORM"
        echo "Distribution: $DISTRO"
        echo "Kernel: $(uname -r)"
        echo "Architecture: $(uname -m)"
        echo "Hostname: $(hostname)"
        echo "User: $(whoami)"
        echo "Home: $HOME"
        echo "Shell: $SHELL"
        echo "OS Type: $OSTYPE"
        
        if [[ "$PLATFORM" == "macos" ]]; then
            echo "macOS Version: $(sw_vers -productVersion)"
        fi

        
        echo ""
    } > "$BACKUP_DIR/system_info.txt"
}

# Package Manager Backup Functions
backup_apt_packages() {

    if command -v apt &> /dev/null; then
        log_info "Backing up APT packages..."
        
        apt list --installed 2>/dev/null | grep -v "WARNING" > "$BACKUP_DIR/apt_packages.txt"
        
        {
            echo "#!/bin/bash"
            echo "# APT package reinstall script"

            echo "# Generated on $(date)"
            echo ""
            echo "sudo apt update"
            echo "sudo apt install -y \\"

            apt list --installed 2>/dev/null | grep -v "WARNING" | cut -d'/' -f1 | grep -v "^$" | sort | sed 's/$/  \\/' | sed '$s/ \\$//'
        } > "$BACKUP_DIR/install_apt_packages.sh"
        
        chmod +x "$BACKUP_DIR/install_apt_packages.sh"
    fi
}

backup_pacman_packages() {

    if command -v pacman &> /dev/null; then
        log_info "Backing up Pacman packages..."

        
        pacman -Q > "$BACKUP_DIR/pacman_packages.txt"
        pacman -Qm > "$BACKUP_DIR/pacman_aur_packages.txt" 2>/dev/null || true

        
        {

            echo "#!/bin/bash"
            echo "# Pacman package reinstall script"

            echo "# Generated on $(date)"
            echo ""
            echo "# Official repository packages"
            echo "sudo pacman -S --needed \\"
            pacman -Qn | awk '{print $1}' | sort | sed 's/$/  \\/' | sed '$s/ \\$//'

            echo ""
            echo "# AUR packages (install manually with yay/paru)"
            echo "# yay -S \\"
            pacman -Qm | awk '{print $1}' | sort | sed 's/^/# /' | sed 's/$/  \\/' | sed '$s/ \\$//'
        } > "$BACKUP_DIR/install_pacman_packages.sh"
        
        chmod +x "$BACKUP_DIR/install_pacman_packages.sh"
    fi
}

backup_homebrew_packages() {
    if command -v brew &> /dev/null; then
        log_info "Backing up Homebrew packages..."
        
        brew list --formula > "$BACKUP_DIR/homebrew_formulas.txt"
        brew list --cask > "$BACKUP_DIR/homebrew_casks.txt"
        brew bundle dump --file="$BACKUP_DIR/Brewfile" --force
        
        {
            echo "#!/bin/bash"
            echo "# Homebrew package reinstall script"
            echo "# Generated on $(date)"
            echo ""
            echo "# Install Homebrew if not present"
            echo 'if ! command -v brew &> /dev/null; then'
            echo '    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
            echo 'fi'
            echo ""
            echo "# Install from Brewfile"
            echo "brew bundle install --file=Brewfile"
        } > "$BACKUP_DIR/install_homebrew_packages.sh"
        
        chmod +x "$BACKUP_DIR/install_homebrew_packages.sh"
    fi
}

backup_yum_packages() {
    if command -v yum &> /dev/null; then
        log_info "Backing up YUM packages..."
        
        yum list installed > "$BACKUP_DIR/yum_packages.txt"
        
        {
            echo "#!/bin/bash"
            echo "# YUM package reinstall script"

            echo "# Generated on $(date)"
            echo ""
            echo "sudo yum install -y \\"
            yum list installed | tail -n +2 | awk '{print $1}' | cut -d'.' -f1 | sort | sed 's/$/  \\/' | sed '$s/ \\$//'
        } > "$BACKUP_DIR/install_yum_packages.sh"
        
        chmod +x "$BACKUP_DIR/install_yum_packages.sh"
    fi
}

# Language-specific package managers
backup_language_packages() {
    log_info "Backing up language-specific packages..."
    
    # Python packages

    if command -v pip &> /dev/null; then
        log_info "Backing up Python (pip) packages..."
        pip list --format=freeze > "$BACKUP_DIR/pip_packages.txt"
        
        {

            echo "#!/bin/bash"
            echo "# Python pip packages reinstall script"
            echo "pip install -r pip_packages.txt"
        } > "$BACKUP_DIR/install_pip_packages.sh"
        chmod +x "$BACKUP_DIR/install_pip_packages.sh"
    fi
    
    if command -v pip3 &> /dev/null; then
        log_info "Backing up Python3 (pip3) packages..."
        pip3 list --format=freeze > "$BACKUP_DIR/pip3_packages.txt"

        
        {
            echo "#!/bin/bash"
            echo "# Python3 pip3 packages reinstall script"
            echo "pip3 install -r pip3_packages.txt"
        } > "$BACKUP_DIR/install_pip3_packages.sh"
        chmod +x "$BACKUP_DIR/install_pip3_packages.sh"
    fi
    
    # Node.js packages
    if command -v npm &> /dev/null; then
        log_info "Backing up Node.js (npm) global packages..."
        npm list -g --depth=0 --json > "$BACKUP_DIR/npm_global_packages.json"
        npm list -g --depth=0 > "$BACKUP_DIR/npm_global_packages.txt"
        
        {
            echo "#!/bin/bash"
            echo "# NPM global packages reinstall script"
            echo "# Install global packages:"
            npm list -g --depth=0 --parseable --long 2>/dev/null | grep -v "$(npm config get prefix)" | cut -d: -f2 | grep -v "^$" | sort | sed 's/^/npm install -g /'
        } > "$BACKUP_DIR/install_npm_packages.sh"
        chmod +x "$BACKUP_DIR/install_npm_packages.sh"
    fi
    
    # Ruby gems
    if command -v gem &> /dev/null; then
        log_info "Backing up Ruby gems..."
        gem list > "$BACKUP_DIR/ruby_gems.txt"
        
        {

            echo "#!/bin/bash"
            echo "# Ruby gems reinstall script"
            echo "# Install gems:"
            gem list | grep -v "^$" | sed 's/ (.*//' | sed 's/^/gem install /'

        } > "$BACKUP_DIR/install_ruby_gems.sh"
        chmod +x "$BACKUP_DIR/install_ruby_gems.sh"

    fi
    
    # Go packages
    if command -v go &> /dev/null && [ -d "$HOME/go" ]; then
        log_info "Backing up Go packages..."
        find "$HOME/go/bin" -type f -executable 2>/dev/null > "$BACKUP_DIR/go_binaries.txt"
        
        {
            echo "#!/bin/bash"
            echo "# Go packages reinstall script"
            echo "# Note: Go binaries found in ~/go/bin"

            echo "# You may need to reinstall these manually:"
            find "$HOME/go/bin" -type f -executable 2>/dev/null | sed 's/^/# /'
        } > "$BACKUP_DIR/install_go_packages.sh"
        chmod +x "$BACKUP_DIR/install_go_packages.sh"
    fi

    
    # Rust/Cargo packages
    if command -v cargo &> /dev/null; then
        log_info "Backing up Rust/Cargo packages..."
        cargo install --list > "$BACKUP_DIR/cargo_packages.txt"
        
        {
            echo "#!/bin/bash"
            echo "# Cargo packages reinstall script"
            echo "# Install cargo packages:"
            cargo install --list | grep -E "^[a-zA-Z]" | awk '{print $1}' | sed 's/^/cargo install /'
        } > "$BACKUP_DIR/install_cargo_packages.sh"
        chmod +x "$BACKUP_DIR/install_cargo_packages.sh"
    fi
}

# Development tools and version managers
backup_development_tools() {
    log_info "Backing up development tools..."
    
    {
        echo "=== Development Tools ==="
        echo "$(date)"
        echo ""
        
        # Version managers

        [ -d "$HOME/.nvm" ] && echo "Node Version Manager (nvm): installed" || echo "Node Version Manager (nvm): not found"
        [ -d "$HOME/.rbenv" ] && echo "Ruby Version Manager (rbenv): installed" || echo "Ruby Version Manager (rbenv): not found"

        [ -d "$HOME/.pyenv" ] && echo "Python Version Manager (pyenv): installed" || echo "Python Version Manager (pyenv): not found"
        [ -d "$HOME/.rustup" ] && echo "Rust toolchain (rustup): installed" || echo "Rust toolchain (rustup): not found"
        

        if [[ "$PLATFORM" == "macos" ]]; then
            # macOS specific tools
            command -v xcode-select &> /dev/null && echo "Xcode Command Line Tools: $(xcode-select --version)" || echo "Xcode Command Line Tools: not installed"
        fi
        
        echo ""
        echo "=== Common Development Tools ==="
        
        # Common tools

        command -v git &> /dev/null && echo "Git: $(git --version)" || echo "Git: not installed"
        command -v docker &> /dev/null && echo "Docker: $(docker --version)" || echo "Docker: not installed"
        command -v docker-compose &> /dev/null && echo "Docker Compose: $(docker-compose --version)" || echo "Docker Compose: not installed"
        command -v kubectl &> /dev/null && echo "Kubectl: $(kubectl version --client --short 2>/dev/null)" || echo "Kubectl: not installed"
        command -v terraform &> /dev/null && echo "Terraform: $(terraform version | head -n1)" || echo "Terraform: not installed"
        command -v ansible &> /dev/null && echo "Ansible: $(ansible --version | head -n1)" || echo "Ansible: not installed"
        command -v vim &> /dev/null && echo "Vim: $(vim --version | head -n1)" || echo "Vim: not installed"
        command -v nvim &> /dev/null && echo "Neovim: $(nvim --version | head -n1)" || echo "Neovim: not installed"
        command -v tmux &> /dev/null && echo "Tmux: $(tmux -V)" || echo "Tmux: not installed"
        command -v zsh &> /dev/null && echo "Zsh: $(zsh --version)" || echo "Zsh: not installed"
        command -v fish &> /dev/null && echo "Fish: $(fish --version)" || echo "Fish: not installed"
        command -v stow &> /dev/null && echo "GNU Stow: $(stow --version | head -n1)" || echo "GNU Stow: not installed"
        
        if [[ "$PLATFORM" == "macos" ]]; then
            command -v mas &> /dev/null && echo "Mac App Store CLI: $(mas version)" || echo "Mac App Store CLI: not installed"

        fi
        

    } > "$BACKUP_DIR/development_tools.txt"
}

# Custom installations
backup_custom_installations() {

    log_info "Backing up custom installations..."
    
    {
        echo "=== Custom/Manual Installations ==="
        echo "$(date)"

        echo ""
        
        # Check common manual installation locations

        echo "=== /usr/local/bin ==="
        ls -la /usr/local/bin/ 2>/dev/null || echo "Directory not accessible"

        
        echo ""
        echo "=== /opt directory ==="
        ls -la /opt/ 2>/dev/null || echo "Directory not accessible"
        

        echo ""
        echo "=== ~/.local/bin ==="
        ls -la "$HOME/.local/bin/" 2>/dev/null || echo "Directory not found"
        
        echo ""

        echo "=== ~/bin ==="
        ls -la "$HOME/bin/" 2>/dev/null || echo "Directory not found"
        
        if [[ "$PLATFORM" == "macos" ]]; then
            echo ""
            echo "=== /Applications ==="
            ls -la /Applications/ 2>/dev/null | grep -v "^total" || echo "Directory not accessible"
            
            echo ""
            echo "=== ~/Applications ==="
            ls -la "$HOME/Applications/" 2>/dev/null | grep -v "^total" || echo "Directory not found"
        fi
        
    } > "$BACKUP_DIR/custom_installations.txt"

}


# Configuration directories

backup_configurations() {
    log_info "Backing up configuration information..."
    
    {
        echo "=== Configuration Directories ==="
        echo "$(date)"
        echo ""
        
        # List common config directories
        echo "=== ~/.config contents ==="
        ls -la "$HOME/.config/" 2>/dev/null || echo "Directory not found"
        
        echo ""
        echo "=== Dotfiles in home directory ==="
        ls -la "$HOME/" | grep "^\."
        
        echo ""
        echo "=== SSH Configuration ==="
        ls -la "$HOME/.ssh/" 2>/dev/null || echo "SSH directory not found"
        
        if [[ "$PLATFORM" == "macos" ]]; then
            echo ""
            echo "=== ~/Library/Application Support ==="
            ls -la "$HOME/Library/Application Support/" 2>/dev/null | head -20 || echo "Directory not accessible"
        fi
        

    } > "$BACKUP_DIR/configurations.txt"
}

# Platform-specific backup
backup_platform_specific() {
    case $PLATFORM in
        "macos")
            backup_macos_specific
            ;;
        "wsl")
            backup_wsl_specific
            ;;
        "arch")
            backup_arch_specific
            ;;
    esac
}

backup_macos_specific() {
    log_info "Backing up macOS-specific information..."
    
    {
        echo "=== macOS System Information ==="
        echo "macOS Version: $(sw_vers -productVersion)"
        echo "Build Version: $(sw_vers -buildVersion)"
        echo ""
        
        echo "=== Installed Applications ==="
        system_profiler SPApplicationsDataType | grep "Location:" | sed 's/.*Location: //'
        echo ""
        
        echo "=== System Preferences ==="
        echo "# Use 'defaults read' commands to backup specific preferences"
        echo "# Example: defaults read com.apple.dock"
        echo ""
        
        echo "=== Launchd Services ==="
        launchctl list | head -20
        
    } > "$BACKUP_DIR/macos_specific.txt"
}


backup_wsl_specific() {
    log_info "Backing up WSL-specific information..."
    

    {
        echo "=== WSL Information ==="

        echo "WSL Version: $(wsl.exe --version 2>/dev/null || echo "WSL 1")"
        echo "Windows Version: $(cmd.exe /c ver 2>/dev/null || echo "Unknown")"
        echo ""
        

        echo "=== Windows Paths ==="
        echo "Windows User Profile: $(wslpath $(cmd.exe /c "echo %USERPROFILE%" 2>/dev/null | tr -d '\r') 2>/dev/null || echo "Unknown")"
        echo ""
        
        echo "=== WSL Configuration ==="
        if [ -f /etc/wsl.conf ]; then
            echo "=== /etc/wsl.conf ==="
            cat /etc/wsl.conf
        fi
        
    } > "$BACKUP_DIR/wsl_specific.txt"

}


backup_arch_specific() {

    log_info "Backing up Arch-specific information..."
    
    {
        echo "=== Arch Linux Information ==="
        echo "Kernel: $(uname -r)"
        echo ""
        
        echo "=== Pacman Configuration ==="

        if [ -f /etc/pacman.conf ]; then
            grep -v "^#" /etc/pacman.conf | grep -v "^$"
        fi
        echo ""

        
        echo "=== Systemd Services ==="
        systemctl list-unit-files --type=service | grep enabled
        
    } > "$BACKUP_DIR/arch_specific.txt"
}

# Create master restore script
create_master_restore_script() {
    log_info "Creating master restore script..."
    
    {
        echo "#!/bin/bash"
        echo "# Master System Restore Script"
        echo "# Generated on $(date)"
        echo "# Platform: $PLATFORM"

        echo "# Distribution: $DISTRO"
        echo ""
        echo "set -e  # Exit on error"
        echo ""
        echo "echo '🚀 Starting system restoration...'"
        echo ""
        
        case $PLATFORM in
            "wsl"|"debian")
                echo "# Update system"
                echo "sudo apt update && sudo apt upgrade -y"

                echo ""
                echo "# Install essential tools"
                echo "sudo apt install -y git curl wget stow"
                echo ""
                echo "# Install packages"
                echo "if [ -f './install_apt_packages.sh' ]; then"
                echo "    echo '📦 Installing APT packages...'"
                echo "    ./install_apt_packages.sh"
                echo "fi"
                ;;
            "arch")
                echo "# Update system"
                echo "sudo pacman -Syu --noconfirm"
                echo ""
                echo "# Install essential tools"
                echo "sudo pacman -S --needed --noconfirm git curl wget stow"
                echo ""
                echo "# Install packages"
                echo "if [ -f './install_pacman_packages.sh' ]; then"
                echo "    echo '📦 Installing Pacman packages...'"
                echo "    ./install_pacman_packages.sh"
                echo "fi"
                ;;
            "macos")
                echo "# Install Homebrew if not present"
                echo 'if ! command -v brew &> /dev/null; then'
                echo '    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
                echo 'fi'
                echo ""
                echo "# Install essential tools"
                echo "brew install git curl wget stow"
                echo ""
                echo "# Install packages"
                echo "if [ -f './install_homebrew_packages.sh' ]; then"
                echo "    echo '📦 Installing Homebrew packages...'"
                echo "    ./install_homebrew_packages.sh"
                echo "fi"
                ;;
            "redhat")
                echo "# Update system"
                echo "sudo yum update -y"
                echo ""
                echo "# Install essential tools"
                echo "sudo yum install -y git curl wget"
                echo ""
                echo "# Install packages"
                echo "if [ -f './install_yum_packages.sh' ]; then"
                echo "    echo '📦 Installing YUM packages...'"
                echo "    ./install_yum_packages.sh"

                echo "fi"
                ;;
        esac
        
        echo ""

        echo "# Install language-specific packages"
        echo "if [ -f './install_pip_packages.sh' ]; then"
        echo "    echo '🐍 Installing Python packages...'"
        echo "    ./install_pip_packages.sh"

        echo "fi"
        echo ""
        echo "if [ -f './install_npm_packages.sh' ]; then"
        echo "    echo '📦 Installing Node.js packages...'"
        echo "    ./install_npm_packages.sh"
        echo "fi"

        echo ""
        echo "if [ -f './install_ruby_gems.sh' ]; then"
        echo "    echo '💎 Installing Ruby gems...'"
        echo "    ./install_ruby_gems.sh"
        echo "fi"
        echo ""
        echo "if [ -f './install_cargo_packages.sh' ]; then"
        echo "    echo '🦀 Installing Rust packages...'"

        echo "    ./install_cargo_packages.sh"
        echo "fi"
        echo ""

        echo "echo '✅ System restoration complete!'"
        echo "echo '📋 Manual steps may be needed for:'"
        echo "echo '  - Custom installations (see custom_installations.txt)'"
        echo "echo '  - Development tools (see development_tools.txt)'"

        echo "echo '  - Configurations (see configurations.txt)'"
        echo "echo '  - SSH keys and Git credentials'"

        echo "echo '  - Dotfiles setup'"
        

    } > "$BACKUP_DIR/master_restore.sh"
    
    chmod +x "$BACKUP_DIR/master_restore.sh"

}

# Main execution
main() {
    collect_system_info
    
    # Platform-specific package managers
    case $PLATFORM in
        "wsl"|"debian")
            backup_apt_packages

            ;;
        "arch")
            backup_pacman_packages
            ;;
        "macos")
            backup_homebrew_packages
            ;;
        "redhat")
            backup_yum_packages

            ;;
    esac
    
    # Common across all platforms
    backup_language_packages
    backup_development_tools
    backup_custom_installations
    backup_configurations
    backup_platform_specific
    
    create_master_restore_script
    
    # Create summary README

    {

        echo "# System Backup"
        echo "Generated on: $(date)"
        echo "Platform: $PLATFORM"
        echo "Distribution: $DISTRO"

        echo "User: $(whoami)"

        echo ""
        echo "## Contents"
        echo ""
        echo "### Package Lists"
        echo "- \`*_packages.txt\` - Lists of installed packages"
        echo "- \`install_*_packages.sh\` - Reinstall scripts for each package manager"
        echo ""
        echo "### System Information"

        echo "- \`system_info.txt\` - System details and environment info"
        echo "- \`development_tools.txt\` - Development tools and version managers"
        echo "- \`custom_installations.txt\` - Manual installations and custom tools"
        echo "- \`configurations.txt\` - Configuration directories and dotfiles"
        echo "- \`${PLATFORM}_specific.txt\` - Platform-specific information"
        echo ""

        echo "### Restoration"
        echo "- \`master_restore.sh\` - Main script to restore environment"
        echo ""
        echo "## Usage"
        echo ""

        echo "1. After fresh system installation, copy this backup directory"
        echo "2. Run: \`./master_restore.sh\`"
        echo "3. Manually install items from custom_installations.txt"
        echo "4. Clone and setup your dotfiles repository"
        echo "5. Restore SSH keys and Git configuration"

        echo ""
        echo "## Platform Notes"
        echo ""
        if [[ "$PLATFORM" == "macos" ]]; then
            echo "- Use Homebrew bundle for most packages"

            echo "- Check Mac App Store for GUI applications"

        elif [[ "$PLATFORM" == "arch" ]]; then
            echo "- AUR packages need manual installation"

            echo "- Check systemd services"
        elif [[ "$PLATFORM" == "wsl" ]]; then
            echo "- Windows-specific configurations in wsl_specific.txt"
            echo "- Consider Windows software backup separately"
        fi
        echo ""
        echo "## Important"

        echo ""
        echo "- Review all scripts before running them"
        echo "- Package names/versions may have changed"
        echo "- Manual verification recommended"
        echo ""
    } > "$BACKUP_DIR/README.md"
    

    log_success "✅ Cross-platform backup complete!"
    log_info "📁 Backup created in: $BACKUP_DIR"
    log_info "💾 To commit to git: cd $BACKUP_DIR && git add . && git commit -m 'System backup $(date)'"

}

# Run main function

main "$@"
