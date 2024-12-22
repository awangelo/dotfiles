#!/usr/bin/env bash

WALLPAPER_DIR="/home/angelo/.config/wallpapers"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

swww img "$WALLPAPER" --transition-step 5 --transition-fps 60
