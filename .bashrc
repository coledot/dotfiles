#! /bin/bash

function start_ssh_agent {
  SSHAGENT=/usr/bin/ssh-agent
  SSHAGENTARGS="-s"
  if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    echo "Initialising new SSH agent..."
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
    echo succeeded
    /usr/bin/ssh-add -t 0;
  fi
}

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export EDITOR=/usr/bin/vim
export TERM=xterm-256color

# more fun stuff re: completion
GITINFO=''
if [ -e /usr/share/git/completion/git-prompt.sh ]; then
    export GIT_PS1_SHOWDIRTYSTATE=true
    source /usr/share/git/completion/git-prompt.sh
    GITINFO=' \[\033[00;37m\]$(__git_ps1)'
fi

CURRENTDIR='\[\033[01;34m\]\w\[\033[01;37m\]'
USERATHOST='\[\033[01;32m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h\[\033[00;37m\]'
RESETCOLOR='\[\033[00m\]'
export PS1="${CURRENTDIR}${GITINFO}\n${USERATHOST} \$ ${RESETCOLOR}"
unset CURRENTDIR
unset USERATHOST
unset RESETCOLOR
unset GITINFO

shopt -s histappend
shopt -s checkwinsize

# disable xon/off (annoying)
stty stop undef
stty start undef
stty -ixon
stty -ixoff

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

if [ -e /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    __git_complete gco _git_checkout
    __git_complete gdf _git_diff
    __git_complete gll _git_pull
    __git_complete gsh _git_push
fi

# grab env vars from ssh agent
if [ ! -z "$SSH_CLIENT" ]; then
    source_if_exists $HOME/.ssh-agent
fi

source_if_exists $HOME/.bash_aliases
source_if_exists $HOME/.commacd.bash

# autostart tmux, but only if in Xorg and if shell is interactive
[[ $DISPLAY ]] && [[ -z "$TMUX" ]] && exec tmux

# host-specific shenanigans. try to keep this to a minimum
if [[ "$HOSTNAME" == "detune" ]]; then
    # add'l completion provided by brew
    if [[ -f /usr/local/bin/brew ]]; then
        BREW_PREFIX=`brew --prefix`
        if [[ -f $BREW_PREFIX/etc/bash_completion ]]; then
            . $BREW_PREFIX/etc/bash_completion
        fi
    else
        BREW_PREFIX=''
    fi

    alias git='/usr/local/bin/git'
fi

# vim: et ts=4 sw=4
