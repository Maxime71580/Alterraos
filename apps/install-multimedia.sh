#!/bin/bash
# install-multimedia.sh – Installer applications multimédia

MODE=${1:-"--full"}

echo "Installation des applications multimédia (mode: $MODE)..."

# VLC
sudo pacman -S --noconfirm vlc

# Clementine
sudo pacman -S --noconfirm clementine

# Krita (optionnel)
if [[ "$MODE" == "--full" ]]; then
    sudo pacman -S --noconfirm krita
fi

# OBS Studio (optionnel)
if [[ "$MODE" == "--full" ]]; then
    sudo pacman -S --noconfirm obs-studio
fi

echo "Applications multimédia installées !"
