HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt autocd

PROMPT='%F{white}%~%f %F{green}♰ %f '

autoload -Uz colors && colors
autoload -Uz compinit
compinit

setopt correct
zstyle ':completion:*' menu select

bindkey '^R' history-incremental-search-backward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias ls='eza --icons=always'
alias la='eza --icons=always -a'
alias ll='eza --icons=always -la'
alias ld='eza --icons=always -la --group-directories-first'
alias lt='eza --icons=always -aT --level=3'
alias gs='git status'
alias gc='git commit -m'
alias gpush='git push'
alias gpull='git pull'
alias ga='git add .'
alias gl='git log --stat'
alias glo='git log --oneline --decorate --all --graph'
alias s='sudo'
alias vim='nvim'
alias grep='rg'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'

export LESSHISTFILE=-
export EDITOR='nvim'
export VISUAL='nvim'
export SUDO_EDITOR='nvim'
export RIPGREP_CONFIG_PATH="$HOME/.config/.ripgreprc"
source ~/.config/zsh/zsh-shift-select/zsh-shift-select.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
