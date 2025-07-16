#!/bin/bash
# smart-stow.sh - Intelligent dotfiles management with history preservation

set -euo pipefail


DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.local/share/dotfiles-backup"
HISTORY_FILE="$HOME/.zsh_history"
DOTFILES_HISTORY="$DOTFILES_DIR/.zsh_history"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup current history
backup_history() {
    if [ -f "$HISTORY_FILE" ] && [ -s "$HISTORY_FILE" ]; then
        local backup_file="$BACKUP_DIR/zsh_history.$(date +%Y%m%d_%H%M%S)"
        cp "$HISTORY_FILE" "$backup_file"
        log "Backed up current history to: $backup_file"
        
        # Keep only last 10 backups
        find "$BACKUP_DIR" -name "zsh_history.*" -type f | sort -r | tail -n +11 | xargs rm -f
        
        return 0

    else
        warn "No current history file found or it's empty"
        return 1
    fi
}

# Function to merge histories
merge_histories() {
    local temp_file=$(mktemp)
    
    # Combine both histories if they exist
    if [ -f "$HISTORY_FILE" ] && [ -s "$HISTORY_FILE" ]; then
        cat "$HISTORY_FILE" >> "$temp_file"

    fi
    

    if [ -f "$DOTFILES_HISTORY" ] && [ -s "$DOTFILES_HISTORY" ]; then
        cat "$DOTFILES_HISTORY" >> "$temp_file"
    fi
    
    # Remove duplicates while preserving order and format
    if [ -s "$temp_file" ]; then

        # Sort by timestamp and remove duplicates
        sort -u "$temp_file" > "$DOTFILES_HISTORY"
        log "Merged and deduplicated history files"
    fi
    
    rm -f "$temp_file"
}

# Function to restore history if it gets wiped
restore_history() {
    if [ ! -s "$HISTORY_FILE" ]; then
        if [ -f "$DOTFILES_HISTORY" ] && [ -s "$DOTFILES_HISTORY" ]; then
            cp "$DOTFILES_HISTORY" "$HISTORY_FILE"
            log "Restored history from dotfiles"
        else
            local latest_backup=$(find "$BACKUP_DIR" -name "zsh_history.*" -type f | sort -r | head -1)
            if [ -n "$latest_backup" ]; then
                cp "$latest_backup" "$HISTORY_FILE"
                log "Restored history from backup: $latest_backup"
            else
                warn "No backup found to restore history"

            fi
        fi
    fi
}

# Main stow function

smart_stow() {
    cd "$DOTFILES_DIR"
    
    log "Starting smart stow process..."
    
    # Step 1: Backup current history
    backup_history
    
    # Step 2: Merge histories before stowing
    merge_histories
    
    # Step 3: Run stow with adopt
    log "Running stow --adopt..."
    if stow --adopt . 2>&1; then
        log "Stow completed successfully"
    else

        error "Stow failed"
        exit 1
    fi
    
    # Step 4: Restore history if it was wiped
    restore_history
    
    # Step 5: Update dotfiles history for next time
    if [ -f "$HISTORY_FILE" ] && [ -s "$HISTORY_FILE" ]; then
        cp "$HISTORY_FILE" "$DOTFILES_HISTORY"
        log "Updated dotfiles history"
    fi
    
    log "Smart stow completed successfully!"

}


# Function to set up .stow-local-ignore
setup_stow_ignore() {
    local ignore_file="$DOTFILES_DIR/.stow-local-ignore"
    
    if [ ! -f "$ignore_file" ]; then
        log "Creating .stow-local-ignore file..."
        cat > "$ignore_file" << EOF
# Git files
.git
.gitignore
.gitmodules
README.md

# History files (managed separately)

.zsh_history
.bash_history

# Backup files
*.bak

*.backup
*~

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
EOF
        log "Created .stow-local-ignore"
    else
        log ".stow-local-ignore already exists"
    fi
}

# Function to show usage
usage() {
    cat << EOF
Usage: $0 [OPTION]

Options:
    -s, --stow      Run smart stow (default)
    -i, --ignore    Set up .stow-local-ignore file
    -b, --backup    Backup current history only
    -r, --restore   Restore history from backup
    -h, --help      Show this help message


Examples:
    $0              # Run smart stow

    $0 --ignore     # Set up ignore file
    $0 --backup     # Backup current history
EOF
}

# Parse command line arguments
case "${1:-}" in
    -s|--stow)

        smart_stow
        ;;
    -i|--ignore)

        setup_stow_ignore
        ;;
    -b|--backup)

        backup_history
        ;;
    -r|--restore)
        restore_history

        ;;
    -h|--help)

        usage

        ;;
    "")
        smart_stow

        ;;
    *)

        error "Unknown option: $1"
        usage
        exit 1
        ;;

esac
