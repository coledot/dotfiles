# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

## If not running interactively, don't do anything
#[ -z "$PS1" ] && return

shopt -s checkwinsize

#Changes default manpager to vim
#export MANPAGER="col -b | view -c 'set ft=man nomod nolist' -"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    export PS1='\[\033[01;32m\]\u@\[\033[01;37m\]\h \[\033[01;36m\]\t \[\033[01;34m\]\W \$ \[\033[00m\]'
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    export PS1='\[\033[01;32m\]\u@\[\033[01;37m\]\h \[\033[01;36m\]\t \[\033[01;34m\]\W \$ \[\033[00m\]'
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

if [[ "$HOSTNAME" == "trace" ]]; then
    # enable color support of ls and also add handy aliases
    if [ "$TERM" != "dumb" ]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
    fi
    
    export PATH="${PATH}:/home/cole/local/bin:/home/cole/local/gcc-4.2.4-glibc-2.3.6/i686-unknown-linux-gnu/bin"
    export DSSI_PATH="/home/cole/.dssi:/usr/local/lib/dssi:/usr/lib/dssi:/home/cole/local/lib/dssi"
    
    export GOROOT="/home/cole/go"
    export GOARCH=amd64
    export GOOS=linux
    export GOBIN="/home/cole/local/bin"

    export LD_LIBRARY_PATH="/usr/local/lib"
elif [[ "$HOSTNAME" == "detune" ]]; then
    # stupid OS X
    alias screen='TERM=screen screen'

    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib
fi

alias ll="ls -l"
alias la="ls -la"
export EDITOR=/usr/bin/vim

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# quack
alias ducks="du -cks"
# cd to newest subdirectory
alias cdn="cd \`ls -ptr | grep '/' | tail -n 1\`"

# grab env vars from ssh agent
if [ ! -z "$SSH_CLIENT" ] && [ -f $HOME/.ssh-agent ]; then
	. $HOME/.ssh-agent
fi

alias keyon="ssh-add -t 0"
alias keyoff="ssh-add -D"
alias keyls="ssh-add -l"

# FIXME does this break non-interactive programs?
stty stop undef
stty start undef

# vim: et ts=4 sw=4

