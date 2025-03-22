#!/bin/bash

# Define the source file path
SOURCE_FILE="/usr/share/brave-browser/Bookmarks"

# Check if the source file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: $SOURCE_FILE does not exist!"
    exit 1
fi

# Iterate over all directories in /home/
for HOME_DIR in /home/*; do
    # Check if it's a valid directory and not a symlink
    if [[ -d "$HOME_DIR" && ! -L "$HOME_DIR" ]]; then
        # Define the Brave configuration directory
        BRAVE_CONFIG_DIR="$HOME_DIR/.config/BraveSoftware/Brave-Browser/Default"

        # Create the directory structure if it doesn't exist
        mkdir -p "$BRAVE_CONFIG_DIR"

        # Copy the Bookmarks file to the Brave configuration directory
        if cp "$SOURCE_FILE" "$BRAVE_CONFIG_DIR/Bookmarks"; then
            echo "Bookmarks copied successfully to $BRAVE_CONFIG_DIR"
        else
            echo "Error: Failed to copy Bookmarks to $BRAVE_CONFIG_DIR"
        fi
    else
        echo "Skipping $HOME_DIR (not a valid directory or is a symlink)"
    fi
done

echo "Process completed."