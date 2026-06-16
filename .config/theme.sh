#!/usr/bin/env bash

THEME=$(flavours list | tr -s ' ' '\n' | dmenu -i)
[[ -z "$THEME" ]] && exit 0

flavours apply "$THEME"

FONT=$(cat ~/.config/theme/fonts.list | dmenu -i)
[[ -z "$FONT" ]] && exit 0

cat <<EOF > ~/.config/theme/font.Xresources
dwm.font: $FONT:size=12
dmenu.font: $FONT:size=12
EOF

cat <<EOF > ~/.config/alacritty/font.toml
[font.normal]
family = "$FONT"
[font]
size = 12.0
EOF

xrdb -merge ~/.Xresources

xdotool key super+F5
