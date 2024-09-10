#!/bin/bash

# Check if the script is run with sudo permissions
if [ "$USER" != "root" ]; then
    echo "Error: This script must be run as root or with sudo privileges."
    exit 1
fi

# Check if the correct number of arguments are passed
if [ "$#" -ne 3 ]; then
    echo "Error: You must provide a username, password, and group name."
    echo "Usage: ./userdef <username> <userpass> <groupname>"
    exit 1
fi

# Assign arguments to variables
USERNAME=$1
USERPASS=$2
GROUPNAME=$3

# Display the arguments entered
echo "Username: $USERNAME"
echo "Password: $USERPASS"
echo "Group Name: $GROUPNAME"

# Create a new user with a home directory without creating a group with the same name and bash shell
sudo useradd -m -N -s /bin/bash "$USERNAME"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create user '$USERNAME'."
    exit 1
else
    echo "User '$USERNAME' created successfully with a home directory and Bash shell."
fi

# Set the password for the user without prompting
echo "$USERNAME:$USERPASS" | sudo chpasswd
if [ $? -ne 0 ]; then
    echo "Error: Failed to set the password for '$USERNAME'."
    exit 1
else
    echo "Password for user '$USERNAME' set successfully."
fi

# Display user and group information
echo "Initial user and group information:"
id "$USERNAME"

# Create a new group with ID=200 and the name from the argument
sudo groupadd -g 200 "$GROUPNAME"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create group '$GROUPNAME' with GID=200."
    exit 1
else
    echo "Group '$GROUPNAME' created successfully with GID=200."
fi

# Add the user to the newly created group
sudo usermod -aG "$GROUPNAME" "$USERNAME"
if [ $? -ne 0 ]; then
    echo "Error: Failed to add user '$USERNAME' to group '$GROUPNAME'."
    exit 1
else
    echo "User '$USERNAME' added to group '$GROUPNAME' successfully."
fi

# Display user and group information after adding the user to the new group
echo "User and group information after adding user to the group:"
id "$USERNAME"

# Modify the user to set UID=1600 and set the primary group to the new group
sudo usermod -u 1600 -g "$GROUPNAME" "$USERNAME"
if [ $? -ne 0 ]; then
    echo "Error: Failed to modify user '$USERNAME'."
    exit 1
else
    echo "User '$USERNAME' modified successfully. UID set to 1600 and primary group set to '$GROUPNAME'."
fi

# Display user and group information after modification
echo "Final user and group information after modification:"
id "$USERNAME"

