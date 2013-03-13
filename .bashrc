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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    export PS1='\[\033[01;32m\]\u@\[\033[01;37m\]\h\n\[\033[01;34m\]\w\n\$ \[\033[00m\]'
    ;;
*)
    export PS1='\[\033[01;32m\]\u@\[\033[01;37m\]\h\n\[\033[01;34m\]\w\n\$ \[\033[00m\]'
    ;;
esac

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

	alias darwin='  screen -X title darwin  && ssh darwin.inigral.com'
	alias hubble='  screen -X title hubble  && ssh hubble.inigral.com'
	alias teller='  screen -X title teller  && ssh teller.inigral.com'
	alias hofmann=' screen -X title hofmann && ssh hofmann.inigral.com'
	alias curie='   screen -X title curie   && ssh curie.inigral.com'

	alias einstein='screen -X title einstein && ssh einstein.inigral.com'
	alias turing='  screen -X title turing   && ssh turing.inigral.com'
	alias tesla='   screen -X title tesla    && ssh tesla.inigral.com'
	alias newton='  screen -X title newton   && ssh newton.inigral.com'
	alias goodall=' screen -X title goodall  && ssh goodall.inigral.com'
	alias shulgin=' screen -X title shulgin  && ssh shulgin.inigral.com'
	alias euclid='  screen -X title euclid   && ssh euclid.inigral.com'
	alias kamen='   screen -X title kamen    && ssh kamen.inigral.com'
	alias johnson=' screen -X title johnson  && ssh johnson.inigral.com'
	alias sagan='   screen -X title sagan    && ssh sagan.inigral.com'
	alias euler='   screen -X title euler    && ssh euler.inigral.com'
	alias crick='   screen -X title crick    && ssh crick.inigral.com'
	alias bohr='    screen -X title bohr     && ssh bohr.inigral.com'
fi

# vim: et ts=4 sw=4

# TODO:
# Show the current branch name in your bash prompt
#Note this requires the Bash autocompletion script above
#
#Add this to ~/.bash_profile:
#
#export GIT_PS1_SHOWDIRTYSTATE=true
#source /usr/local/etc/bash_completion.d/git-prompt.sh
#Now put $(__git_ps1) in your prompt wherever you want the git branch name to appear. Here's a simple example:
#
#export PS1='\h:\W\$(__git_ps1) \u\$ '
#You can set the PS1 environment variable in ~/.bash_profile
