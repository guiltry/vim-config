""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTE:
" I write it by category
" The idea is mainly came from here, http://dougblack.io/words/a-good-vimrc.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""
" Package Manager
""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'

call vundle#end()            " required
filetype plugin indent on    " required


""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""
set background=dark
colorscheme solarized
syntax enable


""""""""""""""""""""""""
" Spaces & Tabs
""""""""""""""""""""""""
set tabstop=2
set softtabstop=2
set expandtab
set encoding=utf-8 nobomb
set autoindent
set shiftwidth=2


""""""""""""""""""""""""
" UI Config
""""""""""""""""""""""""
set number
set ruler
set showcmd
set list
set listchars=tab:>·,trail:·
set cursorline
set wildmenu
set wildmode=list:longest,full
set lazyredraw
set ttyfast
set noerrorbells
set visualbell
set t_vb=


""""""""""""""""""""""""
" Searching
""""""""""""""""""""""""
set incsearch
set hlsearch
set ignorecase
set smartcase

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR> 

set tags=tags;/

""""""""""""""""""""""""
" Moving
""""""""""""""""""""""""
nnoremap j gj
nnoremap k gk

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

set scrolloff=5

""""""""""""""""""""""""
" Tricks
""""""""""""""""""""""""
map n nzz
map N Nzz
map <C-o> <C-o>zz
map <C-i> <C-i>zz
nnoremap ; :

" PHP
imap <C-l> ->


""""""""""""""""""""""""
" Backups
""""""""""""""""""""""""
set backup
set writebackup

if !isdirectory($HOME."/.vim/backups")
  call mkdir($HOME."/.vim/backups", "p")
endif
if !isdirectory($HOME."/.vim/swaps")
  call mkdir($HOME."/.vim/swaps", "p")
endif
if !isdirectory($HOME."/.vim/undo")
  call mkdir($HOME."/.vim/undo", "p")
endif

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
