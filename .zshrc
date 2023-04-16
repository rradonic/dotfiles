autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT='%F{yellow}%*%f %F{blue}%~%f $vcs_info_msg_0_❯ '
# RPROMPT=''
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f '
zstyle ':vcs_info:*' enable git

autoload -U select-word-style
select-word-style bash

setopt inc_append_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--color=bg+:-1,fg+:3,hl+:1,info:-1 --no-bold --no-reverse --height=12'

source ~/.zsh_aliases

fpath+=$HOME/.zsh

autoload -U compinit && compinit

# this will only execute if we're not in a thinkific dev container
if [[ $CODE_FOLDER != "/app" ]]; then
  if [[ $(uname) = Darwin ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  export THINKIFICPATH=/Users/ranko.radonic/Thinkific
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# this is for thinkific dev containers
export DEV_PACKAGES='zsh tmux'

# allow keychain access to ssh keys, this is used by containers
ssh-add --apple-load-keychain &> /dev/null

export LESS='-SR'
export DISABLE_SPRING=1
