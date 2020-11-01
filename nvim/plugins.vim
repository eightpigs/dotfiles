"-------------------------------------------------------------------------------
"  Plugins
"-------------------------------------------------------------------------------

" vim-plug autoconfig if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | nested source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" -----------------------------
" Colorscheme 
" -----------------------------
Plug 'chriskempson/base16-vim'


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
" Plug 'airblade/vim-gitgutter'

" 代码标签
Plug 'majutsushi/tagbar', { 'for': ['javascript', 'go', 'python', 'ruby', 'java', 'markdown', 'dart', 'lua'] }

" 注释插件
Plug 'preservim/nerdcommenter'

" 搜索
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim' 

" 引号/括号增强
Plug 'tpope/vim-surround'

" 自动切换工作目录(.git ... )
Plug 'airblade/vim-rooter'

" 支持editorconfig
Plug 'editorconfig/editorconfig-vim'


" -----------------------------
" Markdown
" -----------------------------
Plug 'junegunn/limelight.vim', { 'for': ['markdown'] }
" Plug 'lvht/tagbar-markdown', { 'for': 'markdown' }
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}


" -----------------------------
" Web
" -----------------------------
Plug 'mattn/emmet-vim', { 'for': ['javascript', 'vue', 'html', 'css'] }


" -----------------------------
" LSP支持 & 补全
" -----------------------------
Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'

call plug#end()
