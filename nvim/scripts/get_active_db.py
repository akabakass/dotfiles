#!/usr/bin/env python3
import os
import json  # Remplacement de pickle par json

SESSION_DIR = "/var/lib/odoo/.local/share/Odoo/sessions"

def get_active_db():
    all_files = []

    for root, dirs, files in os.walk(SESSION_DIR):
        for file in files:
            all_files.append(os.path.join(root, file))

    if not all_files:
        return ""

    latest_file = max(all_files, key=os.path.getmtime)

    # On utilise un bloc try/except uniquement pour la lecture finale
    # car un fichier de session peut théoriquement être en cours d'écriture par Odoo
    try:
        # Ouverture en mode texte 'r' avec encodage UTF-8 obligatoire pour JSON
        with open(latest_file, 'r', encoding='utf-8') as f:
            session_data = json.load(f)

            if 'db' in session_data and session_data['db']:
                return session_data['db']
    except Exception as e:
        return ""

    return ""

if __name__ == "__main__":
    print(get_active_db())
