set showcmd
set showmode
set number
set incsearch
set autoindent
set ruler
set cindent
set noequalalways
set noexpandtab
set modeline
set backup
set autoread

set undolevels=1000
set winminheight=0
set backspace=2
set viminfo='20,\"500
set history=1000
set tabstop=4
set shiftwidth=4
set t_Co=256

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=utf-8,latin1
endif
set tenc=utf-8
set enc=utf-8

set complete=.,b,u,]

syntax enable

map <c-h> <c-w>h
" FIXME broken; <c-j> just puts me into insert mode
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Don't use Ex mode, use Q for formatting
map Q gq

" needed to use Vim as a man page reader
let $PAGER=''

let mapleader=" "

let g:miniBufExplSplitBelow = 1 " MiniBufExplorer on bottom
let g:miniBufExplMaxSize = 3 " no. lines to use
"let g:miniBufExplMapWindowNavVim = 1 " Ctrl + [hjkl] to navigate
let g:miniBufExplMapCTabSwitchBufs = 1 " Ctrl {, + Shift} + Tab to navigate

noremap <silent><Leader>/ :nohls<CR>

" for command-t plugin - remap default file window dialog with split-window file dialog
noremap <silent><Leader>t :split<CR>:CommandT<CR>

call pathogen#infect()

filetype on
filetype plugin on
filetype indent on

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Enable plugin-provided filetype settings, but only if the ftplugin
" directory exists (which it won't on livecds, for example).
if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on
endif

au BufRead,BufNewFile *.py              set et ts=4 sw=4 fdm=indent foldlevel=99
au BufRead,BufNewFile *.rb,*.erb,*.rake set et ts=2 sw=2
" puppet
au BufRead,BufNewFile *.pp              set et ts=2 sw=2

if !has("gui_running")
  " for console only (see .gvimrc, uses zenburn in gvim)
  "colorscheme blugrine
  colorscheme zenburn
endif

if has("win32")
  source $VIMRUNTIME/vimrc_example.vim
  source $VIMRUNTIME/mswin.vim
  behave mswin

  set backupdir=~\vimfiles\backup

  " tell Vim how to properly execute shell commands in Windows
  set shell=cmd
  set shellcmdflag=/C
  
  " needed for vimoutliner
  filetype plugin indent on
  syntax on
  
  " handle unicode gracefully
  if has("multi_byte")
    if &termencoding == ""
      let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8 bomb
    set fileencodings=ucs-bom,utf-8,latin1
  endif
elseif has("unix")
  set nocompatible

  set backupdir=~/.vim/backup
  set directory=~/.vim/swaps,. " condense swap files in one dir
endif

" vim: et ts=2 sw=2

