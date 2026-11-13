# Native vi-mode — replaces the zsh-vi-mode plugin (which was slow to load).
# Keeps: jk to leave insert mode, block/beam cursor, prefix history search on
# up/down, and yanks copied to the system clipboard.

bindkey -v
export KEYTIMEOUT=20   # 0.2s — long enough to type "jk"

bindkey -M viins 'jk' vi-cmd-mode

# sane insert-mode editing keys (vi-mode drops some defaults)
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M vicmd '/'  history-incremental-search-backward
bindkey -M vicmd '?'  history-incremental-search-forward

# up/down: history search by the prefix already typed
for _m in viins vicmd; do
  bindkey -M $_m '^[[A' history-beginning-search-backward
  bindkey -M $_m '^[[B' history-beginning-search-forward
  bindkey -M $_m '^[OA' history-beginning-search-backward
  bindkey -M $_m '^[OB' history-beginning-search-forward
done
unset _m

# cursor shape: block in normal mode, beam in insert mode
function zle-keymap-select() {
  case $KEYMAP in
    vicmd)      print -n '\e[2 q' ;;
    viins|main) print -n '\e[6 q' ;;
  esac
}
function zle-line-init() { print -n '\e[6 q' }
zle -N zle-keymap-select
zle -N zle-line-init

# yank to the system clipboard (macOS: pbcopy, Wayland: wl-copy, X11: xclip)
function _clip_copy() {
  if   (( $+commands[pbcopy] ));  then pbcopy
  elif (( $+commands[wl-copy] )); then wl-copy
  elif (( $+commands[xclip] ));   then xclip -selection clipboard
  else cat >/dev/null
  fi
}
function vi-yank-clip() {
  zle vi-yank
  print -rn -- "$CUTBUFFER" | _clip_copy
}
zle -N vi-yank-clip
bindkey -M vicmd 'y' vi-yank-clip
