#!/bin/bash

# Get the full path of the home directory
HOME_DIR="$HOME"

# Get the full path of the repository directory
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# List of target files and directories
TARGETS=( ".nanorc" ".nano" ".gitconfig" )

# List to store existing targets
EXISTING=()

# List to store targets we need created
CREATING=()

# Check if any target already exists
for TARGET in "${TARGETS[@]}"; do
    TARGET_PATH="$HOME_DIR/$TARGET"
    if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
        EXISTING+=("$TARGET_PATH")
    else
        CREATING+=("$TARGET")
    fi
done

# If any existing files were found, print them
if [ ${#EXISTING[@]} -ne 0 ]; then
    echo "The following files/directories already exist:"
    for ITEM in "${EXISTING[@]}"; do
        # print the target name in red
        echo -e "\033[01;31m  $ITEM\033[00m"
    done
fi

# Create symlinks as necessary
if [ ${#CREATING[@]} -ne 0 ]; then
    echo "Linking dotfiles..."
    for TARGET in "${CREATING[@]}"; do
        # create target and source paths
        TARGET_PATH="$HOME_DIR/$TARGET"
        SOURCE_PATH="$REPO_DIR/$TARGET"
        ln -s "$SOURCE_PATH" "$TARGET_PATH"
        # print the target name in green
        echo -e "\033[01;32m  Added symlink: $TARGET_PATH -> $SOURCE_PATH\033[00m"
    done
else
    echo "No symlinks created."
fi

echo "Installation complete."
