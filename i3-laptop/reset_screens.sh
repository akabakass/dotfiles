#!/bin/bash

xrandr --output eDP-1 --off 
xrandr --output eDP-1 --auto

xrandr --output HDMI-2 --off 
xrandr --output HDMI-2 --auto 

xrandr --output eDP-1 --pos 640x1080 
