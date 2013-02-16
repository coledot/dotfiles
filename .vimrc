
set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set viminfo='20,\"500   " read/write a .viminfo file -- limit regs to 500 lines
set history=100         " keep n lines of command history
set ruler               " Show the cursor position all the time
set cindent

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=utf-8,latin1
endif

set tenc=utf-8
set enc=utf-8

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
  " Previously we would unset t_RV to prevent gnome-terminal from beeping as
  " vim started.  These days it appears that gnome-terminal has been repaired,
  " so re-enable this, and don't restrict t_Co=8.  (21 Jun 2004 agriffis)
  "set t_RV=			" don't check terminal version
  "set t_Co=8
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2	" only works for >=xfree86-3.3.3, should be okay
endif

" Enable plugin-provided filetype settings, but only if the ftplugin
" directory exists (which it won't on livecds, for example).
if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on
endif

if has("autocmd")

augroup gentoo
  au!

  " Gentoo-specific settings for ebuilds.  These are the federally-mandated
  " required tab settings.  See the following for more information:
  " http://www.gentoo.org/proj/en/devrel/handbook/handbook.xml
  " Note that the rules below are very minimal and don't cover everything.
  " Better to emerge app-vim/gentoo-syntax, which provides full syntax,
  " filetype and indent settings for all things Gentoo.
  au BufRead,BufNewFile *.e{build,class} let is_bash=1|setfiletype sh
  au BufRead,BufNewFile *.e{build,class} set ts=4 sw=4 noexpandtab

  " In text files, limit the width of text to 78 characters, but be careful
  " that we don't override the user's setting.
  autocmd BufNewFile,BufRead *.txt if &tw == 0 | set tw=78 | endif

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif

  " When editing a crontab file, set backupcopy to yes rather than auto. See
  " :help crontab and bug 53437.
  autocmd FileType crontab set backupcopy=yes

augroup END

endif " has("autocmd")




" my crap starts here

colo blugrine

set tabstop=4             " Tab stop size
set shiftwidth=4          " really annoying when it's != tabstop
set ai                    " Always set auto-indenting on
set noexpandtab
"set expandtab             " Tab key inserts spaces instead
                          " of tabs (Ctrl-V <Tab>) to insert
                          " a real one

set incsearch             " jump to text mid-search
set showcmd               " displays last used command
set modeline              " enable vim modelines


" use this to wean off of arrow key usage
"map <Up> :help!<Cr>
"map <Down> :help!<Cr>
"map <Left> :help!<Cr>
"map <Right> :help!<Cr>
"imap <Up> <Esc>:help!<Cr>
"imap <Down> <Esc>:help!<Cr>
"imap <Left> <Esc>:help!<Cr>
"imap <Right> <Esc>:help!<Cr>

set backupdir=~/.vim/backup/
set backup

au BufRead,BufNewFile *.rb set et ts=2 sw=2
