#!/bin/bash

# Check if the script is run with sudo
if [ "$(id -u)" -eq 0 ]; then
    echo "WARNING: You are running this script with 'sudo'."
    echo "This will install the script for the root user instead of the current user."
    echo "It is recommended to run the script without 'sudo'."
    echo "Abort the script and re-run without 'sudo' if this is not your intention."
    echo ""
    read -p "Do you want to continue as root? (yes/no): " choice
    case "$choice" in
        yes|Yes|Y|y) echo "Continuing installation as root..." ;;
        no|No|N|n) echo "Aborting installation. Please re-run without 'sudo'." ; exit 1 ;;
        *) echo "Invalid choice. Aborting installation." ; exit 1 ;;
    esac
fi

# Define the target path for the tablet mode script
TARGET_PATH="/usr/local/bin/tablet-mode.sh"

# Copy the tablet mode script to the target path
echo "Copying tablet-mode.sh to $TARGET_PATH..."
sudo cp tablet-mode.sh "$TARGET_PATH"
sudo chmod +x "$TARGET_PATH"

# Integrate the script into the autostart
echo "Integrating $TARGET_PATH into autostart..."
mkdir -p ~/.config/autostart
cat << DESKTOP > ~/.config/autostart/tablet-mode.desktop
[Desktop Entry]
Type=Application
Exec=$TARGET_PATH > /tmp/tablet-mode.log 2>&1
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Tablet Mode Detection
Comment=Detect tablet mode and toggle virtual keyboard
DESKTOP

echo "Setup completed! The script will run on the next login."
