# Linux (Arch) only. Loaded by ~/.zshrc (it picks darwin.zsh or linux.zsh from $OSTYPE).

export SHELDON_PROFILE=linux   # enables the linux-only plugins in plugins.toml
GCLOUD_SDK=/opt/google-cloud-sdk

alias ls='ls --color=auto'
alias dot='cd ~/dotfiles'

export PNPM_HOME="$HOME/.local/share/pnpm"
path=($PNPM_HOME $path)

if (( $+commands[fastfetch] )); then fastfetch; fi
