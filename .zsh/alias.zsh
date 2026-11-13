alias n="nvim"
alias t="tmux"
alias ta="tmux attach-session"
alias tk="tmux kill-session -t"

alias s="npx supabase"
alias supabase="npx supabase"

alias z="zellij"
alias za="zellij attach"
alias zk="zellij kill-all-sessions"
alias zd="zellij delete-all-sessions"

alias godot4="godot"

#change tool defaults
alias cat="bat --style=plain --theme=ansi"

alias k="kubectl"
alias tf="terraform"
alias lg="lazygit"

# macOS (main)
if [[ $OSTYPE == darwin* ]]; then
  alias tar="gtar"
fi

# Linux (arch-start)
if [[ $OSTYPE == linux* ]]; then
  alias l="ls -alt"
  alias dot="cd ~/dotfiles"
fi
