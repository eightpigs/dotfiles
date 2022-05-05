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

local os_fonts = {
  [os_type_win] = {
    fonts = {
      { family = "CaskaydiaCove NF", italic = true },
      { family = "CodeNewRoman NF", italic = true },
      { family = "Microsoft YaHei", italic = true, weight = "Regular" }
    },
    size = 11.5
  },
  [os_type_mac] = {
    fonts = { { family = "CaskaydiaCove NF", italic = true }, { "PingFang SC", italic = true } },
    size = 15.0
  },
  [os_type_linux] = { fonts = { { family = "CaskaydiaCove NF", italic = true } }, size = 14.0 }
}

local progs = {
  -- https://aka.ms/powershell
  [os_type_win] = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" },
  [os_type_mac] = { "zsh", "-l" },
  [os_type_linux] = { "zsh", "-l" }
}

local cur_os_type = os_type()
local font_cfg = os_fonts[cur_os_type]
local font = wezterm.font_with_fallback(font_cfg.fonts, {})

local cfg = {
  color_scheme = "Light",

  color_schemes = {
    ["Dark"] = {
      foreground = "#e1e4e8",
      background = "#1d2021",
      cursor_bg = "#c9d1d9",
      cursor_border = "#c9d1d9",
      cursor_fg = "#101216",
      selection_bg = "#3b5070",
      selection_fg = "#ffffff",
      scrollbar_thumb = "#222222",
      split = "#444444",
      ansi = { "#000000", "#ff4722", "#56d364", "#e3b341", "#79b8ff", "#db61a2", "#2b7489", "#ffffff" },
      brights = { "#4d4d4d", "#ff4722", "#56d364", "#e3b341", "#79b8ff", "#db61a2", "#2b7489", "#ffffff" },
      indexed = { [136] = "#af8700" },
      compose_cursor = "#c9d1d9"
    },
    ["Light"] = {
      foreground = "#373b41",
      background = "#ffffff",
      cursor_bg = "#373b41",
      cursor_border = "#373b41",
      cursor_fg = "#ffffff",
      selection_bg = "#768db0",
      selection_fg = "#ffffff",
      scrollbar_thumb = "#222222",
      split = "#444444",
      ansi = { "#ffffff", "#cc342b", "#198844", "#e89409", "#3971ed", "#a36ac7", "#3971ed", "#373b41" },
      brights = { "#b4b7b4", "#cc342b", "#198844", "#e89409", "#3971ed", "#a36ac7", "#3971ed", "#1d1f21" },
      indexed = { [136] = "#ff4722" },
      compose_cursor = "#373b41"
    }
  },
  default_prog = progs[cur_os_type],

  -- fonts
  font = font,
  font_size = font_cfg.size,
  line_height = 1.05,

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
  window_frame = { font = font, font_size = 11.0, active_titlebar_bg = "#1d2021", inactive_titlebar_bg = "#575757" },
  keys = { { key = "q", mods = "CMD", action = "QuitApplication" } }
}

return cfg
