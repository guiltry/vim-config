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
Plugin 'kien/ctrlp.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'sjl/gundo.vim'

Plugin 'tomtom/tcomment_vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'

" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
" Plugin 'Valloric/YouCompleteMe'

Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-rails'
Plugin 'slim-template/vim-slim'

Plugin 'altercation/vim-colors-solarized'

call vundle#end()            " required
filetype plugin indent on    " required


""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""

" CtrlP
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
if executable('ag')
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = 'ag %s -l -i --nocolor --nogroup -g ""'
endif

nnoremap <Leader>b :<C-U>CtrlPBuffer<CR>
nnoremap <Leader>p :<C-U>CtrlP<CR>


" NERDTree
" Open NERDTree if no files specified at startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" NERDTreeGit
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

nmap <leader>g :NERDTreeToggle<CR>
nmap <leader>G :NERDTreeFind<CR>

" Ctags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Ag
nmap g/ :Ag!<space>
nmap g* :Ag! -w <C-R><C-W><space>

" Vim Snippets
" http://stackoverflow.com/a/22253548/927748
" let g:SuperTabDefaultCompletionType    = '<C-n>'
" let g:SuperTabCrMapping                = 0
" let g:UltiSnipsExpandTrigger           = "<tab>"
" let g:UltiSnipsJumpForwardTrigger      = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger     = "<s-tab>"
" let g:UltiSnipsEditSplit               = "vertical"
" let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']


""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
set t_Co=256
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
set backspace=indent,eol,start


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

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

""""""""""""""""""""""""
" Searching
""""""""""""""""""""""""
set incsearch
set hlsearch
set ignorecase
set smartcase

" turn off search highlight
nnoremap <CR> :nohlsearch<CR>

set tags=tags;/


""""""""""""""""""""""""
" Moving
""""""""""""""""""""""""
set scrolloff=5

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

nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l

nnoremap H gT
nnoremap L gt


""""""""""""""""""""""""
" Tricks
""""""""""""""""""""""""
map n nzz
map N Nzz
map <C-o> <C-o>zz
map <C-i> <C-i>zz
nnoremap ; :
map <Space> \

""" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>c :call StripWhitespace()<CR>

""" Switch to rspec, and vice versa
function! SwitchFile()
  let current_file = expand('%')
  let other_file = ''

  if IsInApp(current_file)
    let other_file = GetSpecFile(current_file)
  elseif IsInSpec(current_file)
    let other_file = GetAppFile(current_file)
  end

  if other_file != ''
    exec ':e ' . other_file
  end
endfunction

function! IsInApp(filename)
  return match(a:filename, '^app/') == 0
endfunction

function! IsInSpec(filename)
  return match(a:filename, '^spec/') == 0
endfunction

function! GetAppFile(filename)
  let other_file = substitute(a:filename, '^spec/', 'app/', '')
  let other_file = substitute(other_file, '_spec\.rb$', '.rb', '')

  return other_file
endfunction

function! GetSpecFile(filename)
  let other_file = substitute(a:filename, '^app/', 'spec/', '')
  let other_file = substitute(other_file, '\.rb$', '_spec.rb', '')

  return other_file
endfunction

nnoremap <leader>. :call SwitchFile()<cr>

""" Run rspec
function! RunRspecFile(use_spring)
  let current_file = expand('%')
  let test_file = ''

  if IsInApp(current_file)
    let test_file = GetSpecFile(current_file)
  elseif IsInSpec(current_file)
    let test_file = current_file
  end

  if test_file != ''
    if a:use_spring
      exec ':!spring rspec ' . test_file
    else
      exec ':!rspec ' . test_file
    end
  end
endfunction

nnoremap <leader>t :call RunRspecFile(0)<cr>
nnoremap <leader>T :call RunRspecFile(1)<cr>

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
