"-------------------------------------------------------------------------------
" Base Config
"-------------------------------------------------------------------------------

" 
set nocompatible

" 
set regexpengine=1

" 
set lazyredraw

" 
set noeb novb

" backspace
set backspace=eol,start,indent

" 
set completeopt=menuone,menu,noselect,noinsert

set updatetime=250

" 
set fillchars=vert:,stl:\ ,stlnc:\ 
set list lcs=tab:\ \ ,conceal:\|

" 
set clipboard=unnamedplus

" 
set splitright splitbelow

" 
set incsearch

" 
set hlsearch

" 
set ignorecase

" ï
set smartcase

" vim 
set wildmenu

" 
set laststatus=2

" 
set ruler

" 
set nowrap

" 
syntax on

" 
set tabstop=2
set shiftwidth=2
set smarttab
set shiftround
set expandtab

" 
set autochdir

" 
set showmatch

" 
set encoding=utf-8
set fileencodings=utf-8

" 
set number
set relativenumber

" 
set scrolloff=10

" 
set foldmethod=manual
set foldlevelstart=2
set foldenable
set foldcolumn=auto:1
set signcolumn=auto:1

" 
augroup remember_folds
  autocmd!
  autocmd BufWritePre * mkview
  autocmd BufWritePost * silent! loadview
augroup END

set nocursorcolumn
set nocursorline
syntax sync minlines=256
set synmaxcol=1000

" 
set colorcolumn=120

" 
set undofile

" : mkdir ~/.vim/undodir
set undodir=~/.vim/undodir

" 
set showcmd

" ïlightline  airline 
" set noshowmode

" 
set nobackup
set noswapfile

" 
set wildignore+=*.un~,*.pyc,*.zip,*.rar,*.dll,*.dmg,*.o,*~,*.pyc
set wildignore+=*.jpg,*.png,*.jpeg,*.gif,*.svg,*.ico
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/bower_components/*

" 
set autoread
au FocusGained,BufEnter * checktime

filetype plugin indent on

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
