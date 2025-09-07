#!/bin/bash
# disable.sh – Désactive VPN et firewall

echo "Désactivation du VPN (WireGuard)..."
sudo systemctl disable --now wg-quick@alterra-vpn

echo "Désactivation du firewall..."
sudo ufw disable
sudo systemctl disable --now ufw

echo "VPN et firewall désactivés !"
