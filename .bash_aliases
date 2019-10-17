alias d=cd

alias gu="git status"
alias glog="git log"
alias gref="git rev-parse --short HEAD | tr -d '\n' | xsel -bi"
alias gmessage="git log -1 --pretty=%B | tr -d '\n' | xsel -bi"
alias gpusho="git push -u origin \$(git rev-parse --abbrev-ref HEAD)"
alias gpushf="git push --force-with-lease"
alias gcheckpoint="git add . && git commit -m 'WIP [skip ci]'"

alias grmaster="git checkout master && git pull && git checkout - && git rebase master"
function gri () { git rebase -i HEAD~"$1"; }

alias ub="cd ~/projects/unbounded"
alias lap="cd ~/projects/lcms_admin_panel"
alias up="cd ~/projects/unbounded_planning"

alias clp="cd ~/projects/client-portal"
alias fa="cd ~/projects/facilitator-portal"
alias kh="cd ~/projects/kh-iiab"

alias todo="vim ~/Documents/todo.txt"
