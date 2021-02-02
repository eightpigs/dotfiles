-------------------------------------------------------------------------------
-- deoplete
-------------------------------------------------------------------------------
local g = vim.g
local command = vim.api.nvim_command
local call = vim.api.nvim_call_function
local vimutil = require 'utils.vim'


-----------------------------
-- Properties
-----------------------------
command('let g:deoplete#enable_at_startup = 1')
call('deoplete#custom#option', {{
  auto_complete_delay = 200,
  smart_case = true,
  -- refresh_always = true,
  min_pattern_length = 1,
  num_processes = 1,
}})



-----------------------------
-- keys
-----------------------------

vimutil.map('i', '<TAB>', [[pumvisible() ? "\<C-n>" : "\<TAB>"]], { silent = true, expr = true})
vimutil.map('i', '<S-TAB>', [[pumvisible() ? "\<C-p>" : "\<S-TAB>"]], { silent = true, expr = true, noremap = false})
vimutil.map('i', '<CR>', [[pumvisible() ? deoplete#close_popup() : "\<CR>"]], { silent = true, expr = true, noremap = false })
