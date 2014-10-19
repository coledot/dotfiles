set fish_greeting ""

# git shit
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch white bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate cyan
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold

function fish_prompt
  set_color cyan
  echo -n (pwd)
  set_color normal
  echo (__fish_git_prompt)
  set_color green
  echo -n (whoami)
  set_color white
  echo -n "@"(hostname)
  if test (id -u) = 0;
    set sigil "#"
  else
    set sigil "\$"
  end
  set_color normal
  echo -n " $sigil "
end

source ~/.config/fish/alias.fish
source ~/.config/fish/functions/rvm.fish

if test (hostname) = "detune";
  set -x GOROOT          /usr/local/go
  set -x GOPATH          $HOME/.go:$HOME/.go
  set -x PATH            /usr/local/bin /usr/local/sbin $PATH $GOROOT/bin $HOME/.rvm/bin
  set -x PKG_CONFIG_PATH /usr/local/lib/pkgconfig
  set -x LIBRARY_PATH    /usr/local/lib
  set -x PGDATA          /usr/local/var/postgres
end

