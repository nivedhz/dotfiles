alias tm='tmux'
alias c='clear'
alias q='exit'
alias h='history'
alias rel='source ~/.bashrc'

# NAVIGATION
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'

# LISTING
alias l='eza'
alias ll='eza -lah'
alias la='eza -a'
alias lt='eza --tree'

# SAFETY
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias copy='wl-copy'
alias paste='wl-paste'

# SEARCH
alias grep='grep --color=auto'
alias fd='find ~ -type d | fzf'
alias fcd='cd $(fd)'
alias ffv='nvim $(find ~ -type f | fzf)'

# SYSTEMw
alias df='df -h'
alias du='du -h'
alias free='free -h'

# APT
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias autoremove='sudo pacman -Rns $(pacman -Qdtq)'

# GIT
alias g='git'
alias gs='git status'
alias ga='git add '
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gck='git checkout'
alias gr='git remote'

# DEV
alias st='speedtest'
alias py='python3'
alias nv='nvim'
