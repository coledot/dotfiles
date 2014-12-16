alias ll="ls -l"
alias la="ls -la"
alias ltr="ls -ltr"

alias fdf="find . -type f"
alias fdd="find . -type d"

alias gcl="git clone"
alias gco="git checkout"
alias glg="git lg"
alias glo="git log"
alias gst="git status"
alias gdf="git diff"
alias gad="git add"
alias gcm="git commit -m"
alias grs="git reset"
alias grm="git rm"
alias gmg="git merge"
alias gll="git pull"
alias gsh="git push"
alias gbl="git blame"
alias gtg="git tag"
alias gmv="git mv"
alias gbs="git bisect"
alias gbr="git branch"

alias gash="git stash"
alias gcmm="git commit"
alias gcod="git checkout -- ."
alias gshv="git shove"
alias gpan="git panic"

alias gadcm="git add . && git commit -m"

alias railc="rails c"

alias pspec='rake parallel:spec; cat log/parallel_summary.log'
alias fpspec='rake parallel:setup; pspec'

# deploy the current branch to staging
alias stagedis="cap staging deploy HOSTS=dev5.schoolsapp.com BRANCH=\`git rev-parse --abbrev-ref HEAD\`"

alias psgsrt='passenger start'
alias psgstp='passenger stop'

# clobbers access to /usr/bin/sum, but here's how many fucks i give about that: ()
alias sum="awk '{ sum += $1; } END { print sum; }' \"$@\""

if [[ -e `which task` ]]; then
    alias sup="clear; task next"
fi

alias keyon="ssh-add -t 0"
alias keyoff="ssh-add -D"
alias keyls="ssh-add -l"

alias vgr="vagrant"
