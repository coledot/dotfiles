#! /bin/bash

function source_if_exists {
    if [ -f $1 ]; then
        . $1
    fi
}

function prepend_path_if_exists {
    if [ -d $1 ]; then
        export PATH="${1}:${PATH}"
    fi
}

function append_path_if_exists {
    if [ -d $1 ]; then
        export PATH="${PATH}:${1}"
    fi
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export rvm_ignore_gemrc_issues=1

prepend_path_if_exists $HOME/.local/bin
append_path_if_exists $HOME/.rvm/bin
append_path_if_exists $HOME/.cargo/bin
append_path_if_exists $HOME/scripts

if [[ $- == *i* ]] ; then
	source_if_exists $HOME/.bashrc 
fi

# host-specific shenanigans. try to keep this to a minimum
if [[ "$HOSTNAME" == "detune" ]]; then
    GOROOT=/usr/local/go
    GOPATH=$HOME/.go:$HOME/.go
    PATH=/usr/local/bin:/usr/local/sbin:$PATH:$GOROOT/bin:${GOPATH//://bin:}/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    LIBRARY_PATH=/usr/local/lib

    PGDATA=/usr/local/var/postgres

    PERL_MB_OPT="--install_base \"/Users/cole/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=/Users/cole/perl5"; export PERL_MM_OPT;

    export HOMEBREW_NO_ANALYTICS=1
fi

# vim: et ts=4 sw=4
