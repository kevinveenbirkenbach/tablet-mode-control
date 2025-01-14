#!/bin/bash

# Function to find the device that reports tablet mode
find_switch_device() {
    echo "Searching for device with platform-INTC1070:00 and ID_INPUT_SWITCH=1..." >&2
    for device in /dev/input/event*; do
        echo "Checking: $device" >&2
        # Prüfe auf ID_INPUT_SWITCH=1 und den passenden DEVPATH
        if udevadm info --query=property --name="$device" 2>/dev/null | grep -q "ID_INPUT_SWITCH=1" &&
           udevadm info --query=property --name="$device" 2>/dev/null | grep -q "DEVPATH=/devices/platform/INTC1070:00"; then
            echo "Found tablet mode device: $device" >&2
            echo "$device"
            return
        fi
    done
    echo "Error: No device matching platform-INTC1070:00 with ID_INPUT_SWITCH=1 found." >&2
    exit 1
}

# Path to the device that reports tablet mode
SWITCH_DEVICE=$(find_switch_device)

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