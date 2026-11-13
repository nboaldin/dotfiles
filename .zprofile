# Login-shell environment (PATH). Interactive setup lives in ~/.zshrc.

# homebrew — static `brew shellenv` (forking brew is slow). Skipped where brew isn't installed.
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
  export HOMEBREW_CELLAR=/opt/homebrew/Cellar
  export HOMEBREW_REPOSITORY=/opt/homebrew
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
fi

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# esp for dev on udoo key
if [[ -r ~/export-esp.sh ]]; then . ~/export-esp.sh; fi
