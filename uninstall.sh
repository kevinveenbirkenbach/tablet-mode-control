#!/bin/bash

# Define the target path for the tablet mode script
TARGET_PATH="/usr/local/bin/tablet-mode.sh"

# Remove the tablet mode script
if [ -f "$TARGET_PATH" ]; then
    echo "Removing $TARGET_PATH..."
    sudo rm "$TARGET_PATH"
    echo "Tablet mode script removed."
else
    echo "$TARGET_PATH does not exist. Skipping removal."
fi

# Remove the autostart entry
AUTOSTART_PATH="~/.config/autostart/tablet-mode.desktop"
if [ -f "$AUTOSTART_PATH" ]; then
    echo "Removing autostart entry $AUTOSTART_PATH..."
    rm "$AUTOSTART_PATH"
    echo "Autostart entry removed."
else
    echo "$AUTOSTART_PATH does not exist. Skipping removal."
fi

echo "Uninstallation completed."
