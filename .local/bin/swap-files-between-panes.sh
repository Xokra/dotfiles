#!/bin/bash

# Script to swap current nvim file with another tmux pane
# Usage: ./swap-files-between-panes.sh <direction>
# Directions: up, down, left, right


# Function to get current file and cursor position from a pane
get_pane_info() {
    local pane=$1
    

    # Get current file
    tmux send-keys -t "$pane" 'C-c' # Ensure normal mode
    tmux send-keys -t "$pane" ':echo @%' Enter
    sleep 0.1
    local file=$(tmux capture-pane -t "$pane" -p | tail -1 | sed 's/\x1b\[[0-9;]*m//g' | tr -d '\r')
    
    # Get cursor position
    tmux send-keys -t "$pane" ':echo line(".") . "," . col(".")' Enter
    sleep 0.1
    local cursor=$(tmux capture-pane -t "$pane" -p | tail -1 | sed 's/\x1b\[[0-9;]*m//g' | tr -d '\r')
    
    echo "$file|$cursor"
}

# Function to open file in pane with cursor position
open_file_in_pane() {
    local pane=$1

    local file=$2
    local cursor=$3
    
    if [ "$file" = "[No Name]" ] || [ -z "$file" ]; then
        tmux send-keys -t "$pane" ':enew' Enter
    else
        tmux send-keys -t "$pane" ":e $file" Enter
    fi
    
    # Wait for file to load
    sleep 0.3
    

    # Restore cursor position
    if [[ "$cursor" =~ ^[0-9]+,[0-9]+$ ]]; then
        tmux send-keys -t "$pane" ":call cursor($cursor)" Enter

    fi
}

# Check if we're in a tmux session

if [ -z "$TMUX" ]; then
    echo "Error: Not in a tmux session"

    exit 1
fi

# Get direction parameter
direction=$1
if [ -z "$direction" ]; then
    echo "Usage: $0 <direction>"
    echo "Directions: up, down, left, right"
    exit 1
fi

# Get current pane
current_pane=$(tmux display-message -p '#P')

# Map direction to tmux direction
case $direction in
    "up")
        tmux_direction="-U"
        ;;

    "down")
        tmux_direction="-D"
        ;;

    "left")
        tmux_direction="-L"
        ;;

    "right")
        tmux_direction="-R"
        ;;
    *)
        echo "Error: Invalid direction. Use: up, down, left, right"
        exit 1
        ;;
esac

# Get target pane in the specified direction
target_pane=$(tmux display-message -p -t "{$tmux_direction}" '#P' 2>/dev/null)


# Check if target pane exists and is different from current
if [ -z "$target_pane" ] || [ "$target_pane" = "$current_pane" ]; then
    echo "Error: No pane found in direction '$direction'"
    exit 1
fi

echo "Swapping files between pane $current_pane and pane $target_pane..."

# Get info from both panes
current_info=$(get_pane_info "$current_pane")

target_info=$(get_pane_info "$target_pane")


# Parse the info

current_file=$(echo "$current_info" | cut -d'|' -f1)
current_cursor=$(echo "$current_info" | cut -d'|' -f2)
target_file=$(echo "$target_info" | cut -d'|' -f1)
target_cursor=$(echo "$target_info" | cut -d'|' -f2)

echo "Current pane file: $current_file"
echo "Target pane file: $target_file"


# Swap the files
open_file_in_pane "$current_pane" "$target_file" "$target_cursor"

open_file_in_pane "$target_pane" "$current_file" "$current_cursor"

echo "Files swapped successfully!"
