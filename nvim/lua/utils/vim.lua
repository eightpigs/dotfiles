local M = {}


-- Key mapping
function M.map(mode, key, action, opts)
  if (type(mode) == "table") then
    for _,v in pairs(mode) do
      map(v, key, action, opts)
    end
  else
    map(mode, key, action, opts)
  end
end

function map(mode, key, action, opts)
  opts = opts or {}
  vim.api.nvim_set_keymap(
    mode,
    key,
    action,
    {
      noremap = opts.noremap or true,
      silent = opts.silent or true,
      expr = opts.expr or false,
      script = opts.script or false
    }
  )
end

return M
