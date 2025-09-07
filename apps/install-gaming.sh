#!/bin/bash
# install-gaming.sh – Installer applications gaming

MODE=${1:-"--stable"}

echo "Installation des applications gaming (mode: $MODE)..."

sudo pacman -S --noconfirm steam lutris heroic-games-launcher

if [[ "$MODE" == "--experimental" ]]; then
    sudo pacman -S --noconfirm wine winetricks playonlinux
fi

echo "Applications gaming installées !"
