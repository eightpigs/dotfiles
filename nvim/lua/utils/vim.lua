local fn = vim.fn
local M = {}


-- Key mapping
function M.map(mode, key, action, opts)
  opts = opts or {}
  fn.nvim_set_keymap(
    mode,
    key,
    action,
    {
      noremap = true,
      silent = opts.silent or true,
      expr = opts.expr or false,
      script = opts.script or false
    }
  )
end

return M
