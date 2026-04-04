xrandr --output HDMI-0 --mode 1920x1080 --rate 180.00

export CM_SELECTIONS="clipboard"
clipmenud &

dbus-update-activation-environment --systemd DISPLAY XAUTHORITY
eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets)

feh --no-fehbg --bg-fill Pictures/Wallpapers/13.jpg

setxkbmap -option ctrl:nocaps &

slstatus &

exec dwm
