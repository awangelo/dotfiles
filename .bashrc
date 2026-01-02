[[ $- == *i* ]] && source -- /usr/share/blesh/ble.sh --attach=none

if declare -F _sudo &>/dev/null; then
    complete -F _sudo sudo
fi

PS1='\[\e[37m\]\w\[\e[m\] \[\e[37m\]λ\[\e[m\] '

alias ls='eza --icons=always'
alias la='eza --icons=always -a'
alias ll='eza --icons=always -la --git'
alias ld='eza --icons=always -la --group-directories-first'
alias lt='eza --icons=always -aT --level=2'
alias gs='git status'
alias gc='git commit -m'
alias gpush='git push'
alias gpull='git pull'
alias ga='git add .'
alias gl='git log --stat'
alias glo='git log --oneline --decorate --all --graph'
alias ..='cd ..'
alias ...='cd ../..'
alias cat='bat'
alias vim='nvim'
alias mkdir='mkdir -p'

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f "/home/angelo/.ghcup/env" ] && . "/home/angelo/.ghcup/env" # ghcup-env

[[ ! ${BLE_VERSION-} ]] || ble-attach
