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

# Function to check if system is fresh (no existing history)
is_fresh_system() {
    if [ ! -f "$HISTORY_FILE" ] || [ ! -s "$HISTORY_FILE" ]; then

        return 0  # Fresh system - no history file or empty history file
    fi
    return 1  # History exists
}

# Function to backup current history
backup_history() {
    if [ -f "$HISTORY_FILE" ] && [ -s "$HISTORY_FILE" ]; then
        local backup_file="$BACKUP_DIR/zsh_history.$(date +%Y%m%d_%H%M%S)"
        cp "$HISTORY_FILE" "$backup_file"
        log "Backed up current history to: $backup_file"
        
        # Keep only last 10 backups
        find "$BACKUP_DIR" -name "zsh_history.*" -type f | sort -r | tail -n +11 | xargs rm -f 2>/dev/null || true
        
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


# Verify stow operation success
verify_stow() {
    local expected_files=(".tmux.conf" ".zshrc" ".bashrc" ".vimrc" ".gitconfig")
    local linked_count=0
    

    log "Verifying stow operation..."
    
    for file in "${expected_files[@]}"; do
        local full_path="$HOME/$file"
        if [ -L "$full_path" ] || [ -f "$full_path" ]; then

            log "✓ Found: $file"

            ((linked_count++))
        fi
    done

    
    if [ $linked_count -gt 0 ]; then
        log "✓ Stow verification successful: $linked_count config files found"
        return 0
    else
        error "Stow verification failed: No expected config files found"
        return 1
    fi
}

# Main stow function with improved error handling
smart_stow() {
    cd "$DOTFILES_DIR" || {
        error "Cannot change to dotfiles directory: $DOTFILES_DIR"
        exit 1
    }
    
    log "Starting smart stow process..."
    

    # Verify stow is available
    if ! command -v stow >/dev/null 2>&1; then

        error "stow command not found - please install GNU stow"

        exit 1
    fi
    
    # Check if this is a fresh system
    if is_fresh_system; then
        log "Fresh system detected - no existing zsh history found"
        log "Skipping history operations, proceeding directly to stow..."
        
        # Run stow with adopt directly
        log "Running stow --adopt..."
        if stow --adopt . 2>&1; then
            log "Stow completed successfully"
        else

            error "Stow failed"
            exit 1
        fi
        
        # Verify stow worked
        if ! verify_stow; then
            error "Stow verification failed"

            exit 1
        fi
        
        # If dotfiles contain a history file, set it up (only if different files)
        if [ -f "$DOTFILES_HISTORY" ] && [ -s "$DOTFILES_HISTORY" ]; then
            # Check if they're the same file (after stow linking)
            if [ ! -f "$HISTORY_FILE" ] || [ "$DOTFILES_HISTORY" -ef "$HISTORY_FILE" ]; then
                log "History file already linked or doesn't exist - no copy needed"
            else

                cp "$DOTFILES_HISTORY" "$HISTORY_FILE"
                log "Initialized history from dotfiles"

            fi
        fi
        
        log "Smart stow completed successfully on fresh system!"

        return
    fi
    
    # Existing system with history - run full process
    log "Existing system detected - running full history management"
    
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
    
    # Step 4: Verify stow worked
    if ! verify_stow; then
        error "Stow verification failed"
        exit 1
    fi
    
    # Step 5: Restore history if it was wiped
    restore_history
    
    # Step 6: Update dotfiles history for next time (only if different files)
    if [ -f "$HISTORY_FILE" ] && [ -s "$HISTORY_FILE" ]; then
        # Check if they're the same file (after stow linking)
        if [ "$DOTFILES_HISTORY" -ef "$HISTORY_FILE" ]; then
            log "History files are already linked - no copy needed"

        else
            cp "$HISTORY_FILE" "$DOTFILES_HISTORY"
            log "Updated dotfiles history"
        fi
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


# Scripts
setup-dotfiles.sh
.local/bin/smart-stow.sh

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
    -v, --verify    Verify stow operation
    -h, --help      Show this help message


Examples:
    $0              # Run smart stow
    $0 --ignore     # Set up ignore file
    $0 --backup     # Backup current history
    $0 --verify     # Verify stow worked
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
    -v|--verify)
        verify_stow
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
