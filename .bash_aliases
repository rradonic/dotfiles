alias notes="tmux rename-window notes && vim ~/Dropbox/Personal/notes.txt"

alias gu="git status"
alias glog="git log"
# alias gref="git rev-parse --short HEAD | tr -d '\n' | xsel -bi"
# alias gmes="git log -1 --pretty=%B | xsel -bi"
# alias gdiff="git diff"

alias gpusho="git push -u origin \$(git rev-parse --abbrev-ref HEAD)"
alias gpushon="git push -u origin \$(git rev-parse --abbrev-ref HEAD) --no-verify"

alias gpushf="git push --force-with-lease"
# alias gpushfn="git push --force-with-lease --no-verify"

alias gcheckpoint="git add . && git commit -m 'WIP [skip ci]'"

alias grmaster="git checkout master && git pull && git checkout - && git rebase master"
function gri () { git rebase -i HEAD~"$1"; }

alias bx="bundle exec"
