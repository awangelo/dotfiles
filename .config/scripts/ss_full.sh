#!/usr/bin/env bash

grim -o eDP-1 -t png ~/Pictures/$(date +'%s.png') && \
wl-copy < ~/Pictures/"$(date +'%s.png')"
