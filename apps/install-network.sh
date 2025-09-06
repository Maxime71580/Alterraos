#!/bin/bash
# install-network.sh – Installer applications réseau et sécurité

MODE=${1:-"--stable"}

echo "Installation des applications réseau et sécurité (mode: $MODE)..."

sudo pacman -S --noconfirm wireshark-qt nmap

if [[ "$MODE" == "--labo" ]]; then
    sudo pacman -S --noconfirm hydra john hashcat
fi

echo "Applications réseau / sécurité installées !"
