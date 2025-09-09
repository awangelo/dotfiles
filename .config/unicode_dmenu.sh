#!/usr/bin/env bash

SOURCE_JSON="/home/angelo/.config/abbreviations.json"
THEME=(
    -fn "JetBrainsMono Nerd Font:size=15" \
    -nb "#1f1f1f" \
    -nf "#dddddd" \
    -sb "#000000" \
    -sf "#dddddd"
)

selected_entry=$(jq -r 'to_entries[] | "\(.key)  \(.value)"' "$SOURCE_JSON" | dmenu -l 6 "${THEME[@]}")
if [ -z "$selected_entry" ]; then
    exit 0
fi

unicode_char=$(echo "$selected_entry" | awk -F '  ' '{print $2}')

echo -n "$unicode_char" | xclip -selection clipboard
