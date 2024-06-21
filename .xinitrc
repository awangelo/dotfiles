picom -b --config ~/.config/picom/picom.conf &
find ~/.config/wallpapers/ -type f | shuf -n 1 | xargs feh --bg-fill &
exec dwm &
clipmenud 
