#!/bin/bash

# Installiere Abhängigkeiten
echo "Installiere benötigte Pakete..."
sudo pacman -S --noconfirm evtest onboard

# Tablet-Modus-Skript ausführbar machen
chmod +x tablet-mode.sh

# Skript in den Autostart integrieren
echo "Integriere tablet-mode.sh in den Autostart..."
mkdir -p ~/.config/autostart
cat << 'DESKTOP' > ~/.config/autostart/tablet-mode.desktop
[Desktop Entry]
Type=Application
Exec=sudo $(pwd)/tablet-mode.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Tablet Mode Detection
Comment=Detect tablet mode and toggle virtual keyboard
DESKTOP

echo "Setup abgeschlossen!"
