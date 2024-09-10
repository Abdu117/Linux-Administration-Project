#!/bin/bash

# Check if the username argument is provided
if [ -z "$1" ]; then
    echo "Error: No username provided."
    exit 1
fi

# Define variables for the directory and files
DIR_NAME="example_directory"
FILES=("main.c" "main.h" "hello.c" "hello.h")
NEW_USER="$1"  # Username is taken from the first argument
HOME_DIR="/home/$NEW_USER"
CURR_DIR=$(pwd)
# a) Check if the directory already exists, and if it does, remove it
[ -d "$DIR_NAME" ] && rm -rf "$DIR_NAME" && echo "Directory $DIR_NAME removed."

# b) Create the directory & create 4 files in this directory (main.c, main.h, hello.c, hello.h)
mkdir "$DIR_NAME" && echo "Directory $DIR_NAME created." && touch "$DIR_NAME"/{main.c,main.h,hello.c,hello.h} && echo "Files created."

# c) Loop on each of these files and write "This file is named ..." (with the file name) into each file
for FILE in "${FILES[@]}"; do echo "This file is named $FILE" > "$DIR_NAME/$FILE" || exit 1; done && echo "Content written to files."

# d) Compress the directory into a tar file
tar -czf "$DIR_NAME.tar.gz" "$DIR_NAME" && echo "Directory compressed into $DIR_NAME.tar.gz."

# e) Try to change directory to the new user's home directory, handle permission if denied
if cd "$HOME_DIR" 2>/dev/null; then
    echo "Changed to the home directory of $NEW_USER."
else
    echo "Permission denied, changing permissions to 777..."
    sudo chmod 777 "$HOME_DIR" && cd "$HOME_DIR" && echo "Permissions changed to 777."
fi

# f) Copy the tar file to the new home directory, go there, and extract it
cp "$CURR_DIR/$DIR_NAME.tar.gz" "$HOME_DIR" && cd "$HOME_DIR" && tar -xzf "$DIR_NAME.tar.gz" && echo "Tar file copied and extracted in $HOME_DIR."
