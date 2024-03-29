alias notes="tmux rename-window notes && vim ~/Dropbox/Documents/vimwiki/index.wiki"

alias gu="git status"
alias glog="git log"
alias gpushf="git push --force-with-lease"
alias gpusho="git push -u origin \$(git rev-parse --abbrev-ref HEAD)"
alias gdiff="git diff"

alias gg='cd `git rev-parse --show-toplevel`'
alias gcheckpoint="git add . && git commit -m 'WIP'"
alias grmaster="git checkout master && git pull && git checkout - && git rebase master"
alias gref="git rev-parse --short HEAD | tr -d '\n' | xsel -bi"
alias gmes="git log -1 --pretty=%B | xsel -bi"

function gri () {
  if [ $# -eq 0 ]; then
      echo "No arguments provided. Usage: gri [NUMBER_OF_COMMITS]"
      return 1
  fi

  git rebase -i HEAD~"$1";
}

function srep () {
  if [ $# -eq 0 ]; then
      echo "No arguments provided. Usage: srep [SEARCH_PATTERN] [REPLACE_PATTERN]"
      return 1
  fi

  $FZF_DEFAULT_COMMAND | xargs sed -i "s/$1/$2/g";
}

alias bx="bundle exec"
