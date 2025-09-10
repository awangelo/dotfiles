#!/usr/bin/env bash

JSON="$HOME/.config/symbols.json"

selection=$(jq -r 'to_entries[] | "\(.key)\t\(.value)"' "$JSON" | wofi --dmenu --prompt "" --conf ~/.config/wofi/config --style ~/.config/wofi/style.css)

if [ -n "$selection" ]; then
    symbol=$(awk -F '\t' '{print $2}' <<< "$selection")
    echo -n "$symbol" | wl-copy
fi
