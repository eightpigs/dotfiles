-------------------------------------------------------------------------------
-- FZF
-------------------------------------------------------------------------------

local g = vim.g
local command = vim.api.nvim_command


-----------------------------
-- Properties
-----------------------------
local fzf_default_opts = '--exact --layout=reverse --border=rounded --ansi --color=16'
g.fzf_layout = { window = 'lua require"utils.vim".open_floating_win()' }
g.fzf_preview_window = 'right:0%'
g.fzf_commits_log_options = '--graph --color=always --format='..fzf_default_opts
g.fzf_colors = {
  fg=      {'fg', 'Normal'},
  bg=      {'bg', 'Normal'},
  hl=      {'fg', 'Comment'},
  info=    {'fg', 'PreProc'},
  border=  {'fg', 'PreProc'},
  prompt=  {'fg', 'Conditional'},
  pointer= {'fg', 'Exception'},
  marker=  {'fg', 'Keyword'},
  spinner= {'fg', 'Label'},
  header=  {'fg', 'Comment'}
}
g.fzf_colors["fg+"] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'}
g.fzf_colors["bg+"] = {'bg', 'CursorLine', 'CursorColumn'}
g.fzf_colors["hl+"] = {'fg', 'Statement'}




-----------------------------
-- autocmd
-----------------------------
command('autocmd! filetype fzf')
command('autocmd filetype fzf set laststatus=2 noshowmode noruler nonumber norelativenumber')
command('autocmd bufleave <buffer> set laststatus=2 showmode ruler number relativenumber')
