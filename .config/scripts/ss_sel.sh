#!/usr/bin/env bash

grim -g "$(slurp -d -c '#00000000' -b '#00000033')" ~/Pictures/"$(date +'%s.png')" && \
wl-copy < ~/Pictures/"$(date +'%s.png')"

