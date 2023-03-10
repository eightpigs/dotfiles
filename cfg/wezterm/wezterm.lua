local wezterm = require("wezterm")

local os_win = "Windows"
local os_mac = "MacOS"
local os_linux = "Linux"

function os.exec(cmd)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read("*a"))
  f:close()
  return s
end

local function get_current_os()
  if package.config:sub(1, 1) ~= "/" then
    return os_win
  else
    local output = os.exec("uname")
    if string.find(output, "Darwin") then
      return os_mac
    else
      return os_linux
    end
  end
end

local function tbl_copy(original, override)
  local n = {}
  for k, v in pairs(original) do
    n[k] = v
    if override ~= nil and type(v) == "table" then
      for sk, sv in pairs(override) do
        n[k][sk] = sv
      end
    end
  end
  if override ~= nil then
    for k, v in pairs(override) do
      n[k] = v
    end
  end
  return setmetatable(n, getmetatable(original))
end

function tbllen(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local os_fonts = {
  [os_win] = {
    fonts = {
      { family = "IBM Plex Mono",    weight = "Medium",  scale = 1.0 },
      { family = "CaskaydiaCove NF", weight = "Regular", scale = 1.20 },
      { family = "Microsoft YaHei" },
    },
    size = 12,
  },
  [os_mac] = {
    fonts = {
      { family = "Fira Code",                   weight = "Regular", scale = 1.0 },
      { family = "JetBrains Mono",              weight = "Medium",  scale = 1.0 },
      { family = "CodeNewRoman Nerd Font Mono", weight = "Regular", scale = 1.0 },
      { family = "BlexMono Nerd Font Mono",     weight = "Regular", scale = 1.0 },
      { family = "IBM Plex Mono",               weight = "Regular", scale = 1.0 },
      { family = "Maple Mono SC NF",            weight = "Regular", scale = 1.0 },
      { family = "Cascadia Mono",               weight = "Regular", scale = 1.0 },
      { family = "LXGW WenKai",                 weight = "Medium",  scale = 1.0 },
      { family = "PingFang SC",                 weight = "Medium",  scale = 1.0 },
    },
    size = 15.0,
  },
  [os_linux] = {
    fonts = {
      { family = "IBM Plex Mono",    weight = "Medium",  scale = 1.0 },
      { family = "CaskaydiaCove NF", weight = "Regular", scale = 1.20 },
    },
    size = 14.0,
  },
}

local progs = {
  -- https://aka.ms/powershell
  [os_win] = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" },
  [os_mac] = { "zsh", "-l" },
  [os_linux] = { "zsh", "-l" },
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
    ansi = { "#000000", "#ea4a5a", "#56d364", "#e3b341", "#57c0ff", "#db61a2", "#2b7489", "#ffffff" },
    brights = { "#4d4d4d", "#ea4a5a", "#56d364", "#e3b341", "#57c0ff", "#db61a2", "#2b7489", "#ffffff" },
    indexed = { [136] = "#af8700" },
    compose_cursor = "#c9d1d9",
    -- tab_bar = {
    -- background = "#1f2828",
    -- active_tab = {
    -- bg_color = "#444444",
    -- fg_color = "#FFFFFF",
    -- intensity = "Bold",
    -- underline = "None",
    -- italic = false,
    -- strikethrough = false,
    -- },
    -- inactive_tab = { bg_color = "#f1f1f1", fg_color = "#24292e" },
    -- inactive_tab_hover = { bg_color = "#f1f1f1", fg_color = "#24292e", intensity = "Bold" },
    -- new_tab = { bg_color = "#f1f1f1", fg_color = "#24292e" },
    -- new_tab_hover = { bg_color = "#f1f1f1", fg_color = "#24292e", intensity = "Bold" },
    -- }
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
    compose_cursor = "#373b41",
    tab_bar = {
      background = "#f1f1f1",
      active_tab = {
        bg_color = "#444444",
        fg_color = "#FFFFFF",
        intensity = "Bold",
        underline = "None",
        italic = false,
        strikethrough = false,
      },
      inactive_tab = { bg_color = "#f1f1f1", fg_color = "#24292e" },
      inactive_tab_hover = { bg_color = "#f1f1f1", fg_color = "#24292e", intensity = "Bold" },
      new_tab = { bg_color = "#f1f1f1", fg_color = "#24292e" },
      new_tab_hover = { bg_color = "#f1f1f1", fg_color = "#24292e", intensity = "Bold" },
    },
  },
}

local cur_os = get_current_os()
local font_cfg = os_fonts[cur_os]

local cfg = {
  default_prog = progs[cur_os],
  automatically_reload_config = true,
  color_scheme = wezterm.gui.get_appearance():find("Light") ~= nil and "Light" or "Dark",
  -- color_scheme = "Dark",
  color_schemes = color_schemes,
  bold_brightens_ansi_colors = true,
  -- fonts
  font = wezterm.font_with_fallback(font_cfg.fonts),
  font_size = font_cfg.size,
  line_height = 1.2,
  freetype_load_target = "HorizontalLcd", -- Light
  freetype_load_flags = "NO_HINTING|NO_AUTOHINT",
  freetype_render_target = "HorizontalLcd",
  allow_square_glyphs_to_overflow_width = "Never",
  -- scroll_bar
  scrollback_lines = 99999,
  enable_scroll_bar = false,
  -- tab_bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  use_fancy_tab_bar = false,
  tab_max_width = 100,
  -- windows
  -- TITLE | RESIZE
  window_decorations = "RESIZE",
  window_padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = "0.5cell" },
  window_close_confirmation = "NeverPrompt",
  native_macos_fullscreen_mode = true,
  -- keys
  disable_default_key_bindings = false,
  keys = {
    { key = "q",  mods = "CMD", action = "QuitApplication" },
    { key = "F9", mods = "ALT", action = wezterm.action.ShowTabNavigator },
    {
      key = "|",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "_",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "K",
      mods = "CTRL|SHIFT|ALT",
      -- action = wezterm.action.ClearScrollback 'ScrollbackOnly',
      action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
    },
  },
  ssh_domains = { { name = "dev", remote_address = "dev.loc" } },
}

-- events
-- ----------------------------------------------------------------------------
-- params: tab, tabs, panes, config, hover, max_width
wezterm.on("format-tab-title", function(tab, tabs, _, _, _, _)
  local idx = tab.tab_index + 1

  local prefix = (idx > 1 and tabs[idx - 1].is_active) and "  " or " "
  local suffix = (tab.is_active or idx == #tabs) and " " or "  "
  local title = prefix .. idx .. ": " .. basename(tab.active_pane.foreground_process_name) .. suffix

  if tab.is_active then
    return { { Attribute = { Intensity = "Bold" } }, { Text = title } }
  end
  return { { Text = title } }
end)

return cfg
