autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT='%F{blue}%~%f $vcs_info_msg_0_
> '
# RPROMPT=''
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

autoload -U select-word-style
select-word-style bash

setopt inc_append_history

zle_highlight+=(paste:none)

source ~/.zsh_aliases

fpath+=$HOME/.zsh
fpath=(${ASDF_DIR}/completions $fpath)

if [[ -f /.dockerenv ]]; then
  # this will only execute if we're in a container

  # set up fzf key bindings and fuzzy completion, for fzf installed via git
  source ~/.fzf.zsh

  export EDITOR='code --wait'
else
  # outside of container

  if [[ $(uname) = Darwin ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  export THINKIFICPATH=/Users/ranko.radonic/Thinkific
  export TMONOLITH=/Users/ranko.radonic/Thinkific/workspace/thinkific-dev
  export TUNIFIED=/Users/ranko.radonic/Thinkific/workspace/graphql-federation
  export TCHALK=/Users/ranko.radonic/Thinkific/workspace/chalk-dev

  source "$HOME/.asdf/asdf.sh"

  # set up fzf key bindings and fuzzy completion, for fzf installed via homebrew
  source <(fzf --zsh)
fi

autoload -U compinit && compinit

# packages to install inside of thinkific dev containers
export DEV_PACKAGES='zsh tmux'

# allow keychain access to ssh keys, this is used by containers
ssh-add --apple-load-keychain &> /dev/null

export LESS='-SRFI'
export DISABLE_SPRING=1
export DOCKER_CLI_HINTS=false

export FZF_DEFAULT_OPTS='--color=bg+:-1,fg+:3,hl+:1,info:-1 --no-bold --no-reverse --height=12'

