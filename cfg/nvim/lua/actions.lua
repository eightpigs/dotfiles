-------------------------------------------------------------------------------
-- All Custom Actions
-------------------------------------------------------------------------------

local g = vim.g
local t = vim.t
local fn = vim.fn
local lsp = vim.lsp
local bo = vim.bo
local command = vim.api.nvim_command

local _actions = {}

local M = {
  view = {},
  search = {},
  navigate = {},
  edit = {},
  run = {},
  debug = {},
  register = function(ft, key, func) 
    if _actions[ft] == nil then
      _actions[ft] = {}
    end
    _actions[ft][key] = func
  end,
  registerMulti = function(ft, dict) 
    _actions[ft] = dict
  end
}


-----------------------------
-- Tools
-----------------------------
local function lsp_exec(func, msg)
  local ready = lsp.buf.server_ready()
  if ready ~= nil and ready then
    func()
  elseif msg ~= nil and string.len(msg) > 0 then
    print(msg)
  end
end

local function exec_action(key) 
  local ft = bo.filetype
  if _actions[ft] ~= nil and _actions[ft][key] ~= nil then
    _actions[ft][key]()
  end
end




-----------------------------
-- View
-----------------------------

-- open explore view.
function M.view.explore()
  if g.NERDTree ~= nil then
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
  else
    command('Vexplore')
  end
end

-- open structure view, eg: Tagbar or others.
function M.view.structure()
  if g.tagbar_width ~= nil then
    command('Tagbar')
  else
    print('Not support structure view.')
  end
end




-----------------------------
-- Search
-----------------------------

local function _search_word(word, func)
  if word == nil then
    word = fn.expand('<cword>')
  end
  if #word > 0 then
    func(word)
  end
end

-- search file in current root dir.
function M.search.file()
  command('Files')
end

-- search word in current buffer.
function M.search.word_buf(word)
  -- TODO or BLines / Lines ?
  _search_word(word, function(w) command('/'..w) end)
end

-- search word in everywhere.
function M.search.word(word)
  _search_word(word, function(w) command('Ag '..w) end)
end

-- search and highlight current word.
function M.search.document_highlight()
  lsp_exec(lsp.buf.document_highlight, '')
end

function M.search.clear_references()
  lsp_exec(lsp.buf.clear_references, '')
end



-----------------------------
-- Navigate
-----------------------------

-- navigate to definition, need lsp.
function M.navigate.definition()
  lsp_exec(lsp.buf.definition, 'Navigate to definition need LSP support.')
end

-- navigate to implementation, need lsp.
function M.navigate.implementation()
  lsp_exec(lsp.buf.implementation, 'Navigate to implementatio need LSP support.')
end

-- navigate to declaration, need lsp.
function M.navigate.declaration()
  lsp_exec(lsp.buf.declaration, 'Navigate to declaration need LSP support.')
end

-- show all references, need lsp.
function M.navigate.references()
  lsp_exec(lsp.buf.references, 'Show & Navigate to references need LSP support.')
end

-- show all symbols, need lsp.
function M.navigate.symbols()
  lsp_exec(lsp.buf.document_symbol, 'Show & Navigate to symbols need LSP support.')
end

function M.navigate.diagnostic_next()
  lsp_exec(vim.lsp.diagnostic.goto_next, 'Move to the next diagnostic need LSP support.')
end

function M.navigate.diagnostic_prev()
  lsp_exec(vim.lsp.diagnostic.goto_prev, 'Move to the prev diagnostic need LSP support.')
end




-----------------------------
-- Code
-----------------------------

-- toggle comment
function M.edit.comment(mode)
  if g.NERDSpaceDelims ~= nil then
    if mode == 'v' then
     command([['<,'>call NERDComment('n', 'toggle')]])
    else
      command([[call NERDComment('n', 'toggle')]])
    end
  else
    print('Not support toggle comment.')
  end
end


-- rename variable or function name, need lsp.
function M.edit.rename()
  lsp_exec(lsp.buf.rename, 'rename need LSP support.')
end


-- format document, need lsp.
function M.edit.format()
  -- TODO support range_formatting()
  lsp_exec(function() lsp.buf.formatting_sync(nil, 1000) end, 'format need LSP support.')
end



-----------------------------
-- Debug / Run
-----------------------------

function M.run.start()
  exec_action('run.start')
end

function M.run.restart()
  exec_action('run.restart')
end

function M.run.stop()
  exec_action('run.stop')
end

function M.debug.start()
  exec_action('debug.start')
end

function M.debug.stop()
  exec_action('debug.stop')
end

function M.debug.breakpoint()
  exec_action('debug.breakpoint')
end

function M.debug.continue()
  exec_action('debug.continue')
end

function M.debug.next()
  exec_action('debug.next')
end

function M.debug.step()
  exec_action('debug.step')
end

function M.debug.stepOut()
  exec_action('debug.stepOut')
end

return M
