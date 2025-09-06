#!/bin/bash
# switch-stable.sh – Active le profil stable

echo "Activation du profil stable..."
cp -r /alterra-os/config/profiles/stable/* "$HOME/.config/"
echo "Profil stable activé !"
