#!/bin/bash
# post-install.sh – Script post-installation pour AlterraOS
# Objectif : installer apps, configurer système, drivers, terminal, wallpaper

set -e

BASE_DIR="$(dirname "$(realpath "$0")")"  # /alterra-os/install

echo "=== Vérification des gestionnaires de paquets ==="
command -v pacman >/dev/null 2>&1 || { echo "Pacman non trouvé, arrêt."; exit 1; }
command -v yay >/dev/null 2>&1 || echo "Yay non trouvé, installation optionnelle."
command -v apt >/dev/null 2>&1 || echo "Apt non trouvé, optionnel."

echo "=== Installation de fastfetch et lolcat ==="
sudo pacman -S --noconfirm fastfetch lolcat || yay -S --noconfirm fastfetch lolcat

# --- INSTALLATION DES APPS ---
echo "=== Installation des applications ==="
bash "$BASE_DIR/../apps/install-multimedia.sh" --full
bash "$BASE_DIR/../apps/install-dev.sh" --full
bash "$BASE_DIR/../apps/install-gaming.sh" --stable
bash "$BASE_DIR/../apps/install-network.sh" --stable

# --- CONFIGURATION SYSTEME ---
echo "=== Configuration du wallpaper et terminal ==="
mkdir -p "$HOME/Pictures"
cp "$BASE_DIR/../Config/wallpapers/alterra-default.jpg" "$HOME/Pictures/alterra-wallpaper.jpg"

mkdir -p "$HOME/.config/kitty"
cat <<EOL > "$HOME/.config/kitty/kitty.conf"
shell /bin/bash -c "fastfetch | lolcat; exec /bin/bash"
EOL

# --- DRIVER ET RÉSEAU ---
echo "=== Installation drivers ==="
bash "$BASE_DIR/../Drivers/gpu-detect.sh" --auto
bash "$BASE_DIR/../Drivers/network-detect.sh" --auto
bash "$BASE_DIR/../Drivers/optional-drivers.sh" --all

# --- MODE LABO ---
read -p "Voulez-vous activer le mode labo ? (y/n): " LABO
if [[ "$LABO" =~ ^[Yy]$ ]]; then
    bash "$BASE_DIR/setup-labo.sh" --on
else
    echo "Mode stable activé."
fi

# --- FIN ---
echo "=== Mise à jour complète du système ==="
sudo pacman -Syu --noconfirm

echo "=== Installation et configuration terminées ! ==="
