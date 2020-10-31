-------------------------------------------------------------------------------
-- Key Mappings
-------------------------------------------------------------------------------
local require = import and import(...) or require

local map = require 'utils'.vim.map
local g = vim.g

g.mapleader = ' '


-----------------------------
-- View
-----------------------------

map('n', '<leader>1', [[:lua require'actions'.view.explore()<cr> zz]])
map('n', '<leader>2', [[:lua require'actions'.view.structure()<cr>]])



-----------------------------
-- Search
-----------------------------

map('n', '<leader>;', [[:lua require'actions'.search.file()<cr>]])
map('n', '<leader>\'w', [[:lua require'actions'.search.file()<cr>]])
map('n', '<leader>\'c', [[:lua require'actions'.search.file()<cr>]])



-----------------------------
-- Navigate
-----------------------------

map('n', '<leader>gj', [[:lua require'actions'.navigate.definition()<cr>]])
map('n', '<leader>gi', [[:lua require'actions'.navigate.implementation()<cr>]])
map('n', '<leader>gd', [[:lua require'actions'.navigate.declaration()<cr>]])
map('n', '<leader>gr', [[:lua require'actions'.navigate.references()<cr>]])
map('n', '<leader>gs', [[:lua require'actions'.navigate.symbols()<cr>]])



-----------------------------
-- Edit
-----------------------------

map('n', '<leader>or', [[:lua require'actions'.edit.rename()<cr>]])
map('n', '<leader>of', [[:lua require'actions'.edit.format()<cr>]])
map('n', '<leader>/', [[:lua require'actions'.edit.comment()<cr>]])



-----------------------------
-- Jump
-----------------------------

map('n', '<leader>j', [[:lua require'actions'.edit.rename()<cr>]])
map('n', '<leader>j', [[:lua require'actions'.edit.format()<cr>]])
map('n', '<leader>/', [[:lua require'actions'.edit.comment()<cr>]])

-- TODO
map('n', '<leader>j;', [[g;zz]])
map('n', '<leader>j,', [[g,zz]])




-----------------------------
-- Buffer
-----------------------------
map('n', '<leader>bn', [[:vnew<cr>]])
map('n', '<leader>bo', [[:only<cr>]])
map('n', '<leader>b;', [[:Buffers<cr>]])




-----------------------------
-- Windows
-----------------------------
map('n', '<leader>wl', [[<C-W>l]])
map('n', '<leader>wh', [[<C-W>h]])
map('n', '<leader>wk', [[<C-W>k]])
map('n', '<leader>wj', [[<C-W>j]])
map('n', '<leader>ws', [[<C-W>s]])
map('n', '<leader>wv', [[<C-W>v]])
map('n', '<leader>w=', [[:resize +5<cr>]])
map('n', '<leader>w-', [[:resize -5<cr>]])
map('n', '<leader>w.', [[:vertical resize -5<cr>]])
map('n', '<leader>w,', [[:vertical resize +5<cr>]])





-----------------------------
-- Misc
-----------------------------

map('n', '<leader>\\', [[:nohlsearch<cr>]])
map('n', '<leader>h', [[^]])
map('n', '<leader>l', [[$]])
map('n', '<leader>q', [[:q!<cr>]])
map('n', '<leader>Q', [[:qa!<cr>]])
map('n', '<leader>i', [[:w<cr>]])
map('n', '<leader>I', [[:wa<cr>]])
