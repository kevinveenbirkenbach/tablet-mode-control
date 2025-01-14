#!/bin/bash

# Path to the device that reports tablet mode
SWITCH_DEVICE="/dev/input/event8"

# Function to start the virtual keyboard
start_virtual_keyboard() {
    if ! pgrep -x "onboard" > /dev/null; then
        onboard &
    fi
}

# Function to stop the virtual keyboard
stop_virtual_keyboard() {
    if pgrep -x "onboard" > /dev/null; then
        pkill onboard
    fi
}

# Monitor the device and detect mode changes
monitor_tablet_mode() {
    sudo evtest "$SWITCH_DEVICE" | while read -r line; do
        if echo "$line" | grep -q "SW_TABLET_MODE.*value 1"; then
            echo "Tablet mode activated"
            start_virtual_keyboard
        elif echo "$line" | grep -q "SW_TABLET_MODE.*value 0"; then
            echo "Tablet mode deactivated"
            stop_virtual_keyboard
        fi
    done
}

# Start monitoring
echo "Monitoring tablet mode on $SWITCH_DEVICE..."
monitor_tablet_mode
