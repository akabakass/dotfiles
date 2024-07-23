#!/bin/bash

# Toggle your bluetooth device (e.g., Bose Headphones) between A2DP mode (high-fidelity playback with NO microphone) and HSP/HFP, codec mSBC (lower playback quality, microphone ENABLED)
function switch_q30_mode {
    current_mode_is_a2dp=`pactl list | grep actif | grep a2dp`
    card=`pactl list | grep "Nom : bluez_card." | cut -d ' ' -f 2`

    if [ -n "$current_mode_is_a2dp" ]; then
        echo "Switching $card to mSBC (headset, for making calls)..."
        pactl set-card-profile $card headset-head-unit-msbc
    else
        echo "Switching $card to A2DP (high-fidelity playback)..."
        pactl set-card-profile $card a2dp-sink
    fi
}

switch_q30_mode
