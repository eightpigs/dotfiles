local fn = vim.fn
local command = vim.api.nvim_command
local M = {}


-- Key mapping
function M.map(mode, key, result, opts)
  opts = opts or {}
  fn.nvim_set_keymap(
    mode,
    key,
    result,
    {
      noremap = true,
      silent = opts.silent or true,
      expr = opts.expr or false,
      script = opts.script or false
    }
  )
end

function M.open_floating_win()
  local line = fn.nvim_eval("&lines")
  local column = fn.nvim_eval("&columns")

  local b_width = math.floor(column * 0.7)
  local b_height = math.floor(line / 2)

  local opts = {
    relative = 'editor',
    row = math.floor((line - b_height) / 2),
    col = math.floor((column - b_width) / 2),
    width = b_width,
    height = b_height,
  }
  local buf = fn.nvim_create_buf(false, true)
  local win = fn.nvim_open_win(buf, true, opts)
  fn.setwinvar(win, '&winhl', 'Normal:Pmenu')
end

return M
