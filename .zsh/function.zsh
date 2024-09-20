git-clone-bare-for-worktrees() {
    git clone $1 $2
    cd $2
    git checkout $(git commit-tree $(git hash-object -t tree /dev/null) < /dev/null)
}

ts() {
tmux new-session -d -s $(basename "$PWD") -c "$DIRECTORY" -n code

tmux new-window -t $(basename "$PWD") -n term
tmux send-keys -t code 'hx .' C-m
tmux select-window -t code


tmux attach-session -t $(basename "$PWD")
}

zs() {
    zellij --session "$(basename "$PWD")"
}

