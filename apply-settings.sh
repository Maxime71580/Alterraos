#!/bin/bash
# apply-settings.sh – Appliquer thème KDE, multi-écrans, et autres configs

echo "Application des paramètres KDE..."

# Charger le thème par défaut
lookandfeeltool -a org.alterra.kde.theme 2>/dev/null

# Restaurer les profils multi-écrans si existants
if [ -f "$HOME/.config/alterra/monitor-profiles/current-profile" ]; then
    PROFILE=$(cat "$HOME/.config/alterra/monitor-profiles/current-profile")
    echo "Chargement du profil multi-écrans : $PROFILE"
    # Exemple : command KDE pour appliquer profil (pseudo-commande)
    qdbus org.kde.KScreen /KScreen/Manager applyProfile "$PROFILE"
fi

echo "Paramètres KDE appliqués !"
