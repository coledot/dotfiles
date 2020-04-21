#! /bin/bash

function source_if_exists {
    if [ -f $1 ]; then
        . $1
    fi
}

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
if [[ -d $HOME/scripts ]]; then
    export PATH=${PATH}:$HOME/scripts
fi
export rvm_ignore_gemrc_issues=1

shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

# grab env vars from ssh agent
if [ ! -z "$SSH_CLIENT" ]; then
    source_if_exists $HOME/.ssh-agent
fi

if [[ $- == *i* ]]; then
    source_if_exists $HOME/.bash_aliases
    source_if_exists $HOME/.bash_interactive
    source_if_exists $HOME/.commacd.bash
fi

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

    GOROOT=/usr/local/go
    GOPATH=$HOME/.go:$HOME/.go
    PATH=/usr/local/bin:/usr/local/sbin:$PATH:$GOROOT/bin:${GOPATH//://bin:}/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib

    PGDATA=/usr/local/var/postgres

    PERL_MB_OPT="--install_base \"/Users/cole/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=/Users/cole/perl5"; export PERL_MM_OPT;
fi

# vim: et ts=4 sw=4
