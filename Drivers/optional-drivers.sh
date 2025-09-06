#!/bin/bash
# optional-drivers.sh – Installation pilotes périphériques optionnels

echo "Installation des drivers périphériques optionnels..."

# Exemple : imprimante / scanner
sudo pacman -S --noconfirm hplip sane

echo "Drivers périphériques installés !"
