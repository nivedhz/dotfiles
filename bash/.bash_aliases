alias tm='tmux'
alias c='clear'
alias q='exit'
alias h='history'
alias rel='source ~/.bashrc'
alias yd='yt-dlp'
alias yda='yt-dlp -x --audio-format mp3 --audio-quality 0 --js-runtime node -P ~/Music'

# NAVIGATION
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'

# LISTING
alias l='eza --git-ignore'
alias ll='eza -a --git-ignore'
alias la='eza -lah --git-ignore'
alias lt='eza -T --git-ignore'

# SAFETY
alias rm='rm -i'
alias rmf='rm -rf'
alias cp='cp -i'
alias mv='mv -i'
alias copy='wl-copy'
alias paste='wl-paste'

# SEARCH
alias grep='rg'

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
alias gck='git branch | fzf | xargs git checkout'
alias gr='git remote'

# DEV
alias st='speedtest'
alias py='python3'
alias n='nvim'
alias v='vim .'
alias live='npx live-server'
