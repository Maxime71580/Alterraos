#!/bin/bash
# post-install.sh – Script post-installation pour Alterra OS
# Objectif : installer apps, configurer système, drivers, terminal, wallpaper

# === 1. Vérification pré-requis ===
echo "Vérification des gestionnaires de paquets..."
command -v pacman >/dev/null 2>&1 || { echo "Pacman non trouvé, arrêt."; exit 1; }
command -v yay >/dev/null 2>&1 || echo "Yay non trouvé, installation optionnelle."
command -v apt >/dev/null 2>&1 || echo "Apt non trouvé, optionnel."

# Installer fastfetch et lolcat
echo "Installation de fastfetch et lolcat..."
sudo pacman -S --noconfirm fastfetch lolcat || yay -S --noconfirm fastfetch lolcat

# Vérifier que Kitty est installé
command -v kitty >/dev/null 2>&1 || { echo "Kitty non trouvé, installation..."; sudo pacman -S --noconfirm kitty; }

# === 2. Installation des applications ===
echo "Installation des applications multimédia..."
/alterra-os/apps/install-multimedia.sh --full

echo "Installation des applications dev..."
/alterra-os/apps/install-dev.sh --full

echo "Installation des applications gaming..."
/alterra-os/apps/install-gaming.sh --stable

echo "Installation des applications réseau / sécurité..."
/alterra-os/apps/install-network.sh --stable

# === 3. Configuration système ===
echo "Configuration du wallpaper par défaut..."
cp /alterra-os/config/wallpapers/alterra-default.jpg "$HOME/Pictures/alterra-wallpaper.jpg"
# KDE command pour définir wallpaper (plasma)
plasmashell --replace &  # relancer KDE pour appliquer wallpaper

echo "Configuration du terminal Kitty..."
mkdir -p "$HOME/.config/kitty"
cat <<EOL > "$HOME/.config/kitty/kitty.conf"
shell /bin/bash -c "fastfetch | lolcat; exec /bin/bash"
EOL

echo "Application du thème KDE par défaut et multi-écrans..."
/alterra-os/config/kde-settings/apply-settings.sh

echo "Activation VPN et firewall..."
/alterra-os/config/network-settings/enable.sh

# === 4. Installation des drivers ===
echo "Détection et installation GPU..."
/alterra-os/drivers/gpu-detect.sh --auto

echo "Configuration réseau..."
/alterra-os/drivers/network-detect.sh --auto

echo "Installation drivers périphériques optionnels..."
/alterra-os/drivers/optional-drivers.sh --all

# === 5. Mode labo ===
read -p "Voulez-vous activer le mode labo ? (y/n): " LABO
if [[ "$LABO" =~ ^[Yy]$ ]]; then
    /alterra-os/install/setup-labo.sh --on
else
    echo "Mode stable activé."
fi

# === 6. Finalisation ===
echo "Mise à jour complète du système..."
/alterra-os/bin/update-system.sh -a

echo "Installation et configuration terminées !"
echo "Vous pouvez maintenant redémarrer votre système."
