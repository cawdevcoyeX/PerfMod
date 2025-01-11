#!/bin/bash

# Define the file to modify
CONFIG_FILE="/etc/ssh/sshd_config"

# Define the lines to add or update
LINES_TO_ADD=(
    "X11Forwarding yes"
    "X11DisplayOffset 10"
    "X11UseLocalhost yes"
)

# Backup the original configuration file
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

# Loop through each line and ensure it's in the file
for LINE in "${LINES_TO_ADD[@]}"; do
    # Check if the line exists
    if grep -q "^${LINE}" "$CONFIG_FILE"; then
        echo "Line already exists: $LINE"
    else
        # Add the line if it doesn't exist
        echo "$LINE" >> "$CONFIG_FILE"
        echo "Added line: $LINE"
    fi
done

# Restart the SSH service for non-systemctl systems
if command -v service > /dev/null; then
    # Use 'service' command
    service ssh restart
elif command -v /etc/init.d/ssh > /dev/null; then
    # Use init script directly
    /etc/init.d/ssh restart
else
    echo "Could not restart SSH service. Please restart it manually."
    exit 1
fi

echo "X11 forwarding configuration updated and SSH service restarted."
