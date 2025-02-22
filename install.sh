#!/bin/bash

# Get the full path of the home directory
HOME_DIR="$HOME"

# Get the full path of the repository directory
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Define target locations
TARGETS=(
    "$HOME_DIR/.nanorc:$REPO_DIR/.nanorc"
    "$HOME_DIR/.nano:$REPO_DIR/.nano"
)

# Check if any target already exists
for target in "${TARGETS[@]}"; do
    TARGET_PATH="${target%%:*}"
    if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
        echo "Error: $TARGET_PATH already exists. Exiting."
        exit 1
    fi
done

# Create symlinks
echo "Installing dotfiles..."
for target in "${TARGETS[@]}"; do
    TARGET_PATH="${target%%:*}"
    SOURCE_PATH="${target##*:}"
    ln -s "$SOURCE_PATH" "$TARGET_PATH"
    echo "Created symlink: $TARGET_PATH -> $SOURCE_PATH"
done

echo "Installation complete."
