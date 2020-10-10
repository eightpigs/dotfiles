" ------------------------------------------------------------
"  Plugins
" ------------------------------------------------------------

" vim-plug autoconfig if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | nested source $MYVIMRC
endif

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')

  Plug 'neovim/nvim-lspconfig'

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/deoplete-lsp'
  " Plug 'Shougo/neosnippet.vim'
  " Plug 'Shougo/neosnippet-snippets'
else
  call plug#begin('~/.vim/plugged')
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'

  " 代码片段
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif


" -----------------------------
" Colorscheme 
" -----------------------------
Plug 'morhetz/gruvbox'



" -----------------------------
" Base
" -----------------------------

" 代码缩进显示
Plug 'Yggdroot/indentLine'

" 侧边栏文档
Plug 'scrooloose/nerdtree'

" 侧边栏git
Plug 'Xuyuanp/nerdtree-git-plugin'

" git diff
Plug 'airblade/vim-gitgutter'

" git
Plug 'tpope/vim-fugitive'

" 代码标签
Plug 'majutsushi/tagbar', { 'for': ['javascript', 'go', 'python', 'ruby', 'java', 'markdown', 'dart'] }

" 语法检测
Plug 'w0rp/ale', { 'for': ['javascript','vue', 'go', 'python', 'ruby', 'java', 'typescript', 'dart'] }

" 注释插件
Plug 'scrooloose/nerdcommenter', { 'on':  '<Plug>NERDCommenterToggle' }

" 搜索
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim' 
Plug 'mileszs/ack.vim'

" 多光标操作
" Plug 'terryma/vim-multiple-cursors'

" 快速移动光标
Plug 'easymotion/vim-easymotion', { 'on': '<Plug>(easymotion' }

" 快速匹配并选中代码区域
" Plug 'terryma/vim-expand-region', { 'on': '<Plug>(expand_region' }

" 引号/括号增强
" Plug 'tpope/vim-surround'

" Plug 'dkprice/vim-easygrep', { 'on': ['<plug>EgMap', 'Grep', 'Replace'] }

" 交换参数位置
" Plug 'AndrewRadev/sideways.vim', { 'on': ['SidewaysLeft', 'SidewaysRight'] }

" 自动切换工作目录(.git ... )
Plug 'airblade/vim-rooter'

Plug 'tmsvg/pear-tree'
Plug 'editorconfig/editorconfig-vim'



" -----------------------------
" Markdown
" -----------------------------
Plug 'junegunn/limelight.vim', { 'for': ['markdown'] }
Plug 'lvht/tagbar-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim'


" -----------------------------
" Web
" -----------------------------
Plug 'mattn/emmet-vim'

call plug#end()

