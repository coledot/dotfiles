# vim: et ts=4 sw=4
# set PATH so it includes user's private bin if it exists
if [ -d $HOME/.local/bin ] ; then
    PATH=$HOME/.local/bin:"${PATH}"
fi

export EDITOR=/usr/bin/vim
export PATH="$HOME/.cargo/bin:$HOME/.rvm/bin:$PATH"
export HOMEBREW_NO_ANALYTICS=1

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

