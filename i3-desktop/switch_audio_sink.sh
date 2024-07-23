#!/bin/bash
actual=$(pactl get-default-sink)

if [[ "$actual" == *"hdmi"* ]]; then
  new=$(pactl list short sinks | grep -i corsair | cut -f1)
else
  new=$(pactl list short sinks | grep -i hdmi | cut -f1)
fi
echo $new
pactl set-default-sink $new
