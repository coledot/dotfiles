# TODO alias ls to, ~50% of the time, instead print "stop relying on ls so damn much" to stderr & return 1
alias ll="ls -l"
alias la="ls -la"
alias ltr="ls -ltr"

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

alias gash="git stash"
alias gcod="git checkout -- ."

alias gadcm="git add . && git commit -m"

alias railc="rails c"

# deploy the current branch to staging
# FIXME doesn't work if cwd isn't part of a git repo
#alias stagedis="cap staging deploy HOSTS=dev5.schoolsapp.com BRANCH=`git rev-parse --abbrev-ref HEAD`"

# clobbers access to /usr/bin/sum, but here's how many fucks i give about that: ()
alias sum="awk '{ sum += $1; } END { print sum; }' \"$@\""

if [[ -e `which task` ]]; then
    alias sup="clear; task next"
fi

alias keyon="ssh-add -t 0"
alias keyoff="ssh-add -D"
alias keyls="ssh-add -l"

alias vgr="vagrant"
