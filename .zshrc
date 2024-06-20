# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

HISTFILE=~/.zsh_history

# "random" then echo $RANDOM_THEME
ZSH_THEME="robbyrussell"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-shift-select)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
source $ZSH/oh-my-zsh.sh

# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'

alias ls='eza --icons'
alias la='eza --icons -a'
alias ll='eza --icons -la'
alias lf='eza --icons -la --group-directories-first'
alias ld='eza -aD'
alias lt='eza --icons -aT'

alias s=sudo
alias cclean='sudo pacman -Scc; yay -Scc'
alias mkdir='mkdir -p'

r() {
    length=${1:-32}
    head /dev/urandom | tr -dc A-Za-z0-9 | head -c "$length" ; echo ''
}
