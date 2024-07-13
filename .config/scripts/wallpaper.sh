#!/usr/bin/env bash

find ~/.config/wallpapers/ -type f | shuf -n 1 | xargs feh --bg-scale
