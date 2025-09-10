HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

autoload -Uz colors && colors
autoload -Uz compinit
compinit
setopt correct
zstyle ':completion:*' menu select

bindkey '^[[1;5D' backward-word # C+Left
bindkey '^[[1;5C' forward-word  # C+Right
bindkey '^[[1;6D' backward-word # C+S+Left
bindkey '^[[1;6C' forward-word  # C+S+Right

bindkey "^R" history-incremental-search-backward

PROMPT='%F{color7}%~%f %F{color7}λ%f '

alias s='sudo'
alias vim='nvim'
alias cclean='sudo pacman -Sc; paru -Sc'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'

alias ls='eza --icons=always'
alias la='eza --icons=always -a'
alias ll='eza --icons=always -la'
alias ld='eza --icons=always -la --group-directories-first'
alias lt='eza --icons=always -aT'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -f "/home/angelo/.ghcup/env" ] && . "/home/angelo/.ghcup/env" # ghcup-env