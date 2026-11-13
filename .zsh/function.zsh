git-clone-bare-for-worktrees() {
    git clone $1 $2
    cd $2
    git checkout $(git commit-tree $(git hash-object -t tree /dev/null) < /dev/null)
}

# Create (or reuse) a tmux session named after the current directory.
ts() {
  # tmux session names can't contain '.' or ':'
  local name=${${PWD:t}//[.:]/_}

  if ! tmux has-session -t "=$name" 2>/dev/null; then
    # Single tmux invocation; size to the current terminal so nvim/lazygit
    # don't start at 80x24 and redraw on attach.
    tmux new-session -d -s "$name" -c "$PWD" -n code -x "${COLUMNS:-200}" -y "${LINES:-50}" \; \
      send-keys 'nvim .' C-m \; \
      new-window -n term -c "$PWD" \; \
      split-window -h -c "$PWD" \; \
      select-pane -T ai \; \
      new-window -n git -c "$PWD" \; \
      send-keys 'lg' C-m \; \
      select-window -t "$name:code"
  fi

  if [[ -n $TMUX ]]; then
    tmux switch-client -t "=$name"
  else
    tmux attach-session -t "=$name"
  fi
}

zs() {
    zellij --session "$(basename "$PWD")"
}
