#!/bin/bash
# install-alterra.sh – Installation automatique d’Arch + AlterraOS
# A lancer depuis l’ISO minimale AlterraOS

set -e

echo "=== Vérification de l'environnement ==="
command -v pacman >/dev/null 2>&1 || { echo "Pacman non trouvé. ISO Arch requise."; exit 1; }

echo "=== Installation des outils de base ==="
sudo pacman -S --noconfirm git sudo curl

echo "=== Clonage du repo AlterraOS ==="
git clone https://github.com/tonrepo/AlterraOS.git /tmp/AlterraOS

# --- PARTITIONNEMENT ET INSTALLATION ARCH (exemple simple) ---
DISK="/dev/sda"
ROOT_PART="${DISK}1"

sudo parted $DISK mklabel gpt
sudo parted -a optimal $DISK mkpart primary ext4 1MiB 100%
sudo mkfs.ext4 $ROOT_PART
sudo mount $ROOT_PART /mnt

echo "=== Installation base Arch ==="
sudo pacstrap /mnt base base-devel linux linux-firmware vim

# --- COPIE DU REPO ---
sudo mkdir -p /mnt/alterra-os
sudo cp -r /tmp/AlterraOS/* /mnt/alterra-os/

# --- PERMISSIONS ---
sudo chmod -R +x /mnt/alterra-os/*.sh /mnt/alterra-os/apps/*.sh /mnt/alterra-os/Drivers/*.sh /mnt/alterra-os/install/*.sh

# --- CHROOT ET CONFIGURATION ---
sudo arch-chroot /mnt /bin/bash -c "
cd /alterra-os/install
./post-install.sh
"

# --- FIN ---
sudo umount -R /mnt
echo "=== Installation terminée. Redémarrez maintenant pour démarrer sur AlterraOS ==="
