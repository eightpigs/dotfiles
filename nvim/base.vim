"--------------------------------------------------------------------------
" Base Config
"--------------------------------------------------------------------------

set smarttab

" 关闭兼容模式
set nocompatible

set re=1
set ttyfast
"
" will buffer screens instead of updating
set lazyredraw

" turn off beep sound
set noeb
set novb
set t_vb=

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

set completeopt=longest,menuone
" Disable scratch pad
set completeopt-=preview

" 设置分割线
" set fillchars+=vert:│
set fillchars=vert:│,stl:\ ,stlnc:\ 

" 使用系统的剪切板
" set clipboard=unnamed
" :check clipboard , install clipboard-tools (xsel )
set clipboard=unnamedplus

" Split to right and below by default
set splitright
set splitbelow

"" 定义快捷键的前缀，即<Leader>
let mapleader="\<Space>"

" 开启实时搜索功能
set incsearch

" 自动载入被修改的文件
set autoread
au FocusGained,BufEnter * checktime

" 高亮显示搜索结果
set hlsearch

" 搜索时大小写不敏感
set ignorecase

" 如果有大写，则大小写敏感
set smartcase 

" vim 自身命令行模式智能补全
set wildmenu

" 总是显示状态栏
set laststatus=2

" 显示光标当前位置
set ruler

" 显示当前行
" set cursorline

" 自动折行
set wrap

" 开启语法高亮
syntax on

" 设置编辑时制表符占用空格数
set tabstop=2

" 设置格式化时制表符占用空格数
set shiftwidth=2

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" 编辑时可以将tab替换为空格(et)
set expandtab

" 根据当前的文件自动切换工作目录
set autochdir

" 自动匹配括号
set showmatch

" 设置编码
set encoding=utf-8
set fileencodings=utf-8

" 行号
set number

" 相对行号
set relativenumber

" 基于缩进或语法进行代码折叠
set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable
set foldcolumn=0
set signcolumn=auto

set colorcolumn=80,120

" 保留撤销历史
set undofile

" 保留撤销历史的文件夹地址: mkdir ~/.vim/undodir
set undodir=~/.vim/undodir

" 在状态栏显示当前输入的命令
set showcmd

" 不显示当前模式：主要用于有lightline 或者 airline 的情况
" set noshowmode

" 禁止生成临时文件
set nobackup
set noswapfile

set wildignore+=*.un~,*.pyc,*.zip,*.rar,*.dll,*.dmg,*.o,*~,*.pyc
set wildignore+=*.jpg,*.png,*.jpeg,*.gif,*.svg,*.ico
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/bower_components/*

filetype plugin indent on
