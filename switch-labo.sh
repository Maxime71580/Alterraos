#!/bin/bash
# switch-labo.sh – Active le profil labo / expérimental

echo "Activation du profil labo..."
cp -r /alterra-os/config/profiles/labo/* "$HOME/.config/"
echo "Profil labo activé !"
