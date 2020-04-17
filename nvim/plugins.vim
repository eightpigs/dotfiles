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
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
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

" 自动括号
" Plug 'jiangmiao/auto-pairs'

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




" -----------------------------
" Yaml
" -----------------------------
Plug 'avakhov/vim-yaml', { 'for': ['yaml'] }




" -----------------------------
" Golang
" -----------------------------
Plug 'fatih/vim-go', { 'for': ['go'], 'do': ':GoUpdateBinaries' }
" Debug, need install https://github.com/derekparker/delve
Plug 'sebdah/vim-delve', { 'for': ['go'] }







" -----------------------------
" Web
" -----------------------------
" ES2015 code snippets
Plug 'epilande/vim-es2015-snippets', { 'for': ['vue', 'javascript', 'typescript'] }
" emmet
Plug 'mattn/emmet-vim', { 'for': ['html','vue', 'css'], 'on': 'EmmetInstall' }
Plug 'jceb/emmet.snippets', { 'for': ['html','vue', 'css'] }
" js 语法支持
Plug 'othree/yajs.vim', { 'for': ['html', 'javascript', 'vue'] }
" Js 补全
Plug 'ternjs/tern_for_vim', { 'for': ['html','vue', 'javascript'] }
" typescript
Plug 'mhartington/nvim-typescript', { 'do': './install.sh', 'for': ['typescript']  }
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript'] }
" 自动关闭HTML/XML标签
Plug 'docunext/closetag.vim', { 'for': ['html','vue', 'xml'] }
" 自动高亮HTML/XML标签
" Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'xhtml', 'xml', 'vue'] } 
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript'] }





" -----------------------------
" Markdown
" -----------------------------
Plug 'junegunn/limelight.vim', { 'for': ['markdown'] }
Plug 'lvht/tagbar-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim'



" -----------------------------
" Dart / Flutter
" -----------------------------
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart'] }
Plug 'thosakwe/vim-flutter', { 'for': ['dart'] }




" -----------------------------
" Rust
" -----------------------------
Plug 'rust-lang/rust.vim', { 'for': ['rs'] }


call plug#end()

