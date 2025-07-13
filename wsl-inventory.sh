#!/bin/bash

# WSL Dependency Inventory Script
# This script catalogs all installed packages and dependencies in your WSL environment


OUTPUT_DIR="$HOME/wsl-backup"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$OUTPUT_DIR/backup_$DATE"

# Create output directory
mkdir -p "$BACKUP_DIR"

echo "🔍 Starting WSL dependency inventory..."
echo "📁 Output directory: $BACKUP_DIR"


# Function to detect Linux distribution
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

DISTRO=$(detect_distro)
echo "📋 Detected distribution: $DISTRO"


# 1. System Information
echo "💻 Collecting system information..."
{
    echo "=== System Information ==="
    echo "Date: $(date)"

    echo "Distribution: $DISTRO"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Home: $HOME"
    echo "Shell: $SHELL"

    echo ""

} > "$BACKUP_DIR/system_info.txt"


# 2. Package Manager Packages
echo "📦 Collecting package manager installations..."

if command -v apt &> /dev/null; then
    echo "🔸 APT packages..."

    apt list --installed 2>/dev/null | grep -v "WARNING" > "$BACKUP_DIR/apt_packages.txt"
    
    # Create reinstall script for apt
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

if command -v yum &> /dev/null; then
    echo "🔸 YUM packages..."
    yum list installed > "$BACKUP_DIR/yum_packages.txt"
    
    # Create reinstall script for yum
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

if command -v pacman &> /dev/null; then

    echo "🔸 Pacman packages..."
    pacman -Q > "$BACKUP_DIR/pacman_packages.txt"
    
    # Create reinstall script for pacman
    {

        echo "#!/bin/bash"

        echo "# Pacman package reinstall script"

        echo "# Generated on $(date)"
        echo ""
        echo "sudo pacman -S --needed \\"
        pacman -Q | awk '{print $1}' | sort | sed 's/$/  \\/' | sed '$s/ \\$//'
    } > "$BACKUP_DIR/install_pacman_packages.sh"
    chmod +x "$BACKUP_DIR/install_pacman_packages.sh"
fi


# 3. Language-specific package managers
echo "🐍 Collecting language-specific packages..."

# Python packages

if command -v pip &> /dev/null; then

    echo "🔸 Python (pip) packages..."
    pip list --format=freeze > "$BACKUP_DIR/pip_packages.txt"
    
    {
        echo "#!/bin/bash"
        echo "# Python pip packages reinstall script"
        echo "# Generated on $(date)"
        echo ""
        echo "pip install -r pip_packages.txt"
    } > "$BACKUP_DIR/install_pip_packages.sh"
    chmod +x "$BACKUP_DIR/install_pip_packages.sh"

fi


if command -v pip3 &> /dev/null; then
    echo "🔸 Python3 (pip3) packages..."
    pip3 list --format=freeze > "$BACKUP_DIR/pip3_packages.txt"
    
    {
        echo "#!/bin/bash"
        echo "# Python3 pip3 packages reinstall script"
        echo "# Generated on $(date)"
        echo ""
        echo "pip3 install -r pip3_packages.txt"
    } > "$BACKUP_DIR/install_pip3_packages.sh"
    chmod +x "$BACKUP_DIR/install_pip3_packages.sh"
fi


# Node.js packages
if command -v npm &> /dev/null; then
    echo "🔸 Node.js (npm) global packages..."
    npm list -g --depth=0 > "$BACKUP_DIR/npm_global_packages.txt"
    
    {
        echo "#!/bin/bash"
        echo "# NPM global packages reinstall script"
        echo "# Generated on $(date)"
        echo ""

        echo "# Install global packages:"

        npm list -g --depth=0 --parseable --long 2>/dev/null | grep -v "^$HOME/.nvm" | cut -d: -f2 | grep -v "^$" | sort | sed 's/^/npm install -g /'
    } > "$BACKUP_DIR/install_npm_packages.sh"
    chmod +x "$BACKUP_DIR/install_npm_packages.sh"
fi


# Ruby gems
if command -v gem &> /dev/null; then
    echo "🔸 Ruby gems..."
    gem list > "$BACKUP_DIR/ruby_gems.txt"

    
    {

        echo "#!/bin/bash"

        echo "# Ruby gems reinstall script"
        echo "# Generated on $(date)"
        echo ""
        echo "# Install gems:"
        gem list | grep -v "^$" | sed 's/ (.*//' | sed 's/^/gem install /'
    } > "$BACKUP_DIR/install_ruby_gems.sh"

    chmod +x "$BACKUP_DIR/install_ruby_gems.sh"
fi


# Go packages
if command -v go &> /dev/null && [ -d "$HOME/go" ]; then
    echo "🔸 Go packages..."
    find "$HOME/go/bin" -type f -executable 2>/dev/null > "$BACKUP_DIR/go_binaries.txt"
    
    {
        echo "#!/bin/bash"
        echo "# Go packages reinstall script"
        echo "# Generated on $(date)"
        echo ""
        echo "# Note: Go binaries found in ~/go/bin"
        echo "# You may need to reinstall these manually:"
        find "$HOME/go/bin" -type f -executable 2>/dev/null | sed 's/^/# /'
    } > "$BACKUP_DIR/install_go_packages.sh"
    chmod +x "$BACKUP_DIR/install_go_packages.sh"
fi


# Rust/Cargo packages
if command -v cargo &> /dev/null; then

    echo "🔸 Rust/Cargo packages..."
    cargo install --list > "$BACKUP_DIR/cargo_packages.txt"

    

    {

        echo "#!/bin/bash"
        echo "# Cargo packages reinstall script"

        echo "# Generated on $(date)"

        echo ""
        echo "# Install cargo packages:"
        cargo install --list | grep -E "^[a-zA-Z]" | awk '{print $1}' | sed 's/^/cargo install /'
    } > "$BACKUP_DIR/install_cargo_packages.sh"

    chmod +x "$BACKUP_DIR/install_cargo_packages.sh"
fi

# 4. Development tools and version managers
echo "🛠️ Collecting development tools..."

# Check for common development tools
{
    echo "=== Development Tools ==="
    echo "$(date)"
    echo ""
    
    # Version managers
    [ -d "$HOME/.nvm" ] && echo "Node Version Manager (nvm): installed" || echo "Node Version Manager (nvm): not found"
    [ -d "$HOME/.rbenv" ] && echo "Ruby Version Manager (rbenv): installed" || echo "Ruby Version Manager (rbenv): not found"
    [ -d "$HOME/.pyenv" ] && echo "Python Version Manager (pyenv): installed" || echo "Python Version Manager (pyenv): not found"
    [ -d "$HOME/.rustup" ] && echo "Rust toolchain (rustup): installed" || echo "Rust toolchain (rustup): not found"
    
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

    
} > "$BACKUP_DIR/development_tools.txt"


# 5. Custom installations and manual builds
echo "🔧 Collecting custom installations..."


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

    

} > "$BACKUP_DIR/custom_installations.txt"


# 6. Configuration directories
echo "⚙️ Collecting configuration info..."

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
    
} > "$BACKUP_DIR/configurations.txt"

# 7. Create master reinstall script
echo "🚀 Creating master reinstall script..."

{
    echo "#!/bin/bash"
    echo "# Master WSL Reinstall Script"
    echo "# Generated on $(date)"
    echo "# Distribution: $DISTRO"
    echo ""
    echo "set -e  # Exit on error"
    echo ""
    echo "echo '🚀 Starting WSL environment restoration...'"
    echo ""
    echo "# Update system first"
    
    case $DISTRO in
        ubuntu|debian)
            echo "sudo apt update && sudo apt upgrade -y"
            echo ""
            echo "# Install packages"
            echo "if [ -f './install_apt_packages.sh' ]; then"
            echo "    echo '📦 Installing APT packages...'"
            echo "    ./install_apt_packages.sh"
            echo "fi"
            ;;
        centos|rhel|fedora)
            echo "sudo yum update -y"
            echo ""
            echo "# Install packages"
            echo "if [ -f './install_yum_packages.sh' ]; then"
            echo "    echo '📦 Installing YUM packages...'"
            echo "    ./install_yum_packages.sh"
            echo "fi"

            ;;

        arch)
            echo "sudo pacman -Syu --noconfirm"
            echo ""
            echo "# Install packages"
            echo "if [ -f './install_pacman_packages.sh' ]; then"
            echo "    echo '📦 Installing Pacman packages...'"

            echo "    ./install_pacman_packages.sh"
            echo "fi"
            ;;
    esac

    
    echo ""
    echo "# Install Python packages"
    echo "if [ -f './install_pip_packages.sh' ]; then"

    echo "    echo '🐍 Installing Python packages...'"
    echo "    ./install_pip_packages.sh"
    echo "fi"
    echo ""
    echo "# Install Node.js packages"
    echo "if [ -f './install_npm_packages.sh' ]; then"

    echo "    echo '📦 Installing Node.js packages...'"
    echo "    ./install_npm_packages.sh"
    echo "fi"

    echo ""

    echo "# Install Ruby gems"
    echo "if [ -f './install_ruby_gems.sh' ]; then"

    echo "    echo '💎 Installing Ruby gems...'"

    echo "    ./install_ruby_gems.sh"
    echo "fi"
    echo ""
    echo "# Install Rust packages"

    echo "if [ -f './install_cargo_packages.sh' ]; then"
    echo "    echo '🦀 Installing Rust packages...'"
    echo "    ./install_cargo_packages.sh"
    echo "fi"
    echo ""
    echo "echo '✅ WSL environment restoration complete!'"
    echo "echo '📋 Check the following files for manual installations:'"
    echo "echo '  - custom_installations.txt'"
    echo "echo '  - development_tools.txt'"
    echo "echo '  - configurations.txt'"
    echo ""

    echo "echo '🔗 Don'\''t forget to:'"
    echo "echo '  1. Clone and setup your dotfiles'"

    echo "echo '  2. Restore SSH keys'"

    echo "echo '  3. Configure Git credentials'"

    echo "echo '  4. Setup development environments'"
    
} > "$BACKUP_DIR/master_reinstall.sh"
chmod +x "$BACKUP_DIR/master_reinstall.sh"


# 8. Create README
{
    echo "# WSL Environment Backup"

    echo "Generated on: $(date)"
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
    echo ""
    echo "### Restoration"
    echo "- \`master_reinstall.sh\` - Main script to restore environment"
    echo ""
    echo "## Usage"

    echo ""

    echo "1. After fresh WSL installation, copy this backup directory"
    echo "2. Run: \`./master_reinstall.sh\`"
    echo "3. Manually install items from custom_installations.txt"
    echo "4. Clone and setup your dotfiles repository"

    echo "5. Restore SSH keys and Git configuration"
    echo ""
    echo "## Notes"

    echo ""

    echo "- This script captures most package manager installations"
    echo "- Manual installations may need special attention"
    echo "- Always review scripts before running them"
    echo "- Some packages might have changed names or versions"
    echo ""
} > "$BACKUP_DIR/README.md"


echo ""

echo "✅ WSL dependency inventory complete!"
echo "📁 Backup created in: $BACKUP_DIR"
echo ""
echo "📋 Summary of files created:"
echo "  - system_info.txt (system information)"
echo "  - *_packages.txt (package lists)"
echo "  - install_*_packages.sh (reinstall scripts)"
echo "  - development_tools.txt (dev tools inventory)"

echo "  - custom_installations.txt (manual installations)"
echo "  - configurations.txt (config directories)"
echo "  - master_reinstall.sh (main restore script)"

echo "  - README.md (documentation)"

echo ""
echo "🚀 To restore on fresh WSL:"

echo "  1. Copy the backup directory to new WSL"
echo "  2. Run: cd $BACKUP_DIR && ./master_reinstall.sh"
echo "  3. Clone your dotfiles and run stow"

echo ""
echo "💡 Consider committing the backup to a private repository for safekeeping!"
