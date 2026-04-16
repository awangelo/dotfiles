#!/usr/bin/env bash

FILE="/home/angelo/.config/abbreviations.json"

SELECTION=$(jq -r 'to_entries | .[] | "\(.key) \(.value)"' "$FILE" | dmenu -i -c -fn "Go Mono:size=12" -nb "#eee8d5" -nf "#586e75" -sb "#fdf6e3" -sf "#268bd2")
[ -z "$SELECTION" ] && exit 0

SYMBOL=$(echo "$SELECTION" | cut -d' ' -f2-)

echo -n "$SYMBOL" | xclip -selection clipboard
