#!/bin/bash

# Arguments envoyés par Neovim
FILE_PATH=$1
DB_NAME=$2

# Chemins de votre installation (à ajuster si besoin)
ODOO_BIN="/opt/odoo/odoo-bin"     # Chemin vers votre exécutable Odoo
ODOO_CONF="/etc/odoo/odoo.conf"   # Chemin vers votre fichier de conf (odoo ou odoo-dev)
ODOO_SERVICE="odoo-dev"               # Nom de votre service systemd (odoo ou odoo-dev)

if [ -z "$DB_NAME" ]; then
    echo "Erreur : Base de données non spécifiée."
    exit 1
fi

# Extraction intelligente du nom du module depuis le chemin du fichier courant
MODULE_NAME=$(echo "$FILE_PATH" | awk -F'/' '{for(i=1;i<=NF;i++) if($i=="models" || $i=="views" || $i=="controllers") print $(i-1)}')

if [ -z "$MODULE_NAME" ]; then
    echo "Erreur : Impossible de déduire le module (êtes-vous bien dans models/, views/ ou controllers/ ?)"
    exit 1
fi

echo "Mise à jour du module [$MODULE_NAME] sur la base [$DB_NAME]..."

# 1. Mise en pause du service multi-tenant
systemctl stop $ODOO_SERVICE

# 2. Lancement du binaire Odoo uniquement pour faire la mise à jour sur la bonne base (-d)
sudo -u odoo $ODOO_BIN -c $ODOO_CONF -d $DB_NAME -u $MODULE_NAME --stop-after-init

# 3. Relance du service
systemctl start $ODOO_SERVICE

echo "Redémarrage du service terminé."
