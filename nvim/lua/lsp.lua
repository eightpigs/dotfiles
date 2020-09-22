local nvim_lsp = require 'nvim_lsp'


-- local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")

--[[
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
--]]


vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]

vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]

vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

-- if(api.nvim_get_option("filetype") == "")

-- bash
require'nvim_lsp'.bashls.setup{}

-- vim
require'nvim_lsp'.vimls.setup{}

-- json
require'nvim_lsp'.jsonls.setup{}

-- lua
require'nvim_lsp'.sumneko_lua.setup{}

-- yaml
require'nvim_lsp'.yamlls.setup{}

-- rust
require'nvim_lsp'.rust_analyzer.setup{
  root_dir = nvim_lsp.util.root_pattern('Cargo.toml', 'rust-project.json', '.git');
  settings = {
    ["rust-analyzer"] = {}
  }
}

-------------------------------------------------------------------------------
---------- WEB
-------------------------------------------------------------------------------

local web_root_dir = nvim_lsp.util.root_pattern('.git', 'package.json');

-- vue
require'nvim_lsp'.vuels.setup{
  root_dir = web_root_dir;
}

-- css
require'nvim_lsp'.cssls.setup{
  root_dir = web_root_dir;
}

-- html
require'nvim_lsp'.html.setup{
  root_dir = web_root_dir;
}




-------------------------------------------------------------------------------
---------- Backend
-------------------------------------------------------------------------------
require'nvim_lsp'.gopls.setup{
  root_dir = nvim_lsp.util.root_pattern("go.mod", ".git");
}

require'nvim_lsp'.pyls.setup{}



-------------------------------------------------------------------------------
---------- APP
-------------------------------------------------------------------------------

require'nvim_lsp'.dartls.setup{
  root_dir = nvim_lsp.util.root_pattern('.git', '.pubspec.yaml');
  init_options = {
    closingLabels = "true",
    flutterOutline = "true",
    onlyAnalyzeProjectsWithOpenFiles = "false",
    outline = "true",
    suggestFromUnimportedLibraries = "true",
    allowAnalytics = "false",
    flutterHotReloadOnSave = "true",
    flutterHotRestartOnSave = "true",
    flutterScreenshotPath = "~/Documents/",
    lineLength = "120",
  }
}


