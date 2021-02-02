-------------------------------------------------------------------------------
-- nerdtree 和 nerdtree-git-plugin 侧边栏文档
-------------------------------------------------------------------------------

local g = vim.g
local t = vim.t
local fn = vim.fn
local command = vim.api.nvim_command
local vimutil= require 'utils.vim'
local M = {}


-----------------------------
-- Properties
-----------------------------

g.NERDTreeIgnore = {'\\.pyc$', '__pycache__', 'node_modules'}
g.NERDTreeWinSize = 35
g.NERDTreeWinPos = 'left'
g.NERDTreeShowHidden = 1
g.NERDTreeMinimalUI = 1
g.NERDTreeAutoDeleteBuffer = 1
g.NERDTreeStatusline = '%#NonText#'
g.NERDTreeCascadeOpenSingleChildDir = 1




-----------------------------
-- local functions
-----------------------------

function M.toggleInCurDir()
  local bufName = t.NERDTreeBufName
  if(bufName ~= nil and fn.exists(bufName) and fn.bufwinnr(bufName) ~= -1) then
    command('NERDTreeClose')
  else
    if fn.expand("%:t") ~= '' then
      command('NERDTreeFind')
    else
      command('NERDTreeToggle')
    end
  end
end

return M
