#!/bin/bash
# enable.sh – Active VPN et firewall

echo "Activation du firewall..."
sudo systemctl enable --now ufw
sudo ufw enable

echo "Activation du VPN (WireGuard)..."
sudo systemctl enable --now wg-quick@alterra-vpn

echo "VPN et firewall activés !"
