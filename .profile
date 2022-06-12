# vim: et ts=4 sw=4
# set PATH so it includes user's private bin if it exists
if [ -d $HOME/.local/bin ] ; then
    PATH=$HOME/.local/bin:"${PATH}"
fi

export EDITOR=/usr/bin/vim
export PATH="$HOME/.cargo/bin:$HOME/.rvm/bin:$PATH"
export HOMEBREW_NO_ANALYTICS=1

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# defining these results in less dotfile spam in the home directory
export ZDOTDIR="$HOME"/.config/zsh

export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}"/gem
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GEM_HOME="${XDG_DATA_HOME}"/gem
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export _Z_DATA="$XDG_DATA_HOME/z"
export WINEPREFIX="$XDG_DATA_HOME"/wine

export HISTFILE="$XDG_STATE_HOME"/zsh/history

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

