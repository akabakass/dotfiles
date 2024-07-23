#!/bin/bash
while true
do
  if (( $RANDOM % 2 )); then feh --randomize --bg-fill ~/Images/wallpaper/*; else spacewall --random; fi
  sleep 600
done
