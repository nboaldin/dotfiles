# macOS only. Loaded by ~/.zshrc (it picks darwin.zsh or linux.zsh from $OSTYPE).

fpath=(/opt/homebrew/share/zsh/site-functions /opt/homebrew/share/zsh-completions $fpath)
GCLOUD_SDK=/opt/homebrew/share/google-cloud-sdk

alias ls='ls -G'
alias tar='gtar'
