#!/bin/bash

SOURCE_FILE="/usr/share/brave-browser/Bookmarks"

if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "$SOURCE_FILE doesnt exist!!!!"
    exit 1
fi

for HOME_DIR in /home/*; do
    if [[ -d "$HOME_DIR" && ! -L "$HOME_DIR" ]]; then
        BRAVE_CONFIG_DIR="$HOME_DIR/.config/BraveSoftware/Brave-Browser/Default"

        mkdir -p "$BRAVE_CONFIG_DIR"

        cp "$SOURCE_FILE" "$BRAVE_CONFIG_DIR/Bookmarks"

        if [[ $? -eq 0 ]]; then
            echo "Bookmarks copied to $BRAVE_CONFIG_DIR"
        else
            echo "Error copying Bookmarks to $BRAVE_CONFIG_DIR"
        fi
    else
        echo "$HOME_DIR not valid or its a symlink"  fi
done

echo "Completed."