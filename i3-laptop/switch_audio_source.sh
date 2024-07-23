#!/bin/bash

# Toggle your bluetooth device (e.g., Bose Headphones) between A2DP mode (high-fidelity playback with NO microphone) and HSP/HFP, codec mSBC (lower playback quality, microphone ENABLED)
function switch_source {
  current_idle_sink=$(pactl list short sinks | grep -v RUNNING | cut -d $'\t' -f 1)
  current_idle_sink_name=$(pactl list short sinks | grep -v RUNNING | cut -d $'\t' -f 2)
  echo "$current_idle_sink"
  pactl set-default-sink "$current_idle_sink"
  echo "Switching source to $current_idle_sink_name"
}

switch_source
