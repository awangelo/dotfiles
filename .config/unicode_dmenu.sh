#!/usr/bin/env bash

FILE="/home/angelo/.config/abbreviations.json"

SELECTION=$(jq -r 'to_entries | .[] | "\(.key) \(.value)"' "$FILE" | dmenu -i -c -fn "Go Mono:size=12" -nb "#0b0605" -nf "#bbbbbb" -sb "#770b00" -sf "#eeeeee")
[ -z "$SELECTION" ] && exit 0

SYMBOL=$(echo "$SELECTION" | cut -d' ' -f2-)

echo -n "$SYMBOL" | xclip -selection clipboard
