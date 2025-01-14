#!/bin/bash

# Path to the device that reports tablet mode
SWITCH_DEVICE="/dev/input/event8"

# Function to enable the virtual keyboard
enable_virtual_keyboard() {
    gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true
}

# Function to disable the virtual keyboard
disable_virtual_keyboard() {
    gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
}

# Monitor the device and detect mode changes
monitor_tablet_mode() {
    evtest "$SWITCH_DEVICE" | while read -r line; do
        if echo "$line" | grep -q "SW_TABLET_MODE.*value 1"; then
            echo "Tablet mode activated"
            enable_virtual_keyboard
        elif echo "$line" | grep -q "SW_TABLET_MODE.*value 0"; then
            echo "Tablet mode deactivated"
            disable_virtual_keyboard
        fi
    done
}

# Start monitoring
echo "Monitoring tablet mode on $SWITCH_DEVICE..."
monitor_tablet_mode
