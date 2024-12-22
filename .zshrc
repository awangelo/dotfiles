# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/angelo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install


bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

source <(fzf --zsh)
eval "$(starship init zsh)"


# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'

alias ls='eza --icons=always'
alias la='eza --icons=always -a'
alias ll='eza --icons=always -la'
alias lf='eza --icons=always -la --group-directories-first'
alias ld='eza -aD'
alias lt='eza -aT'

alias s=sudo
alias cclean='sudo pacman -Scc; yay -Scc'
alias mkdir='mkdir -p'
alias se="fzf --bind 'enter:become(vim {})'"
alias sd='cd $(ls -d **/*(/D) | fzf --exact | cut -c 5-)'
#alias vim='nvim'

r() {
    length=${1:-32}
    head /dev/urandom | tr -dc A-Za-z0-9 | head -c "$length" ; echo ''
}

source /home/angelo/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/angelo/.config/zsh-autosuggestions/zsh-autosuggestions.zsh
