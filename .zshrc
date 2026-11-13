# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -U path fpath

source ~/.zsh/options.zsh
source ~/.zsh/keys.zsh
source ~/.zsh/${OSTYPE%%[0-9.-]*}.zsh   # darwin.zsh or linux.zsh

# plugins: ~/.config/sheldon/plugins.toml
eval "$(sheldon source)"

# completion (-C = trust the cached dump; delete ~/.cache/zsh/zcompdump to rebuild)
fpath=(~/.asdf/completions $fpath)
mkdir -p ~/.cache/zsh
autoload -Uz compinit && compinit -C -d ~/.cache/zsh/zcompdump

# google cloud sdk ($GCLOUD_SDK is set in darwin.zsh / linux.zsh)
if [[ -r $GCLOUD_SDK/path.zsh.inc ]]; then
  source $GCLOUD_SDK/path.zsh.inc
  zsh-defer source $GCLOUD_SDK/completion.zsh.inc
fi

# node, installed by mise (~/.config/mise/config.toml). Put on PATH directly:
# `mise activate` costs ~280ms per launch on this machine (the mise binary itself
# is slow to start), and it would run on every prompt.
path=(~/.local/share/mise/installs/node/24/bin $path)

source ~/.zsh/alias.zsh
source ~/.zsh/function.zsh

# optional, untracked
for f in ~/.zsh/work_alias.zsh ~/.zsh/work_function.zsh ~/.zsh/local.zsh; do
  if [[ -r $f ]]; then source $f; fi
done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
