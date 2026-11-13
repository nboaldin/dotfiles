# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# This file is shared by macOS (main) and Linux (arch-start); OS-specific bits
# are guarded with $OSTYPE.
typeset -U path fpath   # no duplicate PATH/fpath entries

# --- options, keybindings, node ---
source ~/.zsh/options.zsh
source ~/.zsh/keys.zsh
source ~/.zsh/nvm.zsh

# --- plugins (sheldon) ---
# macOS: brew install sheldon    Arch: pacman -S sheldon
# Plugins are listed in ~/.config/sheldon/plugins.toml. `sheldon source` output
# is cached and only regenerated when that file changes.
if (( $+commands[sheldon] )); then
  if [[ $OSTYPE == darwin* ]]; then export SHELDON_PROFILE=darwin; else export SHELDON_PROFILE=linux; fi
  _sheldon_toml="${XDG_CONFIG_HOME:-$HOME/.config}/sheldon/plugins.toml"
  _sheldon_cache="${XDG_CACHE_HOME:-$HOME/.cache}/sheldon-$SHELDON_PROFILE.zsh"
  if [[ ! -s $_sheldon_cache || $_sheldon_toml -nt $_sheldon_cache ]]; then
    mkdir -p "${_sheldon_cache:h}"
    sheldon source > "$_sheldon_cache"
  fi
  source "$_sheldon_cache"
  unset _sheldon_toml _sheldon_cache
else
  print -u2 "zshrc: sheldon not found — plugins and prompt theme not loaded"
fi

# --- completion (cached; full rescan at most once a day) ---
autoload -Uz compinit
_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${_zcompdump:h}"
if [[ -n $_zcompdump(#qN.mh+24) ]]; then compinit -d "$_zcompdump"; else compinit -C -d "$_zcompdump"; fi
unset _zcompdump

# google cloud sdk completion (its .inc runs its own compinit, so it lives here,
# after ours, and is deferred when zsh-defer is available)
for _d in ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share/google-cloud-sdk} /opt/google-cloud-sdk /usr/share/google-cloud-sdk; do
  if [[ -r $_d/completion.zsh.inc ]]; then
    if (( $+functions[zsh-defer] )); then zsh-defer source "$_d/completion.zsh.inc"
    else source "$_d/completion.zsh.inc"; fi
    break
  fi
done
unset _d

source ~/.zsh/alias.zsh
source ~/.zsh/function.zsh

# work-only files (untracked / absent on some machines)
for _f in ~/.zsh/work_alias.zsh ~/.zsh/work_function.zsh; do
  [[ -r $_f ]] && source "$_f"
done
unset _f

# --- Linux (arch-start) only ---
if [[ $OSTYPE == linux* ]]; then
  (( $+commands[fastfetch] )) && fastfetch

  # pnpm
  export PNPM_HOME="$HOME/.local/share/pnpm"
  path=( $PNPM_HOME $path )
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# per-machine overrides (untracked; see .gitignore)
if [[ -r ~/.zsh/local.zsh ]]; then source ~/.zsh/local.zsh; fi
