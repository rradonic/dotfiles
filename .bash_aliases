alias c=cd

function cs () {
  cd "$@" && ll
}

alias gu="git status"
alias glog="git log"
alias gref="git rev-parse --short HEAD | tr -d '\n' | xsel -bi"
alias gmessage="git log -1 --pretty=%s | tr -d '\n' | xsel -bi"
alias gpusho="git push -u origin \$(git rev-parse --abbrev-ref HEAD)"
alias gpushf="git push --force-with-lease"
alias grebase="git checkout master && git pull && git checkout - && git rebase master"

alias ub="cd ~/projects/unbounded"
alias lap="cd ~/projects/lcms_admin_panel"
alias up="cd ~/projects/unbounded_planning"
