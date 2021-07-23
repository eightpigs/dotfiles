local command = vim.api.nvim_command

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  }
}

-- command [[
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
-- ]]
