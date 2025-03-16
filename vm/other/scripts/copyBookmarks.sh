#!/bin/bash

SOURCE_DIR="/usr/share/brave-browser"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: The source directory $SOURCE_DIR does not exist."
  exit 1
fi

for USER_HOME in /home/*; do
  if [[ -d "$USER_HOME" ]]; then
    BRAVE_PROFILE_DIR="$USER_HOME/.config/BraveSoftware/Brave-Browser/Default"

    if [[ ! -d "$BRAVE_PROFILE_DIR" ]]; then
      mkdir -p "$BRAVE_PROFILE_DIR"
      echo "Created Brave profile directory at $BRAVE_PROFILE_DIR for user $(basename "$USER_HOME")."
    fi

    cp -r "$SOURCE_DIR"/* "$BRAVE_PROFILE_DIR" 2>/dev/null

    if [[ $? -eq 0 ]]; then
      echo "Content copied to $BRAVE_PROFILE_DIR for user $(basename "$USER_HOME")."
    else
      echo "Error copying content for user $(basename "$USER_HOME")."
    fi
  else
    echo "Invalid user directory: $USER_HOME."
  fi
done

echo "Process completed."