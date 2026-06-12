#!/bin/bash
TERM_CLASS="dropdown_kitty"
HIDDEN_WS="99"

CLIENT_INFO=$(hyprctl clients -j | jq -r ".[] | select(.class==\"$TERM_CLASS\")")

if [ -z "$CLIENT_INFO" ]; then
    kitty --class "$TERM_CLASS" bash --rcfile ~/.bashrc &
    disown
    exit 0
fi

ADDR=$(echo "$CLIENT_INFO" | jq -r '.address')
WS=$(echo "$CLIENT_INFO" | jq -r '.workspace.id')
ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r '.id')

# Hauteur de l'écran pour calculer le déplacement
MONITOR_HEIGHT=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .height')
HIDE_OFFSET=$((MONITOR_HEIGHT / 2 + 100))

if [ "$WS" = "$HIDDEN_WS" ]; then
    # Afficher : ramener sur workspace actif, puis animer vers le bas
    hyprctl dispatch movetoworkspacesilent "$ACTIVE_WS,address:$ADDR"
    hyprctl dispatch focuswindow address:$ADDR
else
    # Cacher : envoyer sur workspace caché
    hyprctl dispatch movetoworkspacesilent "$HIDDEN_WS,address:$ADDR"
fi
