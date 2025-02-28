# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

# google cloud sdk components
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

#asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# . /opt/homebrew/opt/asdf/libexec/asdf.sh
# fpath=($HOME/.asdf/completions $fpath)

#nvm
export NVM_DIR="$HOME/.nvm"

#esp for dev on udoo key
. $HOME/export-esp.sh

