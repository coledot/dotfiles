set autoindent
set autoread
set backup
set cindent
set noequalalways
set expandtab
set hidden
set incsearch
set modeline
set number
set ruler
set showcmd
set showmode
set smartcase

set undolevels=1000
set winminheight=0
set backspace=2
set viminfo='20,\"500
set history=1000
set tabstop=2
set shiftwidth=2
set t_Co=256
set laststatus=2
set directory-=.                                             " don't store swapfiles in the current directory
set colorcolumn=110
set shell=/bin/bash

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=utf-8,latin1
endif
if $TMUX == ''
  set clipboard=unnamed                                        " yank and paste with the system clipboard
end
set tenc=utf-8
set enc=utf-8

set complete=.,b,u,]

syntax enable

" tabs are something I'm trying to phase out, and EOL whitespace is a big peeve, so have it highlight when either happens
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red

" easy navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-_> <C-w>_

" Don't use Ex mode, use Q for formatting
map Q gq

" needed to use Vim as a man page reader
let $PAGER=''

let mapleader=" "

"let g:miniBufExplSplitBelow = 1 " MiniBufExplorer on bottom
"let g:miniBufExplMaxSize = 3 " no. lines to use
""let g:miniBufExplMapWindowNavVim = 1 " Ctrl + [hjkl] to navigate
"let g:miniBufExplMapCTabSwitchBufs = 1 " Ctrl {, + Shift} + Tab to navigate

let g:ctrlp_custom_ignore = '\v[\/]tmp$'

let g:accordion_mode="h"

noremap <silent><Leader>/ :nohls<CR>
noremap <silent><Leader>o :split<CR>:CtrlP .<CR>
noremap <silent><Leader>d :NERDTreeToggle<CR>
noremap <silent><Leader>f :NERDTreeFind<CR>
" NOTE trailing whitespace intended
noremap <Leader>a :Ack 
noremap <Leader>t :Tabularize 
nnoremap <C-'> :bnext<CR>
nnoremap <C-;> :bprev<CR>

filetype off
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
au BufRead,BufNewFile *.rb,*.erb,*.rake match ExtraWhitespace /\s\+$\|\t/
au BufRead,BufNewFile *.js,*.js.coffee  set et ts=2 sw=2
au BufRead,BufNewFile *.ts              set et ts=2 sw=2
au BufRead,BufNewFile *.html            set et ts=2 sw=2
au BufRead,BufNewFile *.md              set filetype=markdown
" puppet
au BufRead,BufNewFile *.pp              set et ts=2 sw=2
" one of vim, cron, or OSX isn't so bright... take your pick.
au BufEnter /private/tmp/crontab.*      setl backupcopy=yes

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"if !has("gui_running")
"  set background=dark
"  colorscheme solarized
"endif

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
  source $VIMRUNTIME/mswin.vim
  behave mswin

  set nocompatible

  set backupdir=~/.vim/backup
  set directory=~/.vim/swaps,. " condense swap files in one dir
endif

" vim: et ts=2 sw=2
