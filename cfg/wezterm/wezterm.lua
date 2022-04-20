local wezterm = require 'wezterm';

local os_type_win = "Windows"
local os_type_mac = "MacOS"
local os_type_linux = "Linux"

function os.exec(cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return s
end

local function os_type()
  if package.config:sub(1, 1) ~= "/" then
    return os_type_win
  else
    local output = os.exec("uname")
    if string.find(output, "Darwin") then
      return os_type_mac
    else
      return os_type_linux
    end
  end
end

local fonts = {
  [os_type_win] = { "CodeNewRoman NF", "YouYuan", "Microsoft YaHei" },
  [os_type_mac] = { "CaskaydiaCove NF", "PingFang SC" },
  [os_type_linux] = { "CaskaydiaCove NF" }
}

local progs = {
  -- https://aka.ms/powershell
  [os_type_win] = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" },
  [os_type_mac] = { "zsh", "-l" },
  [os_type_linux] = { "zsh", "-l" }
}

local cur_os_type = os_type()

local cfg = {
  color_scheme = "Gruvbox Dark",

  default_prog = progs[cur_os_type],

  -- fonts
  font = wezterm.font_with_fallback(fonts[cur_os_type], {}),
  font_size = 14.0,
  line_height = 1.1,

  -- scroll_bar
  scrollback_lines = 9999,
  enable_scroll_bar = false,

  -- tab_bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  tab_max_width = 20,
  use_fancy_tab_bar = true,

  -- windows
  window_padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = "0.5cell" },
  window_frame = {
    -- font = font_with_fallback("JetBrains Mono"),
    font_size = 10.0,
    active_titlebar_bg = "#333333",
    inactive_titlebar_bg = "#333333"
  },
  keys = { { key = "q", mods = "CMD", action = "QuitApplication" } }
}

return cfg
