#!/bin/bash
# post-install.sh – Script post-installation pour AlterraOS
# A lancer depuis /Alterraos/install

set -e

BASE_DIR="$(dirname "$(realpath "$0")")"  # /Alterraos/install

echo "=== Vérification des gestionnaires de paquets ==="
command -v pacman >/dev/null 2>&1 || { echo "Pacman non trouvé. Arrêt."; exit 1; }
command -v yay >/dev/null 2>&1 || echo "Yay non trouvé, optionnel."
command -v apt >/dev/null 2>&1 || echo "Apt non trouvé, optionnel."

echo "=== Installation de fastfetch et lolcat ==="
sudo pacman -S --noconfirm fastfetch lolcat || yay -S --noconfirm fastfetch lolcat

# --- INSTALLATION DES APPS ---
echo "=== Installation des applications ==="
bash "$BASE_DIR/../apps/install-multimedia.sh" --full
bash "$BASE_DIR/../apps/install-dev.sh" --full
bash "$BASE_DIR/../apps/install-gaming.sh" --stable
bash "$BASE_DIR/../apps/install-network.sh" --stable

# --- CONFIGURATION DU WALLPAPER ---
echo "=== Configuration du wallpaper ==="
mkdir -p "$HOME/Pictures"
cp "$BASE_DIR/../alterra.png" "$HOME/Pictures/alterra-wallpaper.png"
echo "Wallpaper copié : $HOME/Pictures/alterra-wallpaper.png"

# --- CONFIGURATION DU TERMINAL KITTY ---
echo "=== Configuration du terminal Kitty ==="
mkdir -p "$HOME/.config/kitty"
cat <<EOL > "$HOME/.config/kitty/kitty.conf"
shell /bin/bash -c "fastfetch | lolcat; exec /bin/bash"
EOL

# --- DRIVERS ET RÉSEAU ---
echo "=== Installation des drivers ==="
bash "$BASE_DIR/../Drivers/gpu-detect.sh" --auto
bash "$BASE_DIR/../Drivers/network-detect.sh" --auto
bash "$BASE_DIR/../Drivers/optional-drivers.sh" --all

# --- MODE LABO ---
read -p "Voulez-vous activer le mode labo ? (y/n): " LABO
if [[ "$LABO" =~ ^[Yy]$ ]]; then
    bash "$BASE_DIR/setup-labo.sh" --on
    echo "Mode labo activé !"
else
    echo "Mode stable activé."
fi

# --- MISE À JOUR SYSTÈME ---
echo "=== Mise à jour complète du système ==="
sudo pacman -Syu --noconfirm

echo "=== Installation et configuration terminées ! ==="
echo "Vous pouvez maintenant redémarrer votre système."
