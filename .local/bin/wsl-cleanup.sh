#!/bin/bash

# Enhanced WSL System Cleanup Script
# Focuses on finding largest unused items efficiently


set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

BLUE='\033[0;34m'

PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Enhanced WSL Cleanup Tool ===${NC}"
echo ""


# Function to check if running in WSL

check_wsl() {
    if ! grep -q microsoft /proc/version 2>/dev/null; then
        echo -e "${RED}Warning: This doesn't appear to be running in WSL${NC}"
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Function to show disk usage summary
show_disk_usage() {
    echo -e "${BLUE}=== Current Disk Usage ===${NC}"
    df -h / | head -2
    echo ""
}


# Function to find largest directories by size (optimized)
find_largest_directories() {

    echo -e "${BLUE}=== Top 15 Largest Directories ===${NC}"

    echo "Scanning directories (this may take a moment)..."
    
    # Use find with maxdepth to speed up and exclude problematic directories
    {
        find /home /var /usr /opt -maxdepth 3 -type d 2>/dev/null | head -100 | xargs -I {} du -sh {} 2>/dev/null
        find /tmp /var/tmp -maxdepth 2 -type d 2>/dev/null | xargs -I {} du -sh {} 2>/dev/null
    } | sort -rh | head -15
    echo ""
}


# Function to find largest files (optimized)
find_largest_files() {
    echo -e "${BLUE}=== Top 15 Largest Files ===${NC}"
    echo "Scanning for large files..."
    
    # Find files larger than 50MB, exclude system areas that are usually safe
    find /home /var /usr /opt /tmp -type f -size +50M 2>/dev/null | head -30 | xargs -I {} ls -lh {} 2>/dev/null | sort -k5 -rh | head -15
    echo ""
}

# Function to check specific potentially unused directories
check_unused_directories() {
    echo -e "${BLUE}=== Checking Potentially Unused Directories ===${NC}"
    

    # Check common directories that might be unused

    declare -a check_dirs=(

        "/home/$USER/deepseek_env"
        "/home/$USER/powerlevel10k"
        "/home/$USER/.cache"
        "/home/$USER/.npm"
        "/home/$USER/.local/share"

        "/home/$USER/.config"
        "/home/$USER/neovim"
        "/home/$USER/nvim-linux64"
        "/var/log"

        "/var/cache"
        "/tmp"
    )
    
    for dir in "${check_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            last_modified=$(find "$dir" -type f -printf '%T@\n' 2>/dev/null | sort -n | tail -1)
            if [[ -n "$last_modified" ]]; then

                last_date=$(date -d "@$last_modified" +"%Y-%m-%d" 2>/dev/null || echo "unknown")

                echo -e "${YELLOW}$dir${NC} - ${GREEN}$size${NC} - Last modified: ${CYAN}$last_date${NC}"
            else
                echo -e "${YELLOW}$dir${NC} - ${GREEN}$size${NC} - ${RED}Empty or inaccessible${NC}"

            fi
        fi
    done
    echo ""
}

# Function to analyze package usage (optimized)
analyze_package_usage() {
    echo -e "${BLUE}=== Package Analysis ===${NC}"
    
    # Get top 20 largest packages quickly
    echo -e "${YELLOW}Top 20 largest installed packages:${NC}"
    dpkg-query -Wf '${Package}\t${Installed-Size}\n' 2>/dev/null | sort -k2 -nr | head -20 | while read package size; do
        size_mb=$((size / 1024))
        echo -e "${GREEN}$package${NC} - ${size_mb} MB"
    done
    echo ""
    
    # Quick check for development packages

    echo -e "${YELLOW}Development packages (review if not actively developing):${NC}"
    dpkg -l 2>/dev/null | grep -E "(dev|devel)" | wc -l | xargs -I {} echo "Found {} development packages"
    dpkg -l 2>/dev/null | grep -E "(dev|devel)" | head -5 | awk '{print $2}' | while read pkg; do
        size=$(dpkg-query -Wf '${Installed-Size}' "$pkg" 2>/dev/null || echo "0")
        size_mb=$((size / 1024))
        echo -e "${CYAN}$pkg${NC} - ${size_mb} MB"
    done

    echo ""

}


# Function to check for orphaned packages
check_orphaned_packages() {
    echo -e "${BLUE}=== Orphaned Packages Check ===${NC}"
    
    # Install deborphan if not present (lightweight check)
    if ! command -v deborphan &> /dev/null; then
        echo "Installing deborphan for orphan detection..."
        sudo apt update -qq && sudo apt install -y deborphan -qq
    fi
    
    orphans=$(deborphan 2>/dev/null)
    if [[ -n "$orphans" ]]; then
        echo -e "${YELLOW}Orphaned packages found:${NC}"

        echo "$orphans" | head -10
        echo ""
        orphan_count=$(echo "$orphans" | wc -l)
        echo -e "${CYAN}Total orphaned packages: $orphan_count${NC}"

    else
        echo -e "${GREEN}No orphaned packages found${NC}"
    fi

    echo ""

    
    # Check autoremovable packages
    autoremove_info=$(apt list --installed 2>/dev/null | grep -E '\[.*auto.*removable\]' | head -10)
    if [[ -n "$autoremove_info" ]]; then
        echo -e "${YELLOW}Auto-removable packages:${NC}"
        echo "$autoremove_info"
    else
        echo -e "${GREEN}No auto-removable packages found${NC}"
    fi
    echo ""
}

# Function to check cache sizes
check_cache_sizes() {
    echo -e "${BLUE}=== Cache Directory Sizes ===${NC}"
    
    declare -a cache_dirs=(
        "/var/cache/apt"
        "/home/$USER/.cache"
        "/home/$USER/.npm"
        "/tmp"
        "/var/tmp"
    )
    
    for dir in "${cache_dirs[@]}"; do
        if [[ -d "$dir" ]]; then

            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            echo -e "${YELLOW}$dir${NC} - ${GREEN}$size${NC}"
        fi
    done
    echo ""
}

# Function to provide quick cleanup options
quick_cleanup() {
    echo -e "${BLUE}=== Quick Cleanup Options ===${NC}"
    echo "1. Remove orphaned packages"

    echo "2. Clean package cache"
    echo "3. Clean user cache (~/.cache)"
    echo "4. Clean npm cache"
    echo "5. Remove old logs"
    echo "6. Clean temp files"
    echo "7. All of the above"
    echo "8. Skip cleanup"
    echo ""
    
    read -p "Select cleanup option (1-8): " cleanup_choice
    
    case $cleanup_choice in
        1|7)
            echo -e "${YELLOW}Removing orphaned packages...${NC}"
            sudo apt autoremove -y
            if command -v deborphan &> /dev/null; then
                orphans=$(deborphan 2>/dev/null)
                if [[ -n "$orphans" ]]; then

                    echo "$orphans" | xargs sudo apt-get -y remove --purge
                fi
            fi
            ;;

    esac
    
    case $cleanup_choice in
        2|7)
            echo -e "${YELLOW}Cleaning package cache...${NC}"
            sudo apt clean
            sudo apt autoclean
            ;;
    esac
    
    case $cleanup_choice in
        3|7)
            echo -e "${YELLOW}Cleaning user cache...${NC}"
            if [[ -d "$HOME/.cache" ]]; then
                rm -rf "$HOME/.cache"/* 2>/dev/null || true
                echo "Cleaned ~/.cache"
            fi
            ;;
    esac
    
    case $cleanup_choice in
        4|7)
            echo -e "${YELLOW}Cleaning npm cache...${NC}"
            if command -v npm &> /dev/null; then

                npm cache clean --force 2>/dev/null || true
            fi
            ;;
    esac
    
    case $cleanup_choice in
        5|7)
            echo -e "${YELLOW}Cleaning logs...${NC}"
            sudo journalctl --vacuum-time=7d 2>/dev/null || true
            sudo find /var/log -type f -name "*.log" -mtime +30 -delete 2>/dev/null || true
            ;;
    esac
    
    case $cleanup_choice in
        6|7)
            echo -e "${YELLOW}Removing temp files...${NC}"
            sudo rm -rf /tmp/* 2>/dev/null || true
            sudo rm -rf /var/tmp/* 2>/dev/null || true
            ;;
    esac
    
    if [ "$cleanup_choice" != "8" ]; then
        echo -e "${GREEN}Cleanup completed!${NC}"
        echo ""

        echo -e "${BLUE}New disk usage:${NC}"

        df -h / | head -2
    fi
}

# Function to show specific removal suggestions
show_removal_suggestions() {
    echo -e "${BLUE}=== Specific Removal Suggestions ===${NC}"

    echo ""

    
    # Check for your specific directories
    if [[ -d "/home/$USER/deepseek_env" ]]; then

        size=$(du -sh "/home/$USER/deepseek_env" | cut -f1)
        echo -e "${YELLOW}deepseek_env${NC} - ${GREEN}$size${NC} - ${RED}Consider removing if not used${NC}"
        echo "  Command: rm -rf ~/deepseek_env"
    fi
    
    if [[ -d "/home/$USER/powerlevel10k" ]]; then
        size=$(du -sh "/home/$USER/powerlevel10k" | cut -f1)
        echo -e "${YELLOW}powerlevel10k${NC} - ${GREEN}$size${NC} - ${RED}Consider removing if using package manager version${NC}"
        echo "  Command: rm -rf ~/powerlevel10k"

    fi
    

    # Check for download files
    if [[ -f "/home/$USER/google-chrome-stable_current_amd64.deb" ]]; then
        size=$(du -sh "/home/$USER/google-chrome-stable_current_amd64.deb" | cut -f1)
        echo -e "${YELLOW}google-chrome-stable_current_amd64.deb${NC} - ${GREEN}$size${NC} - ${RED}Remove after installation${NC}"
        echo "  Command: rm ~/google-chrome-stable_current_amd64.deb"
    fi
    
    if [[ -f "/home/$USER/lazygit.tar.gz" ]]; then
        size=$(du -sh "/home/$USER/lazygit.tar.gz" | cut -f1)
        echo -e "${YELLOW}lazygit.tar.gz${NC} - ${GREEN}$size${NC} - ${RED}Remove after extraction${NC}"
        echo "  Command: rm ~/lazygit.tar.gz"
    fi
    
    # Check for duplicate nvim files

    if [[ -f "/home/$USER/nvim-linux64.tar.gz" ]] && [[ -f "/home/$USER/nvim-linux64.tar.gz.1" ]]; then
        echo -e "${YELLOW}Duplicate nvim archives found${NC} - ${RED}Remove duplicates${NC}"
        echo "  Command: rm ~/nvim-linux64.tar.gz.1"
    fi
    
    echo ""
}

# Main execution
main() {
    check_wsl
    show_disk_usage
    find_largest_directories
    find_largest_files
    check_unused_directories
    analyze_package_usage
    check_orphaned_packages
    check_cache_sizes
    show_removal_suggestions
    
    echo ""
    read -p "Would you like to perform cleanup now? (y/N): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        quick_cleanup
    fi
    
    echo ""
    echo -e "${GREEN}System analysis complete!${NC}"
    echo -e "${YELLOW}Remember to backup important data before removing anything.${NC}"
}

# Run main function
main
