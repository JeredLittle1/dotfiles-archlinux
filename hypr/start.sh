#!/usr/bin/env bash

# initialize wallpaper daemon
swww init &
# set wallpaper
swww img ~/.background-image &

# networking
# nm-applet --indicator &

waybar &
dunst
