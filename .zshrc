setopt inc_append_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export RG_FILTER=('-g' "'!.git'" '-g' "'!db/data/*'" '-g' "'!**/vendor/*'" '-g' "'!**/fonts/*'" '-g' "'!spec/dummy/*'" '-g' "'!*.lock'")
export RG_FILTER_SERIALIZED="${RG_FILTER[@]}"
export FZF_DEFAULT_COMMAND="rg --files --hidden --sort-files $RG_FILTER_SERIALIZED"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--color=bg+:-1,fg+:3,hl+:1,info:-1 --no-bold --no-reverse --height=12'

export THINKIFICPATH=/Users/ranko.radonic/src/Thinkific

source ~/.zsh_aliases

if [[ $(uname) = Darwin ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Allow keychain access to ssh keys, this is used by containers
ssh-add --apple-load-keychain &> /dev/null

fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit
prompt pure

# this is for thinkific dev containers
export DEV_PACKAGES='zsh tmux ripgrep'
