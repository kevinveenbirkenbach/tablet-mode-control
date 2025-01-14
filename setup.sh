#!/bin/bash

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
Exec=sudo $TARGET_PATH
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Tablet Mode Detection
Comment=Detect tablet mode and toggle virtual keyboard
DESKTOP

echo "Setup completed! The script will run on the next login."
