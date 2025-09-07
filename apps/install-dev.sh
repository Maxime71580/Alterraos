#!/bin/bash
# install-dev.sh – Installer applications dev

MODE=${1:-"--full"}

echo "Installation des applications dev (mode: $MODE)..."

sudo pacman -S --noconfirm zed code git python nodejs npm

echo "Applications dev installées !"
