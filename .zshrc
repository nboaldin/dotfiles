# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $(brew --prefix)/share/antigen/antigen.zsh

antigen use oh-my-zsh # Add Oh-My-ZSH as an API for plugins and theme

antigen bundles <<EOBUNDLES
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-syntax-highlighting
lukechilds/zsh-nvm
EOBUNDLES

antigen theme romkatv/powerlevel10k

antigen apply

# ruby version manager
eval "$(frum init)"

source ~/.zsh/alias.zsh
source ~/.zsh/function.zsh

source ~/.zsh/work_alias.zsh
source ~/.zsh/work_function.zsh


if [[ -z $TMUX ]]; then
  PATH="$PATH"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
