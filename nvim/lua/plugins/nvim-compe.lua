local command = vim.api.nvim_command
local map = require 'utils.vim'.map

vim.o.completeopt = "menu,menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

map('i', '<C-p>', [[compe#complete()]], { silent = true, expr = true })
map('i', '<CR>', [[pumvisible() ? compe#confirm('<CR>') : "\<CR>"]], { silent = true, expr = true })
map('i', '<TAB>', [[pumvisible() ? compe#confirm('<CR>') : "\<TAB>"]], { silent = true, expr = true })
