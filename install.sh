#!/bin/bash

# Get the full path of the home directory
HOME_DIR="$HOME"

# Get the full path of the repository directory
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# List of target files and directories
TARGETS=( ".nanorc" ".nano" )

# List to store existing files
EXISTING_FILES=()

# Check if any target already exists
for TARGET in "${TARGETS[@]}"; do
	TARGET_PATH="$HOME_DIR/$TARGET"
	if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
		EXISTING_FILES+=("$TARGET_PATH")
	fi
done

# If any existing files were found, print and exit
if [ ${#EXISTING_FILES[@]} -ne 0 ]; then
    echo "Error: The following files/directories already exist:"
    for FILE in "${EXISTING_FILES[@]}"; do
        echo "  $FILE"
    done
    exit 1
fi

# Create symlinks
echo "Installing dotfiles..."
for TARGET in "${TARGETS[@]}"; do
    TARGET_PATH="$HOME_DIR/$TARGET"
    SOURCE_PATH="$REPO_DIR/$TARGET"
    ln -s "$SOURCE_PATH" "$TARGET_PATH"
    echo "Created symlink: $TARGET_PATH -> $SOURCE_PATH"
done

echo "Installation complete."
