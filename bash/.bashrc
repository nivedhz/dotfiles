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

# Use Nvim for Man pages
export MANPAGER="nvim +Man!"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

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
fv() {
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
  local name dir
  dir="$(pwd)"

  if [ -n "$1" ]; then
    name="$1"
  else
    read -p "Session Name: " name
  fi

  if tmux has-session -t "$name" 2>/dev/null; then
    if [ -n "$TMUX" ]; then
      tmux switch-client -t "$name"
    else
      tmux attach-session -t "$name"
    fi
    return
  fi

  tmux new-session -d -s "$name" -c "$PWD" -n core
  tmux new-window -t "$name":2 -c "$dir" -n terminal

  tmux send-keys -t "$name":1 "nvim ." C-m
  # go to core
  tmux select-window -t "$name":1

  # attach / switch
  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$name"
  else
    tmux attach-session -t "$name"
  fi
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
  tmux new-window -t "$name":3 -c "$dir" -n live-website

  # run startup commands
  tmux send-keys -t "$name":1 "nvim ." C-m
  tmux send-keys -t "$name":3 "npm run dev" C-m

  # go to core
  tmux select-window -t "$name":1

  # attach / switch
  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$name"
  else
    tmux attach-session -t "$name"
  fi
}
. "$HOME/.cargo/env"
