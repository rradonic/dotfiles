setopt inc_append_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export RG_FILTER=('-g' '!db/data/*' '-g' '!**/vendor/*' '-g' '!**/fonts/*' '-g' '!spec/dummy/*' '-g' '!*.lock')
export RG_FILTER_SERIALIZED="${RG_FILTER[@]}"
export FZF_DEFAULT_COMMAND="rg --files --sort-files $RG_FILTER_SERIALIZED"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--color=bg+:-1,fg+:3,hl+:1,info:-1 --no-bold --no-reverse --height=12'

setopt PROMPT_SUBST
autoload -U colors && colors
autoload -Uz vcs_info

precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b) '
zstyle ':vcs_info:git:*' actionformats '(%b|%a) '

PS1='%{$fg[yellow]%}%* %{$fg[blue]%}%~ %{$fg[magenta]%}${vcs_info_msg_0_}%{$reset_color%}$ '
