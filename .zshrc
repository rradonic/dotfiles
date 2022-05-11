setopt inc_append_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--color=bg+:-1,fg+:3,hl+:1,info:-1 --no-bold --no-reverse --height=12'

source ~/.zsh_aliases

if [[ $(uname) = Darwin ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Allow keychain access to ssh keys, this is used by containers
ssh-add --apple-load-keychain &> /dev/null

fpath+=$HOME/.zsh/pure

export PURE_GIT_PULL=0

autoload -U promptinit; promptinit
prompt pure

# this is for thinkific dev containers
export DEV_PACKAGES='zsh tmux'

if [[ ! $REMOTE_CONTAINERS ]]; then
  export THINKIFICPATH=/Users/ranko.radonic/src/thinkific
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi
