export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc
set -h

# My Commands
source ~/.bash_aliases
cd ~

# SSH Agent Auto Start
eval $(keychain --eval --quiet id_ed25519)

# NVM
. "$HOME/.local/share/../bin/env"

# User defined functions
# Fuzzy cd
f() {
  local dir

  dir=$(fd --type d --hidden \
    --exclude .git \
    --exclude node_modules \
    --exclude .cache \
    2>/dev/null |
    fzf --preview 'eza -la {}' --preview-window=right:60%)

  [ -n "$dir" ] && cd "$dir"
}

# Fuzzy nvim
ffv() {
  local file

  file=$(fd --type f --hidden \
    --exclude .git \
    --exclude node_modules \
    2>/dev/null |
    fzf --preview 'bat --style=numbers --color=always {}' \
      --preview-window=right:60%)

  [ -n "$file" ] && nvim "$file"
}

# Fuzzy zoxide
fcd() {
  local dir
  dir=$(zoxide query -l | fzf)

  [ -n "$dir" ] && cd "$dir"
}
bind -x '"\C-f": fcd'

# Tmux
unalias t 2>/dev/null
t() {
  if [ -n "$1" ]; then
    tmux new -s "$1"
  elif tmux has-session 2>/dev/null; then
    tmux attach
  else
    read -p "Session name: " name
    tmux new -s "$name"
  fi
}
