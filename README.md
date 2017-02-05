having your dotfiles in git is fantastic
it's like time machine for your dev environment
(for your health)

usage:

clone to ~/.dotfiles

`git clone https://github.com/coledot/dotfiles.git ~/.dotfiles`

cd into dir

`cd ~/.dotfiles`

grab submodules incl. vim plugins & tmux plugins

`git submodule init`

`git submodule update`

run installer, this creates symlinks from locations in ~/ to all files defined in ~/.dotfiles:

`./dotfile_installer.sh`

you're done, go nuts
