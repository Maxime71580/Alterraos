#!/bin/bash
set -e

# Détection du dossier du script (pour que les chemins soient toujours corrects)
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

echo "Installation des paquets essentiels..."
sudo pacman -Syu --noconfirm base-devel git wget curl

echo "Installation des applications réseau / sécurité..."
sudo pacman -S --noconfirm nmap wireshark-qt

echo "Applications réseau / sécurité installées !"

echo "Configuration du wallpaper par défaut..."
WALLPAPER="$SCRIPT_DIR/../config/wallpapers/alterra-default.jpg"
if [ -f "$WALLPAPER" ]; then
    mkdir -p "$HOME/Pictures"
    cp "$WALLPAPER" "$HOME/Pictures/"
    echo "Wallpaper copié dans ~/Pictures."
else
    echo "⚠️ Wallpaper introuvable : $WALLPAPER"
fi

echo "Configuration du terminal Kitty..."
if command -v kitty >/dev/null 2>&1; then
    mkdir -p "$HOME/.config/kitty"
    cp "$SCRIPT_DIR/../config/kitty/kitty.conf" "$HOME/.config/kitty/" 2>/dev/null || true
else
    echo "⚠️ Kitty non installé."
fi

echo "Application du thème KDE par défaut et multi-écrans..."
if command -v plasmashell >/dev/null 2>&1; then
    bash "$SCRIPT_DIR/../config/kde-settings/apply-settings.sh"
else
    echo "⚠️ KDE non détecté."
fi

echo "Activation VPN et firewall..."
bash "$SCRIPT_DIR/../config/network-settings/enable.sh"

echo "Détection et installation GPU..."
bash "$SCRIPT_DIR/../drivers/gpu-detect.sh"

echo "Configuration réseau..."
bash "$SCRIPT_DIR/../drivers/network-detect.sh"

echo "Installation drivers périphériques optionnels..."
bash "$SCRIPT_DIR/../drivers/optional-drivers.sh"

echo "Voulez-vous activer le mode labo ? (y/n): "
read enable_labo
if [[ "$enable_labo" == "y" ]]; then
    bash "$SCRIPT_DIR/../install/setup-labo.sh"
    echo "Mode labo activé !"
else
    echo "Mode stable activé."
fi

echo "Mise à jour complète du système..."
bash "$SCRIPT_DIR/../bin/update-system.sh"

echo "Installation et configuration terminées !"
echo "Vous pouvez maintenant redémarrer votre système."
