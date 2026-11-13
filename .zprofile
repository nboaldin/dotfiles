# Login-shell environment. Shared by macOS (main) and Linux (arch-start).

# homebrew (macOS) — static equivalent of `brew shellenv`; avoids forking brew,
# which is slow. Apple Silicon: /opt/homebrew, Intel: /usr/local. No brew on Linux.
if [[ $OSTYPE == darwin* ]]; then
  if [[ $(uname -m) == arm64 ]]; then _brew=/opt/homebrew; else _brew=/usr/local; fi
  export HOMEBREW_PREFIX=$_brew
  export HOMEBREW_CELLAR=$_brew/Cellar
  export HOMEBREW_REPOSITORY=$_brew
  path=($_brew/bin $_brew/sbin $path)
  export MANPATH="$_brew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="$_brew/share/info:${INFOPATH:-}"
  fpath=($_brew/share/zsh/site-functions $_brew/share/zsh-completions $fpath)
  unset _brew
fi

# google cloud sdk PATH (completion is loaded from ~/.zshrc, after compinit)
for _d in ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share/google-cloud-sdk} /opt/google-cloud-sdk /usr/share/google-cloud-sdk; do
  if [[ -r $_d/path.zsh.inc ]]; then source "$_d/path.zsh.inc"; break; fi
done
unset _d

#asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

#esp for dev on udoo key
[[ -r $HOME/export-esp.sh ]] && . $HOME/export-esp.sh
