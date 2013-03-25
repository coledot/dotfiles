#! /bin/bash

# FIXME error messages when using scp to cole@cole_inigral:
#       /Users/cole/.bashrc: line 53: brew: command not found
#       stty: stdin isn't a terminal
#       stty: stdin isn't a terminal

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
	export PS1='\[\033[01;32m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h \[\033[01;30m\]$(__git_ps1)\n\[\033[01;34m\]\w\n\$ \[\033[00m\]'
else
	export PS1='\[\033[01;32m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h \[\033[01;30m\]\n\[\033[01;34m\]\w\n\$ \[\033[00m\]'
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
if [ -f $(brew --prefix)/etc/bash_completion ]; then
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

alias keyon="ssh-add -t 0"
alias keyoff="ssh-add -D"
alias keyls="ssh-add -l"

# If not running interactively, don't do anything
if [[ ! -z "$PS1" ]]; then
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

    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib
elif [[ "$HOSTNAME" == "cole_inigral" ]]; then
    # stupid OS X. the default version of screen that ships with OS X
    #   doesn't have 256-color support. workaround is to install it
    #   using homebrew
    alias screen='/usr/local/bin/screen'

    PATH=/usr/local/bin:$PATH:$HOME/.rvm/bin
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib

	PGDATA=/usr/local/var/postgres

	#alias scapp_off='sudo stop  schools_workers && sudo service nginx stop  && sudo stop  schools_notifications'
	#alias scapp_on=' sudo start schools_workers && sudo service nginx start && sudo start schools_notifications'

	while read line; do
		echo "$line" | egrep '^[ \t]*$|^[ \t]*#' >/dev/null
		if [[ $? -ne 0 ]]; then
			host=$line
			alias $host="screen -X title $host && ssh $host.inigral.com"
		fi
	done < ~/.inigral_ssh_aliases
fi

# vim: et ts=4 sw=4

