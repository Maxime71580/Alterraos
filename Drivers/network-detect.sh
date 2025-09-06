#!/bin/bash
# network-detect.sh – Config réseau automatique

echo "Détection des interfaces réseau..."
IFACES=$(ip link show | grep -E "en|wl" | awk -F: '{print $2}')

for IFACE in $IFACES; do
    echo "Activation interface $IFACE..."
    sudo ip link set $IFACE up
done

echo "Installation NetworkManager..."
sudo pacman -S --noconfirm networkmanager
sudo systemctl enable --now NetworkManager

echo "Configuration réseau terminée !"
