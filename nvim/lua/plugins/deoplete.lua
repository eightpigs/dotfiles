-------------------------------------------------------------------------------
-- deoplete
-------------------------------------------------------------------------------
local g = vim.g
local command = vim.api.nvim_command
local call = vim.api.nvim_call_function
local utils = require 'utils'


-----------------------------
-- Properties
-----------------------------
command('let g:deoplete#enable_at_startup = 1')
call('deoplete#custom#option', {{
  auto_complete_delay = 200,
  smart_case = true,
  -- refresh_always = true,
  min_pattern_length = 2,
  num_processes = 2,
}})




-----------------------------
-- keys
-----------------------------

utils.vim.map('i', '<TAB>', [[pumvisible() ? "\<C-n>" : "\<TAB>"]], { silent = true, expr = true})
utils.vim.map('i', '<S-TAB>', [[pumvisible() ? "\<C-p>" : "\<S-TAB>"]], { silent = true, expr = true, noremap = false})
utils.vim.map('i', '<CR>', [[pumvisible() ? deoplete#close_popup() : "\<CR>"]], { silent = true, expr = true, noremap = false })
