#! /bin/bash

shopt -s checkwinsize

export HISTCONTROL=ignoreboth
export HISTSIZE=5000

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
    # FIXME bg color is hosed after using vim
    export PS1='\[\033[01;34m\]\w\[\033[01;37m\] \[\033[00;37m\]$(__git_ps1)\n\[\033[01;32;40m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h \$ \[\033[00m\]'
else
    export PS1='\[\033[01;32;40m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h \[\033[00;37m\]\n\[\033[01;34m\]\w\n\$ \[\033[00m\]'
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

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# If not running interactively, don't do anything
tty -s
if [[ $? -eq 0 ]]; then
  # disable xon/off (annoying)
  stty stop undef
  stty start undef
  stty -ixon
  stty -ixoff
fi

if [[ -d $HOME/scripts ]]; then
    export PATH=${PATH}:$HOME/scripts
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
    alias cdtssh="sudo ssh -i ~/.ssh/id_rsa \
                  -Y cole@cole_inigral"
    alias cdttun="sudo ssh -i ~/.ssh/id_rsa \
                  -L localhost:443:localhost:443 \
                  -L localhost:5555:localhost:5555 \
                  -Y cole@cole_inigral"
    alias telecdttun="sudo ssh -i ~/.ssh/id_rsa \
                  -L localhost:443:localhost:443 \
                  -L localhost:5555:localhost:5555 \
                  -Y -p 5055 cole@localhost"
    alias teleclientcdt="tele -client -in=localhost:5055 -out=cole_inigral:5055"
    alias telesshdelay="sudo ssh -i ~/.ssh/id_rsa -Y -p 5056 cole@localhost"
    alias teleclientdelay="tele -client -in=localhost:5056 -out=delay:5055"

    GOROOT=/usr/local/go
    GOPATH=$HOME/.go:$HOME/.go
    PATH=$PATH:$GOROOT/bin:${GOPATH//://bin:}/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting
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
    export HOMEBREW_GITHUB_API_TOKEN="6bee7984dfe807d8a310ef0c4b60d9f8ff98fd9d"

    # stupid OS X. the default version of screen that ships with OS X
    #   doesn't have 256-color support. workaround is to install it
    #   using homebrew
    alias screen='/usr/local/bin/screen'
    # access cdtvgr from the vpn (to access the app, nav directly to
    # https://cdtvgr.canvas.schoolsapp.com/ on detune)
    alias vgrtun="sudo ssh -i ~/.ssh/deploy_rsa_new \
                  -L 10.42.0.143:443:192.168.33.10:443 \
                  -L 10.42.0.143:5555:192.168.33.10:5555 \
                  vagrant@192.168.33.10"

    alias teleserverssh="tele -server -in=localhost:22 -out=10.42.0.143:5055"

    GOROOT=/usr/local/go
    export GOPATH=$HOME/.go:
    PATH=/usr/local/bin:/usr/local/sbin:$PATH:${GOPATH//://bin:}/bin:$HOME/local/bin:$HOME/.rvm/bin:/usr/local/share/npm/bin
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib

    PGDATA=/usr/local/var/postgres

    SSHAGENT=/usr/bin/ssh-agent
    SSHAGENTARGS="-s"
    if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
        eval `$SSHAGENT $SSHAGENTARGS`
        trap "kill $SSH_AGENT_PID" 0
    fi

    alias pg_restart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log restart"

    alias pspec='rake parallel:spec; cat log/parallel_summary.log'
    alias fpspec='rake parallel:setup; rake parallel:spec; cat log/parallel_summary.log'

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

    export RUBY_HEAP_MIN_SLOTS=1000000
    export RUBY_HEAP_SLOTS_INCREMENT=1000000
    export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
    export RUBY_GC_MALLOC_LIMIT=100000000
    export RUBY_HEAP_FREE_MIN=500000
fi

# vim: et ts=4 sw=4
