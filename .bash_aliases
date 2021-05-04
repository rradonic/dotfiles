alias notes="vim ~/Documents/notes.txt"

alias gu="git status"
alias glog="git log --stat"
alias gref="git rev-parse --short HEAD | tr -d '\n' | xsel -bi"
alias gmes="git log -1 --pretty=%B | xsel -bi"
alias gdiff="git diff"

alias gpusho="git push -u origin \$(git rev-parse --abbrev-ref HEAD)"
alias gpushon="git push -u origin \$(git rev-parse --abbrev-ref HEAD) --no-verify"

alias gpushf="git push --force-with-lease"
alias gpushfn="git push --force-with-lease --no-verify"

alias gcheckpoint="git add . && git commit -m 'WIP [skip ci]'"

alias grmaster="git checkout master && git pull && git checkout - && git rebase master"
function gri () { git rebase -i HEAD~"$1"; }

alias ub="cd ~/projects/unbounded"
alias lap="cd ~/projects/lcms_admin_panel"
alias up="cd ~/projects/unbounded_planning"

alias clp="cd ~/projects/client-portal"
alias fap="cd ~/projects/facilitator-portal"
alias kh="cd ~/projects/kh-iiab"

alias smc="cd ~/projects/school-mobility-core"
alias uor="cd ~/projects/uo-p3m"
alias sep="cd ~/projects/sepup-lcms"
alias tla="cd ~/projects/tlac"
alias odt="cd ~/projects/odell-tea-lcms"

alias bx="bundle exec"
