if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi

# Created by `pipx` on 2025-06-15 01:43:38
export PATH="$PATH:/home/angelo/.local/bin"
