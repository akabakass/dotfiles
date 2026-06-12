#!/bin/bash
set -euo pipefail

FILE_PATH=$1
DB_NAME=$2

ODOO_BIN="/usr/bin/odoo"
ODOO_CONF="/etc/odoo/odoo.conf"
ODOO_SERVICE="odoo-dev"
ODOO_LOG="/var/log/odoo/odoo-server.log"   # = logfile= de ta conf

[ -z "$DB_NAME" ] && { echo "Erreur : base non spécifiée."; exit 1; }

MODULE_NAME=$(echo "$FILE_PATH" | awk -F'/' '{for(i=1;i<=NF;i++) if($i=="models"||$i=="views"||$i=="controllers"||$i=="data"||$i=="security"||$i=="wizard") print $(i-1)}' | head -n1)
[ -z "$MODULE_NAME" ] && { echo "Erreur : module indéduisible depuis $FILE_PATH"; exit 1; }

systemctl stop "$ODOO_SERVICE"

# Marque le point de départ pour ne relire que CE run en cas d'échec
mark=$(wc -l < "$ODOO_LOG" 2>/dev/null || echo 0)

update_rc=0
sudo -u odoo "$ODOO_BIN" -c "$ODOO_CONF" -d "$DB_NAME" \
    -u "$MODULE_NAME" --stop-after-init || update_rc=$?

systemctl start "$ODOO_SERVICE"

# En cas d'échec : ressort uniquement les lignes ajoutées par ce run (le traceback)
if [ "$update_rc" -ne 0 ]; then
    tail -n +"$((mark + 1))" "$ODOO_LOG" | awk '/ ERROR | CRITICAL |Traceback \(most recent/{p=1} p'
fi

exit "$update_rc"
