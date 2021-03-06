-------------------------------------------------------------------------------
-- Key Mappings
-------------------------------------------------------------------------------
local map = require 'utils.vim'.map
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
map('n', '<leader>\'w', [[:lua require'actions'.search.word_buf()<cr>]])
map('n', '<leader>\'c', [[:lua require'actions'.search.word()<cr>]])



-----------------------------
-- Navigate
-----------------------------

map('n', '<leader>gj', [[:lua require'actions'.navigate.definition()<cr>]])
map('n', '<leader>gi', [[:lua require'actions'.navigate.implementation()<cr>]])
map('n', '<leader>gd', [[:lua require'actions'.navigate.declaration()<cr>]])
map('n', '<leader>gr', [[:lua require'actions'.navigate.references()<cr>]])
map('n', '<leader>gs', [[:lua require'actions'.navigate.symbols()<cr>]])

map('n', '<leader>gn', [[:lua require'actions'.navigate.diagnostic_next()<cr>]])
map('n', '<leader>gp', [[:lua require'actions'.navigate.diagnostic_prev()<cr>]])



-----------------------------
-- Edit
-----------------------------

map('n', '<leader>or', [[:lua require'actions'.edit.rename()<cr>]])
map('n', '<leader>of', [[:lua require'actions'.edit.format()<cr>]])
-- TODO imports
map('n', '<leader>oi', [[:lua require'actions'.edit.format()<cr>]])
map({'n'}, '<leader>/', [[:lua require'actions'.edit.comment('n')<cr>]])
map({'v'}, '<leader>/', [[:lua require'actions'.edit.comment('v')<cr>]])



-----------------------------
-- Debug / Run
-----------------------------
map('n', '<F5>', [[:lua require'actions'.run.start()<cr>]])
map('n', '<F3>', [[
:lua require'actions'.run.stop()<cr>
:lua require'actions'.debug.stop()<cr>
]])
map('n', '<F6>', [[:lua require'actions'.debug.start()<cr>]])
map('n', '<F4>', [[:lua require'actions'.debug.breakpoint()<cr>]])
map('n', '<F9>', [[:lua require'actions'.debug.continue()<cr>]])
map('n', '<F8>', [[:lua require'actions'.debug.next()<cr>]])
map('n', '<F7>', [[:lua require'actions'.debug.step()<cr>]])
map('n', '<S-F7>', [[:lua require'actions'.debug.stepOut()<cr>]])



-----------------------------
-- Jump
-----------------------------

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
