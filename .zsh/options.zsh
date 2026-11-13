# Shell options — replaces the parts of oh-my-zsh's lib/ that antigen was loading
# (history, completion, directory handling, ls aliases). Portable: macOS + Linux.

# --- history ---
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history hist_expire_dups_first hist_ignore_dups hist_ignore_space \
       hist_verify share_history

# --- directories ---
setopt auto_cd auto_pushd pushd_ignore_dups pushdminus
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
md() { mkdir -p -- "$1" && cd -- "$1" }
alias rd=rmdir

# --- misc ---
setopt interactive_comments long_list_jobs multios
unsetopt flowcontrol beep

# --- completion behaviour (compinit itself runs in ~/.zshrc) ---
setopt complete_in_word always_to_end auto_menu path_dirs
unsetopt menu_complete
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# --- ls (the `ls` colour flag itself is set in darwin.zsh / linux.zsh) ---
alias ll='ls -lh'
alias la='ls -lAh'
