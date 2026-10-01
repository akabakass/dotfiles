#!/bin/bash
set -euo pipefail

FILE_PATH=$1
DB_NAME=$2
FORCE_MODE=${3:-auto}   # auto | update | restart

ODOO_BIN="/usr/bin/odoo"
ODOO_CONF="/etc/odoo/odoo.conf"
ODOO_SERVICE="odoo-dev"
ODOO_LOG="/var/log/odoo/odoo-server.log"
REPO="/var/www/odoo"
STATE_DIR="$REPO/.build_state"

# Le depot appartient a jc, le script tourne sous root : git refuserait
# d'operer ("dubious ownership"). L'exception est passee a l'appel plutot
# que dans la config globale de root.
GIT=(git -C "$REPO" -c safe.directory="$REPO")

[ -z "$DB_NAME" ] && { echo "Erreur : base non specifiee."; exit 1; }

MODULE_NAME=$(echo "$FILE_PATH" | awk -F'/' '{for(i=1;i<=NF;i++) if($i=="models"||$i=="views"||$i=="controllers"||$i=="data"||$i=="security"||$i=="wizard"||$i=="report"||$i=="tests") print $(i-1)}' | head -n1)
[ -z "$MODULE_NAME" ] && { echo "Erreur : module indeduisible depuis $FILE_PATH"; exit 1; }

MODULE_DIR=$(echo "$FILE_PATH" | sed "s|\(.*/$MODULE_NAME\)/.*|\1|")
[ -d "$MODULE_DIR" ] || { echo "Erreur : repertoire module introuvable ($MODULE_DIR)"; exit 1; }

mkdir -p "$STATE_DIR"
MARKER="$STATE_DIR/${DB_NAME}_${MODULE_NAME}.stamp"
SHAFILE="$STATE_DIR/${DB_NAME}_${MODULE_NAME}.sha"

# ─────────────────────────────────────────────────────────
# Decision : mise a jour complete ou simple restart
# ─────────────────────────────────────────────────────────
decide() {
    [ "$FORCE_MODE" = "update" ]  && { echo "update (force)"; return; }
    [ "$FORCE_MODE" = "restart" ] && { echo "restart (force)"; return; }

    # Pas de marqueur : premier build sur ce module pour cette base. On ne
    # prend pas le risque d'une colonne manquante.
    [ -f "$MARKER" ] || { echo "update (premier build)"; return; }

    local changed
    changed=$(find "$MODULE_DIR" -type f -newer "$MARKER" \
                   -not -path '*/__pycache__/*' -not -name '*.pyc' 2>/dev/null || true)

    [ -z "$changed" ] && { echo "restart (rien de modifie)"; return; }

    # Tout ce qui n'est pas du .py touche au schema, aux donnees ou aux
    # droits d'acces : la base doit etre mise a jour.
    local non_py
    non_py=$(echo "$changed" | grep -v '\.py$' || true)
    [ -n "$non_py" ] && { echo "update (fichiers non-py modifies)"; return; }

    local manifest
    manifest=$(echo "$changed" | grep '__manifest__\.py$' || true)
    [ -n "$manifest" ] && { echo "update (manifeste modifie)"; return; }

    # Seuls des .py ont bouge. Un nouveau champ cree une colonne en base :
    # sans -u, Odoo plante a la lecture. On cherche donc les lignes AJOUTEES
    # contenant une declaration de champ.
    # Reference : le SHA du dernier build, pas HEAD — on peut avoir commite
    # depuis sans avoir reconstruit.
    local base_sha=""
    [ -f "$SHAFILE" ] && base_sha=$(cat "$SHAFILE")

    local diff_out=""
    if [ -n "$base_sha" ] && "${GIT[@]}" cat-file -e "${base_sha}^{commit}" 2>/dev/null; then
        diff_out=$("${GIT[@]}" diff "$base_sha" -- "$MODULE_DIR" 2>/dev/null || true)
    else
        diff_out=$("${GIT[@]}" diff HEAD -- "$MODULE_DIR" 2>/dev/null || true)
    fi

    # ^\+[^+] : les lignes ajoutees, en excluant l'en-tete +++ du fichier.
    local added_schema
    added_schema=$(echo "$diff_out" | grep -E '^\+[^+]' \
        | grep -E 'fields\.|_inherits|_sql_constraints|_name[[:space:]]*=' || true)
    [ -n "$added_schema" ] && { echo "update (declaration de champ ajoutee)"; return; }

    # Fichier non suivi par git : le diff ne le voit pas, on ne peut rien
    # conclure. On reste prudent.
    local untracked
    untracked=$("${GIT[@]}" ls-files --others --exclude-standard -- "$MODULE_DIR" 2>/dev/null || true)
    [ -n "$untracked" ] && { echo "update (fichier non suivi par git)"; return; }

    echo "restart (corps de methode seulement)"
}

DECISION=$(decide)
MODE=$(echo "$DECISION" | cut -d' ' -f1)
REASON=$(echo "$DECISION" | cut -d' ' -f2-)

echo "[$MODULE_NAME] $MODE $REASON"

mark=$(wc -l < "$ODOO_LOG" 2>/dev/null || echo 0)
rc=0

if [ "$MODE" = "update" ]; then
    systemctl stop "$ODOO_SERVICE"
    sudo -u odoo "$ODOO_BIN" -c "$ODOO_CONF" -d "$DB_NAME" \
        -u "$MODULE_NAME" --stop-after-init || rc=$?
    systemctl start "$ODOO_SERVICE"
else
    systemctl restart "$ODOO_SERVICE"
fi

# Type=simple : systemd rend la main des que le process est lance, mais Odoo
# met encore ~1,5 s avant d'ecouter sur 8069. Sans cette attente, le script
# annonce "OK" alors que le navigateur est encore hors ligne.
for _ in $(seq 1 120); do
    ss -lnt 2>/dev/null | grep -q ':8069 ' && break
    sleep 0.25
done

# Le registre se charge a la PREMIERE requete, pas au demarrage : on la
# declenche ici pour que la page soit servie immediatement.
curl -s -o /dev/null --max-time 90 "http://127.0.0.1:8069/web/login" || true

if [ "$rc" -ne 0 ]; then
    tail -n +"$((mark + 1))" "$ODOO_LOG" | awk '/ ERROR | CRITICAL |Traceback \(most recent/{p=1} p'
    exit "$rc"
fi

# Nouveau point de reference pour le prochain build.
touch "$MARKER"
"${GIT[@]}" rev-parse HEAD > "$SHAFILE" 2>/dev/null || true

exit 0
