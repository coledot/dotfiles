# vim: et ts=4 sw=4
# set PATH so it includes user's private bin if it exists
if [ -d $HOME/.local/bin ] ; then
    PATH=$HOME/.local/bin:"${PATH}"
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export HOMEBREW_NO_ANALYTICS=1

export PATH="$HOME/.cargo/bin:$PATH"

