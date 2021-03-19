vim.cmd [[ 
if empty(glob('~/.local/share/nvim/site/pack/packer/opt/packer.nvim'))
  echom 'first run: install packager manager.'
  !git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
endif
]]

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

  use { 'wbthomason/packer.nvim', opt = true }

  use { 'chriskempson/base16-vim' }

  use { 'eightpigs/gruvbox' }

	use { 
    'Yggdroot/indentLine', 
    config = [[require 'plugins.indentline']],
    disable = true 
  }

	-- 侧边栏树 
	use { 
    'Xuyuanp/nerdtree-git-plugin',
    config = [[require 'plugins.nerdtree']],
    requires = {
      { 'scrooloose/nerdtree' }
    }
  }

	-- git diff
	use { 
    'airblade/vim-gitgutter', 
    config = [[require 'plugins.vim-gitgutter']],
		ft = {'', 'txt'}
  }

	-- 代码标签
	use {
		'majutsushi/tagbar', 
    config = [[require 'plugins.tagbar']],
		ft = {'javascript', 'go', 'python', 'ruby', 'java', 'markdown', 'dart', 'lua', 'rust'}
	}

	-- 注释插件
	use {
		'preservim/nerdcommenter',
    config = [[require 'plugins.nerdcommenter']]
	}

  use { 
    'junegunn/fzf.vim',
    config = [[require 'plugins.fzf']],
    requires = {{
      'junegunn/fzf',
      run = '~/.fzf/install --all'
    }}
  }

	use { 'tpope/vim-surround' }

  use { 
    'nvim-treesitter/nvim-treesitter',
    config = [[require 'plugins.treesitter']],
    run = ':TSUpdate'
  }

	use { 
    'airblade/vim-rooter', 
    config = [[require 'plugins.vim-rooter']]
  }

	use {
		'editorconfig/editorconfig-vim',
    config = [[require 'plugins.editorconfig-vim']],
		ft = {'javascript', 'go', 'python', 'ruby', 'java', 'markdown', 'dart', 'lua', 'rust', 'html'}
	}

  -- Markdown
  use { 
    'junegunn/limelight.vim', 
    ft = { 'markdown' },
    config = [[ print "limelight" ]]
  }

  use { 
    'lvht/tagbar-markdown', 
    ft = { 'markdown' },
    config = [[ print "tarbar-markdown" ]]
  }

  use { 
    'npxbr/glow.nvim', 
    ft = { 'markdown' },
    run = ':GlowInstall',
    config = [[ print "glow" ]]
  }

  -- Web
  use { 
    'mattn/emmet-vim', 
    ft =  {'javascript', 'vue', 'html', 'css'}
  }

  -- Rust
  use { 
    'rust-lang/rust.vim',
    ft = 'rust'
  }

  -- Go
  use {
    'fatih/vim-go',
    ft = 'go',
    run = ':GoUpdateBinaries',
    config = [[require 'plugins.vim-go']]
  }

  use {
    'neoclide/coc.nvim',
    -- ft = { "bash", "vim", "json", "lua", "yaml", "vue", "css", "html", "go", "rust", "java", "dart", "javascript" },
    config = [[require 'plugins.coc-vim']]
  }

	-- use {
	-- 	'hrsh7th/nvim-compe',
  --   config = [[require 'plugins.nvim-compe']]
	-- }

end)
