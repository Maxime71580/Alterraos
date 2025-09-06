#!/bin/bash
# gpu-detect.sh – Détecte GPU et installe driver

echo "Détection du GPU..."
GPU=$(lspci | grep -E "VGA|3D" | grep -i -E "nvidia|amd|intel" | awk '{print $5}')

if [[ "$GPU" =~ "NVIDIA" ]]; then
    echo "NVIDIA détectée, installation driver..."
    sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
elif [[ "$GPU" =~ "AMD" ]]; then
    echo "AMD détectée, installation driver..."
    sudo pacman -S --noconfirm xf86-video-amdgpu mesa
elif [[ "$GPU" =~ "Intel" ]]; then
    echo "Intel détectée, installation driver..."
    sudo pacman -S --noconfirm mesa xf86-video-intel
else
    echo "GPU non reconnu, aucun driver installé."
fi

echo "Drivers GPU installés !"
