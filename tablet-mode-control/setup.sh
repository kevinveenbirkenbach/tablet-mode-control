#!/bin/bash

# Definition des Zielpfads für das Tablet-Modus-Skript
TARGET_PATH="/usr/local/bin/tablet-mode.sh"

# Installiere Abhängigkeiten
echo "Installiere benötigte Pakete..."
sudo pacman -S --noconfirm evtest onboard

# Kopiere das Tablet-Modus-Skript in den Zielpfad
echo "Kopiere tablet-mode.sh nach $TARGET_PATH..."
sudo cp tablet-mode.sh "$TARGET_PATH"
sudo chmod +x "$TARGET_PATH"

# Skript in den Autostart integrieren
echo "Integriere $TARGET_PATH in den Autostart..."
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

echo "Setup abgeschlossen! Das Skript wird beim nächsten Login ausgeführt."
