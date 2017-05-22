# vim: et ts=4 sw=4
# set PATH so it includes user's private bin if it exists
if [ -d $HOME/bin ] ; then
    PATH=$HOME/bin:"${PATH}"
fi
if [ -d $HOME/.local/bin ] ; then
    PATH=$HOME/.local/bin:"${PATH}"
fi

if [ -f /Users/cole/torch/install/bin/torch-activate ]; then
    . /Users/cole/torch/install/bin/torch-activate
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export HOMEBREW_NO_ANALYTICS=1

export PATH="$HOME/.cargo/bin:$PATH"
