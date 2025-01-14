#!/bin/bash

# Pfad zum Gerät, das den Tablet-Modus meldet
SWITCH_DEVICE="/dev/input/event8"

# Funktion zum Starten der virtuellen Tastatur
start_virtual_keyboard() {
    if ! pgrep -x "onboard" > /dev/null; then
        onboard &
    fi
}

# Funktion zum Beenden der virtuellen Tastatur
stop_virtual_keyboard() {
    if pgrep -x "onboard" > /dev/null; then
        pkill onboard
    fi
}

# Überwache das Gerät und erkenne Modusänderungen
monitor_tablet_mode() {
    sudo evtest "$SWITCH_DEVICE" | while read -r line; do
        if echo "$line" | grep -q "SW_TABLET_MODE.*value 1"; then
            echo "Tablet-Modus aktiviert"
            start_virtual_keyboard
        elif echo "$line" | grep -q "SW_TABLET_MODE.*value 0"; then
            echo "Tablet-Modus deaktiviert"
            stop_virtual_keyboard
        fi
    done
}

# Starte die Überwachung
echo "Überwache den Tablet-Modus auf $SWITCH_DEVICE..."
monitor_tablet_mode
