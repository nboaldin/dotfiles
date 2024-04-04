git-clone-bare-for-worktrees() {
    git clone $1 $2
    cd $2
    git checkout $(git commit-tree $(git hash-object -t tree /dev/null) < /dev/null)
}
