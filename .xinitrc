#!/bin/sh

systemctl --user import-environment DISPLAY ${XAUTHORITY+XAUTHORITY}
if command -v dbus-update-activation-environment >/dev/null 2>&1; then dbus-update-activation-environment DISPLAY XAUTHORITY; fi

xset s 300 300
xset dpms 0 0 300
xset r rate 300 30
setxkbmap -layout us,br -variant , -option grp:win_space_toggle,ctrl:nocaps

xwallpaper --zoom "$HOME/Pictures/Wallpapers/wallhaven-5y3q31_1920x1200.png"
export CM_SELECTIONS="clipboard"
export CM_OWN_CLIPBOARD=1
clipmenud >/dev/null 2>&1 &
slstatus &
exec dwm
