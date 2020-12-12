local sign_define = vim.fn.sign_define
local command = vim.api.nvim_command
local lsp = vim.lsp
local b = vim.b
local fn = vim.fn
local M = {}

sign_define(
  "LspDiagnosticsErrorSign",
  {
    text = "x",
    texthl = "LspDiagnosticsError",
    linehl = "",
    numhl = ""
  }
)
sign_define(
  "LspDiagnosticsWarningSign",
  {
    text = "!",
    texthl = "LspDiagnosticsWarning",
    linehl = "",
    numhl = ""
  }
)
sign_define(
  "LspDiagnosticsInformationSign",
  {
    text = "I",
    texthl = "LspDiagnosticsInformation",
    linehl = "",
    numhl = ""
  }
)
sign_define(
  "LspDiagnosticsHintSign",
  {
    text = ">",
    texthl = "LspDiagnosticsHint",
    linehl = "",
    numhl = ""
  }
)

-- command [[autocmd CursorHold  * lua vim.lsp.util.show_line_diagnostics()]]
-- command [[autocmd CursorHold  * lua vim.lsp.buf.document_highlight()]]
-- command [[autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()]]
-- command [[autocmd CursorMoved * lua vim.lsp.buf.clear_references()]]

function M.currentLSPServer()
  local bufnr = fn.bufnr('%')
  local name_str = ''
  if lsp.buf.server_ready() then
    local clients = lsp.buf_get_clients(bufnr)
    if clients ~= nil then
      for _, client in pairs(clients) do
        name_str = client["name"]
        break
      end
    end
  end
  b.lsp_current_server = name_str
  return name_str
end

command("command LSPServer :lua print(require'lsp.base'.currentLSPServer())")

return M
