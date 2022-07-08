autoload -U select-word-style
select-word-style bash

setopt inc_append_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--color=bg+:-1,fg+:3,hl+:1,info:-1 --no-bold --no-reverse --height=12'

source ~/.zsh_aliases

fpath+=$HOME/.zsh/pure
fpath+=$HOME/.zsh

export PURE_GIT_PULL=0

autoload -U promptinit; promptinit
autoload -U compinit; compinit

prompt pure

# this will only execute if we're not in a thinkific dev container
if [[ $CODE_FOLDER != "/app" ]]; then
  if [[ $(uname) = Darwin ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  export THINKIFICPATH=/Users/ranko.radonic/src/thinkific
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# this is for thinkific dev containers
export DEV_PACKAGES='zsh tmux'

# allow keychain access to ssh keys, this is used by containers
ssh-add --apple-load-keychain &> /dev/null

export LESS='-SR'
export DISABLE_SPRING=1
