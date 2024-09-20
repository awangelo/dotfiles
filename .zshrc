# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/angelo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Selection
autoload -U select-word-style
select-word-style bash

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[3~' delete-char

# Prompt/Plugins
eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-shift-select/zsh-shift-select.plugin.zsh
eval "$(zoxide init --cmd cd zsh)"
source <(fzf --zsh)

# Alias
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'

alias ls='eza --icons=always'
alias la='eza --icons=always -a'
alias ll='eza --icons=always -la'
alias ld='eza --icons=always -la --group-directories-first'
alias lt='eza -aT'

alias s=sudo
alias cclean='sudo pacman -Scc; yay -Scc'
alias mkdir='mkdir -p'

alias fetch='neofetch --config ~/.config/neofetch/minha.conf'
alias cmatrix='cmatrix -C magenta'
alias se="fzf --bind 'enter:become(vim {})'"
alias sd='cd $(ls -d **/*(/D) | fzf --exact | cut -c 5-)'
alias vim='nvim'

r() {
    len=${1:-32}
    head /dev/urandom | tr -dc A-Zaa-z0-9 | head -c "$len" ; echo ''
}
