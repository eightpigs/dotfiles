"-------------------------------------------------------------------------------
" Base Config
"-------------------------------------------------------------------------------

" 关闭兼容模式
set nocompatible                                    

" 使用旧的正则表达式引擎
set regexpengine=1                                  

" 减少重绘次数
set lazyredraw                                      

" 关闭响声
set noeb novb                                       

" backspace按键的工作方式
set backspace=eol,start,indent                      

" 调整补全列表行为
set completeopt=menuone,menu,noselect,noinsert      

set updatetime=250

" 设置分割线
set fillchars=vert:│,stl:\ ,stlnc:\                 

" 使用系统的剪切板
set clipboard=unnamedplus                           

" 分割窗口时默认在右边、下边
set splitright splitbelow                           

" 开启实时搜索功能
set incsearch                                       

" 高亮显示搜索结果
set hlsearch                                        

" 搜索时大小写不敏感
set ignorecase                                      

" 如果有大写，则大小写敏感
set smartcase                                       

" vim 自身命令行模式智能补全
set wildmenu                                        " 

" 总是显示状态栏
set laststatus=2                                    

" 显示光标当前位置
set ruler                                           

" 关闭自动折行
set nowrap                                          

" 开启语法高亮
syntax on

" 缩进配置
set tabstop=2
set shiftwidth=2
set smarttab
set shiftround
set expandtab

" 根据当前的文件自动切换工作目录
set autochdir

" 自动匹配括号
set showmatch

" 设置编码
set encoding=utf-8
set fileencodings=utf-8

" 显示相对行行
set number
set relativenumber

" 滚动时上下保留行
set scrolloff=10

" 基于缩进或语法进行代码折叠
set foldmethod=indent
" set foldmethod=syntax
set nofoldenable
set foldcolumn=0
set signcolumn=auto

set nocursorcolumn
set nocursorline
syntax sync minlines=256
set synmaxcol=1000

" 设置并高亮最宽列的位置
set colorcolumn=120

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

" 忽略相关文件
set wildignore+=*.un~,*.pyc,*.zip,*.rar,*.dll,*.dmg,*.o,*~,*.pyc
set wildignore+=*.jpg,*.png,*.jpeg,*.gif,*.svg,*.ico
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/bower_components/*

" 自动载入被修改的文件
set autoread                                        
au FocusGained,BufEnter * checktime

filetype plugin indent on

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
