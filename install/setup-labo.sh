#!/bin/bash
# setup-labo.sh – Gestion du mode labo pour Alterra OS
# Permet d'activer, désactiver ou vérifier l'état du mode labo

ACTION=${1:-"--status"}
LABO_DIR="/alterra-os/labo"
STATUS_FILE="$HOME/.alterra-labo-status"

# Fonction pour activer le mode labo
activate_labo() {
    echo "Activation du mode labo..."
    # Création du fichier de statut
    echo "active" > "$STATUS_FILE"

    # Lancer tous les scripts labo (optionnellement, à adapter selon sous-dossiers)
    for DIR in "$LABO_DIR"/*; do
        if [ -d "$DIR" ]; then
            echo "Préparation des scripts dans $DIR..."
            # On pourrait ici exécuter des scripts init, ou juste les rendre accessibles
            # Exemple : rendre scripts exécutables
            chmod +x "$DIR"/*.sh 2>/dev/null
        fi
    done

    echo "Mode labo activé !"
}

# Fonction pour désactiver le mode labo
deactivate_labo() {
    echo "Désactivation du mode labo..."
    echo "inactive" > "$STATUS_FILE"
    echo "Mode labo désactivé !"
}

# Fonction pour vérifier l'état
status_labo() {
    if [ -f "$STATUS_FILE" ]; then
        STATE=$(cat "$STATUS_FILE")
        echo "Mode labo actuel : $STATE"
    else
        echo "Mode labo jamais activé, état inconnu."
    fi
}

# Action principale
case "$ACTION" in
    --on)
        activate_labo
        ;;
    --off)
        deactivate_labo
        ;;
    --status)
        status_labo
        ;;
    *)
        echo "Usage : $0 [--on|--off|--status]"
        ;;
esac
