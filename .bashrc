#! /bin/bash

shopt -s checkwinsize

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

if [ -e /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    export GIT_PS1_SHOWDIRTYSTATE=true
    source /usr/local/etc/bash_completion.d/git-prompt.sh
    export PS1='\[\033[01;32;40m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h \[\033[01;30m\]$(__git_ps1)\n\[\033[01;34m\]\w\[\033[01;37m\]\n\$ \[\033[00m\]'
else
    export PS1='\[\033[01;32;40m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h \[\033[01;30m\]\n\[\033[01;34m\]\w\n\$ \[\033[00m\]'
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

export EDITOR=/usr/bin/vim
export TERM=xterm-256color

# needed to use Vim as a man pager
# FIXME breaks `git diff`
#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
#    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
#    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
#    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# grab env vars from ssh agent
if [ ! -z "$SSH_CLIENT" ] && [ -f $HOME/.ssh-agent ]; then
    . $HOME/.ssh-agent
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# add'l completion provided by brew
if [[ ! -z `which brew` && -f $(brew --prefix)/etc/bash_completion ]]; then
    . $(brew --prefix)/etc/bash_completion
fi

# TODO use this
# aliases are defined in a separate file
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

alias ll="ls -l"
alias la="ls -la"
# quack
alias ducks="du -cks"
# cd to newest subdirectory
alias cdn="cd \`ls -ptr | grep '/' | tail -n 1\`"
alias qc="~/scripts/qc.sh"

alias keyon="ssh-add -t 0"
alias keyoff="ssh-add -D"
alias keyls="ssh-add -l"

# If not running interactively, don't do anything
tty -s
if [[ $? -eq 0 ]]; then
    stty stop undef
    stty start undef
fi

# host-specific shenanigans. try to keep this to a minimum
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
    # stupid OS X. the default version of screen that ships with OS X
    #   doesn't have 256-color support. workaround is to install it
    #   using homebrew
    alias screen='/usr/local/bin/screen'

    alias git='/usr/local/bin/git'
    # login to inigral machine & open local tunnel for testing using cole_inigral's passenger instance
    alias cdttun="sudo ssh -i ~/.ssh/id_rsa -L localhost:443:localhost:443 -Y cole@cole_inigral"

    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib

    PGDATA=/usr/local/var/postgres

    SSHAGENT=/usr/bin/ssh-agent
    SSHAGENTARGS="-s"
    if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
        eval `$SSHAGENT $SSHAGENTARGS`
        trap "kill $SSH_AGENT_PID" 0
    fi

elif [[ "$HOSTNAME" == "cole_inigral" ]]; then
    # stupid OS X. the default version of screen that ships with OS X
    #   doesn't have 256-color support. workaround is to install it
    #   using homebrew
    alias screen='/usr/local/bin/screen'

    alias vgr="vagrant"
    # access cdtvgr from the vpn (to access the app, nav directly to https://cdtvgr.canvas.schoolsapp.com/ on detune)
    alias vgrtun="sudo ssh -i ~/.ssh/deploy_rsa_new -L 10.42.0.143:443:192.168.33.10:443 vagrant@192.168.33.10"

    PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.rvm/bin:/usr/local/share/npm/bin
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib

    PGDATA=/usr/local/var/postgres

    #alias scapp_off='sudo stop  schools_workers && sudo service nginx stop  && sudo stop  schools_notifications'
    #alias scapp_on='sudo start schools_workers && sudo service nginx start && sudo start schools_notifications'
    #alias scapp_restart='scapp_off && scapp_on'

    while read line; do
        echo "$line" | egrep '^[ \t]*$|^[ \t]*#' >/dev/null
        if [[ $? -ne 0 ]]; then
            host=$line
            alias $host="screen -X title $host && ssh $host.inigral.com"
        fi
    done < ~/.inigral_ssh_aliases
fi

# vim: et ts=4 sw=4
