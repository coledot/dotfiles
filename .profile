# set PATH so it includes user's private bin if it exists
if [ -d $HOME/bin ] ; then
    PATH=$HOME/bin:"${PATH}"
fi

# vim: et ts=4 sw=4

. /Users/cole/torch/install/bin/torch-activate

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export HOMEBREW_NO_ANALYTICS=1
