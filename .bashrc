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
if [[ ! -z /usr/local/bin/brew ]]; then
    if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi
# more fun stuff re: completion
if [ -e /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    export GIT_PS1_SHOWDIRTYSTATE=true
    source /usr/local/etc/bash_completion.d/git-prompt.sh
    # FIXME bg color is hosed after using vim
    export PS1='\[\033[01;34m\]\w\[\033[01;37m\] \[\033[00;37m\]$(__git_ps1)\n\[\033[01;32;40m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h \$ \[\033[00m\]'
else
    export PS1='\[\033[01;32;40m\]\u\[\033[0;37m\]@\[\033[01;37m\]\h \[\033[00;37m\]\n\[\033[01;34m\]\w\n\$ \[\033[00m\]'
fi
if [ -e /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    __git_complete gco _git_checkout
    __git_complete gdf _git_diff
    __git_complete gll _git_pull
    __git_complete gsh _git_push
fi

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi
if [ -f $HOME/.commacd.bash ]; then
    . $HOME/.commacd.bash
fi

# If not running interactively, don't do anything
tty -s; if [[ $? -eq 0 ]]; then
  # disable xon/off (annoying)
  stty stop undef
  stty start undef
  stty -ixon
  stty -ixoff
fi

if [[ -d $HOME/scripts ]]; then
    export PATH=${PATH}:$HOME/scripts
fi

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

#function make_ssh_aliases {
#  while read line; do
#      echo "$line" | egrep '^[ \t]*$|^[ \t]*#' >/dev/null
#      if [[ $? -ne 0 ]]; then
#          host=$line
#          #alias $host="screen -X title $host && ssh $host.inigral.com"
#          alias $host="ssh $host.inigral.com"
#      fi
#  done < ~/.inigral_ssh_aliases
#}


# host-specific shenanigans. try to keep this to a minimum
if [[ "$HOSTNAME" == "detune" ]]; then
    alias git='/usr/local/bin/git'
    ## login to inigral machine & open local tunnel for testing using cole_inigral's passenger instance
    #alias cdtssh="sudo ssh -i ~/.ssh/id_rsa \
    #              -Y cole@cole_inigral"
    #alias cdttun="sudo ssh -i ~/.ssh/id_rsa \
    #              -L localhost:443:localhost:443 \
    #              -L localhost:5555:localhost:5555 \
    #              -Y cole@cole_inigral"
    #alias telecdttun="sudo ssh -i ~/.ssh/id_rsa \
    #              -L localhost:443:localhost:443 \
    #              -L localhost:5555:localhost:5555 \
    #              -Y -p 5055 cole@localhost"
    #alias teleclientcdt="tele -client -in=localhost:5055 -out=cole_inigral:5055"
    #alias telesshdelay="sudo ssh -i ~/.ssh/id_rsa -Y -p 5056 cole@localhost"
    #alias teleclientdelay="tele -client -in=localhost:5056 -out=delay:5055"

    GOROOT=/usr/local/go
    GOPATH=$HOME/.go:$HOME/.go
    PATH=/usr/local/bin:/usr/local/sbin:$PATH:$GOROOT/bin:${GOPATH//://bin:}/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib

    PGDATA=/usr/local/var/postgres

    #make_ssh_aliases

    # FIXME
    #SSHAGENT=/usr/bin/ssh-agent
    #SSHAGENTARGS="-s"
    #if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    #    eval `$SSHAGENT $SSHAGENTARGS`
    #    trap "kill $SSH_AGENT_PID" 0
    #fi
fi

# to make a ramdisk: diskutil erasevolume HFS+ 'ramdisk' `hdiutil attach -nomount ram://8388608`

# vim: et ts=4 sw=4

PERL_MB_OPT="--install_base \"/Users/cole/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/cole/perl5"; export PERL_MM_OPT;
