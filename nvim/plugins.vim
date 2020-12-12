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

" 
Plug 'Yggdroot/indentLine'

" 
Plug 'scrooloose/nerdtree'

" git
Plug 'Xuyuanp/nerdtree-git-plugin'

" git diff
Plug 'airblade/vim-gitgutter'

" 
Plug 'majutsushi/tagbar', { 'for': ['javascript', 'go', 'python', 'ruby', 'java', 'markdown', 'dart', 'lua'] }

" 
Plug 'preservim/nerdcommenter'

" 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim' 

" /
Plug 'tpope/vim-surround'

" (.git ... )
Plug 'airblade/vim-rooter'

" editorconfig
Plug 'editorconfig/editorconfig-vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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
" LSP & 
" -----------------------------
Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'

call plug#end()
