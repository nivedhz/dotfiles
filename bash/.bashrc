export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc
set -h

# My Commands
source ~/.bash_aliases
if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
  cd ~
fi

# SSH Agent Auto Start
eval $(keychain --eval --quiet id_ed25519)

# User defined functions
# Fuzzy cd
f() {
  local dir

  dir=$(fd . /home/$USER --type d --hidden \
    --exclude .git \
    --exclude node_modules \
    --exclude .cache \
    --exclude .nvm \
    --exclude .npm \
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
    --exclude .nvm \
    --exclude .npm \
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
unalias tw 2>/dev/null

# Default tmux
t() {
  local name

  read -p "Session Name: " name

  tmux new-session -s "$name" -c "$PWD"
}

# Web Dev tmux
tw() {
  local name dir
  dir="$(pwd)"

  # session name
  if [ -n "$1" ]; then
    name="$1"
  else
    read -p "Session Name: " name
  fi

  # attach if already exists
  if tmux has-session -t "$name" 2>/dev/null; then
    if [ -n "$TMUX" ]; then
      tmux switch-client -t "$name"
    else
      tmux attach-session -t "$name"
    fi
    return
  fi

  # create session + windows
  tmux new-session -d -s "$name" -c "$dir" -n core
  tmux new-window -t "$name":2 -c "$dir" -n terminal
  tmux new-window -t "$name":3 -c "$dir" -n live-server

  # run startup commands
  tmux send-keys -t "$name":1 "n" C-m
  tmux send-keys -t "$name":3 "live" C-m

  # go to core
  tmux select-window -t "$name":1

  # attach / switch
  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$name"
  else
    tmux attach-session -t "$name"
  fi
}
