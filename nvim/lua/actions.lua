-------------------------------------------------------------------------------
-- All Custom Actions
-------------------------------------------------------------------------------

local g = vim.g
local t = vim.t
local fn = vim.fn
local lsp = vim.lsp
local command = vim.api.nvim_command
local M = {
  view = {},
  search = {},
  navigate = {},
  edit = {},
  run = {}
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
function M.edit.comment()
  if g.NERDSpaceDelims ~= nil then
    command([[call NERDComment(0, 'toggle')]])
  else
    -- TODO impl a filetypes to comment map
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
end

function M.run.debug()
end

function M.run.restart()
end

function M.run.stop()
end

function M.run.breakpoint()
end

return M
