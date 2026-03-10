xrandr --output HDMI-0 --mode 1920x1080 --rate 180.00

autocutsel -fork
export CM_SELECTIONS="clipboard"
clipmenud &

dbus-update-activation-environment --systemd DISPLAY XAUTHORITY
eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets)

feh --bg-fill Pictures/Wallpapers/13.jpg

slstatus &

exec dwm
