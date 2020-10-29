-------------------------------------------------------------------------------
-- emment-vim
-------------------------------------------------------------------------------

local g = vim.g
local command = vim.api.nvim_command

-----------------------------
-- Properties
-----------------------------

g.user_emmet_mode = 'i'
g.user_emmet_install_global = 0
g.user_emmet_leader_key = '<TAB>t'




-----------------------------
-- autocmd
-----------------------------

command('autocmd FileType html,css,vue EmmetInstall')
