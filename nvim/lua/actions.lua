-------------------------------------------------------------------------------
-- All Custom Actions
-------------------------------------------------------------------------------

local g = vim.g
local t = vim.t
local fn = vim.fn
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
local function coc_action(action, msg)
  local ready = fn["coc#rpc#ready"]()
  if ready ~= nil and ready == 1 then
    command('call CocActionAsync("'.. action..'")')
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

function M.view.diagnostics()
  local id = vim.fn.get(vim.fn.getloclist(0,{winid = 0}), 'winid', 0)
  if (id == 0) then
    command(':CocDiagnostics 4')
  else
    command(':lclose')
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
  coc_action('highlight', '')
end



-----------------------------
-- Navigate
-----------------------------

-- navigate to definition, need lsp.
function M.navigate.definition()
  coc_action('jumpDefinition', 'Navigate to definition need LSP support.')
end

-- navigate to implementation, need lsp.
function M.navigate.implementation()
  coc_action('jumpImplementation', 'Navigate to implementatio need LSP support.')
end

-- navigate to declaration, need lsp.
function M.navigate.declaration()
  coc_action('jumpDeclaration', 'Navigate to declaration need LSP support.')
end

-- show all references, need lsp.
function M.navigate.references()
  coc_action('jumpReferences', 'Show & Navigate to references need LSP support.')
end

-- show all symbols, need lsp.
function M.navigate.symbols()
  coc_action('documentSymbols', 'Show & Navigate to symbols need LSP support.')
end

-- function M.navigate.diagnostic_next()
--   coc_action(vim.lsp.diagnostic.goto_next, 'Move to the next diagnostic need LSP support.')
-- end
-- function M.navigate.diagnostic_prev()
--   coc_action(vim.lsp.diagnostic.goto_prev, 'Move to the prev diagnostic need LSP support.')
-- end




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
  coc_action('rename', 'rename need LSP support.')
end


-- format document, need lsp.
function M.edit.format(mode)
  if mode ~= nil and mode == 'v' then
    coc_action('formatSelected', 'formatSelected need LSP support.')
  else
    coc_action('format', 'format need LSP support.')
  end
end


-- organize import, need lsp.
function M.edit.imports()
  coc_action('organizeImport', 'organizeImport need LSP support.')
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
