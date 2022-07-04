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

local function tbl_copy(original, override, override_sub_tbl)
  local n = {}
  for k, v in pairs(original) do
    n[k] = v
    if (override_sub_tbl ~= nil and override_sub_tbl and override ~= nil) then
      for sk, sv in pairs(override) do
        n[k][sk] = sv
      end
    end
  end
  if ((override_sub_tbl == nil or override_sub_tbl) and override ~= nil) then
    for k, v in pairs(override) do
      n[k] = v
    end
  end
  return setmetatable(n, getmetatable(original))
end

local os_fonts = {
  [os_type_win] = {
    fonts = {
      { family = "IBM Plex Mono", weight = "Medium", style = "Normal", scale = 1.0 },
      { family = "CaskaydiaCove NF", weight = "Regular", style = "Normal", scale = 1.20 },
      { family = "Microsoft YaHei" }
    },
    size = 12
  },
  [os_type_mac] = {
    fonts = {
      { family = "IBM Plex Mono", weight = "Regular", stretch = "Normal", style = "Normal", scale = 1.15 },
      { family = "PingFang SC", weight = "Regular", stretch = "Normal", style = "Normal", scale = 1.15 }
    },
    size = 13.0
  },
  [os_type_linux] = {
    fonts = {
      { family = "IBM Plex Mono", weight = "Medium", style = "Normal", scale = 1.0 },
      { family = "CaskaydiaCove NF", weight = "Regular", style = "Normal", scale = 1.20 }
    },
    size = 14.0
  }
}

local progs = {
  -- https://aka.ms/powershell
  [os_type_win] = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" },
  [os_type_mac] = { "zsh", "-l" },
  [os_type_linux] = { "zsh", "-l" }
}

local color_schemes = {
  ["Dark"] = {
    foreground = "#e1e4e8",
    background = "#1f2428",
    cursor_bg = "#c9d1d9",
    cursor_border = "#c9d1d9",
    cursor_fg = "#101216",
    selection_bg = "#3b5070",
    selection_fg = "#ffffff",
    scrollbar_thumb = "#222222",
    split = "#444444",
    ansi = { "#000000", "#ea4a5a", "#56d364", "#e3b341", "#2188ff", "#db61a2", "#2b7489", "#ffffff" },
    brights = { "#4d4d4d", "#ea4a5a", "#56d364", "#e3b341", "#2188ff", "#db61a2", "#2b7489", "#ffffff" },
    indexed = { [136] = "#af8700" },
    compose_cursor = "#c9d1d9"
  },
  ["Light"] = {
    foreground = "#24292e",
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
}

local cur_os_type = os_type()
local font_cfg = os_fonts[cur_os_type]
local font = wezterm.font_with_fallback(font_cfg.fonts)
local color_scheme_key = "Light"
local cur_color_scheme = color_schemes[color_scheme_key]

local cfg = {
  color_scheme = color_scheme_key,
  color_schemes = color_schemes,
  default_prog = progs[cur_os_type],

  -- fonts
  font = font,
  font_size = font_cfg.size,
  line_height = 1.2,
  font_antialias = "Subpixel", -- Subpixel
  font_hinting = "Full",
  font_shaper = "Harfbuzz",
  font_rules = {
    { italic = true, font = wezterm.font_with_fallback(tbl_copy(font_cfg.fonts, { italic = true }, true)) },
    {
      intensity = "Bold",
      font = wezterm.font_with_fallback(tbl_copy(font_cfg.fonts, { italic = false, weight = "Medium" }, true))
    },
    { intensity = "Half", font = wezterm.font_with_fallback(tbl_copy(font_cfg.fonts, { weight = "Light" }, true)) }
  },

  -- scroll_bar
  scrollback_lines = 9999,
  enable_scroll_bar = false,

  -- tab_bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  use_fancy_tab_bar = false,
  tab_max_width = 120,

  -- windows
  window_padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = "0.5cell" },
  window_frame = { font = font, font_size = 11.0, active_titlebar_bg = "#1d2021", inactive_titlebar_bg = "#575757" },
  keys = { { key = "q", mods = "CMD", action = "QuitApplication" } },

  window_close_confirmation = "NeverPrompt",
  colors = {
    tab_bar = {
      background = cur_color_scheme.foreground,
      active_tab = {
        bg_color = cur_color_scheme.selection_bg,
        fg_color = cur_color_scheme.selection_fg,
        -- Half, Normal, Bold"
        intensity = "Normal",
        -- None, Single, Double
        underline = "None",
        italic = false,
        strikethrough = false
      },
      inactive_tab = { bg_color = cur_color_scheme.foreground, fg_color = cur_color_scheme.background },
      inactive_tab_hover = {
        bg_color = cur_color_scheme.foreground,
        fg_color = cur_color_scheme.background,
        italic = true
      },
      new_tab = { bg_color = cur_color_scheme.cursor_border, fg_color = cur_color_scheme.background },
      new_tab_hover = { bg_color = cur_color_scheme.cursor_border, fg_color = cur_color_scheme.background, italic = true }
    }
  }
}

return cfg
