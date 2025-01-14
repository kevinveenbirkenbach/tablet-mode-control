#!/bin/bash

# Check if the script is run with sudo
if [ "$(id -u)" -eq 0 ]; then
    echo "WARNING: You are running this script with 'sudo'."
    echo "This will uninstall the script for the root user instead of the current user."
    echo "It is recommended to run the script without 'sudo'."
    echo "Abort the script and re-run without 'sudo' if this is not your intention."
    echo ""
    read -p "Do you want to continue as root? (yes/no): " choice
    case "$choice" in
        yes|Yes|Y|y) echo "Continuing uninstallation as root..." ;;
        no|No|N|n) echo "Aborting uninstallation. Please re-run without 'sudo'." ; exit 1 ;;
        *) echo "Invalid choice. Aborting uninstallation." ; exit 1 ;;
    esac
fi

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
