local command = vim.api.nvim_command

command [[autocmd CursorHold  * lua vim.lsp.util.show_line_diagnostics()]]
command [[autocmd CursorHold  * lua require'actions'.search.document_highlight()]]
command [[autocmd CursorHoldI * lua require'actions'.search.document_highlight()]]
command [[autocmd CursorMoved * lua vim.lsp.buf.clear_references()]]
