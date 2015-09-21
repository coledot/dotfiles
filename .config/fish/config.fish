#set fish_path $HOME/.oh-my-fish
##set fish_theme robbyrussell
#set fish_plugins rvm
#. $fish_path/oh-my-fish.fish
# overrides/more config
source ~/.config/fish/git.fish
source ~/.config/fish/alias.fish
source ~/.config/fish/functions/rvm.fish

set fish_greeting ""

function fish_prompt
  set host (hostname)
  set git_info (__fish_git_prompt)
  set uid (id -u)
  set sigil "\$"
  if test $uid = 0;
    set sigil "#"
  end
  set_color cyan
  echo -n $PWD
  set_color normal
  echo $git_info
  set_color green
  echo -n $USER
  set_color normal
  echo -n "@$host $sigil "
end

set -x EDITOR /usr/bin/vim
# tmux+vim act funny when this _isn't_ 'screen-256color'
set -x TERM   screen-256color

# fixme git alias auto-completion is hosed

# host-specific
if test (hostname) = "detune";
  set -x GOROOT            /usr/local/go
  set -x GOPATH            $HOME/.go:$HOME/.go
  set -x PATH              /Users/cole/torch/install/bin /usr/local/bin /usr/local/sbin $PATH $GOROOT/bin $HOME/.rvm/bin $HOME/.local/bin
  set -x PKG_CONFIG_PATH   /usr/local/lib/pkgconfig
  set -x LIBRARY_PATH      /usr/local/lib
  set -x PGDATA            /usr/local/var/postgres
  set -x LD_LIBRARY_PATH   /Users/cole/torch/install/lib $LD_LIBRARY_PATH
  set -x DYLD_LIBRARY_PATH /Users/cole/torch/install/lib $DYLD_LIBRARY_PATH

  eval (direnv hook fish)
end

