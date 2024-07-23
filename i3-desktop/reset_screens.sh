#!/bin/bash

xrandr --output DisplayPort-0 --off 
xrandr --output DisplayPort-0 --auto --rotate left  

xrandr --output HDMI-A-0 --off 
xrandr --output HDMI-A-0 --auto --right-of DisplayPort-0

xrandr --output DisplayPort-2 --off
xrandr --output DisplayPort-2 --auto --left-of DisplayPort-0
