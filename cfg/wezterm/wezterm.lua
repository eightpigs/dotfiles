local wezterm = require("wezterm")
local act = wezterm.action

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

local function str_split(s, delimiter)
  local result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function color()
  return wezterm.gui.get_appearance():find("Light") and "Light" or "Dark"
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
      -- { family = "IBM Plex Mono", weight = "Regular", scale = 1.0 },
      -- { family = "Monaspace Argon Var", stretch = "Condensed", scale = 1.0 },
      { family = "Cascadia Mono", weight = "Book",   scale = 1.0 },
      -- { family = "Monaspace Xenon Var", weight = "Medium",   stretch = "Condensed", scale = 1.2 },
      -- { family = "Iosevka",             weight = "Regular",  stretch = "Expanded",  scale = 1.2 },
      -- { family = "Fira Code",           weight = "Regular",  scale = 1.2 },
      -- { family = "JetBrains Mono",      weight = "Regular",  scale = 1.2 },
      { family = "LXGW WenKai",   weight = "Bold",   scale = 1.0 },
      { family = "PingFang SC",   weight = "Medium", scale = 1.0 },
    },
    size = 16.0,
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
    foreground = "#dcdfe4",
    background = "#2b2b2b",
    cursor_bg = "#c9d1d9",
    cursor_border = "#c9d1d9",
    cursor_fg = "#101216",
    selection_bg = "#3b5070",
    selection_fg = "#ffffff",
    scrollbar_thumb = "#222222",
    split = "#444444",
    ansi = { "#000000", "#cc7832", "#56d364", "#e3b341", "#82aaff", "#db61a2", "#2b7489", "#ffffff" },
    brights = { "#4d4d4d", "#cc7832", "#56d364", "#e3b341", "#82aaff", "#db61a2", "#2b7489", "#ffffff" },
    indexed = { [136] = "#af8700" },
    compose_cursor = "#c9d1d9",
    tab_bar = {
      background = "#414141",
      active_tab = {
        bg_color = "#2b2b2b",
        fg_color = "#ff6541",
        intensity = "Normal",
        underline = "None",
      },
      inactive_tab = { bg_color = "#414141", fg_color = "#dcdfe4" },
      inactive_tab_hover = { bg_color = "#333333", fg_color = "#dcdfe4", intensity = "Bold" },
      new_tab = { bg_color = "#414141", fg_color = "#dcdfe4" },
      new_tab_hover = { bg_color = "#333333", fg_color = "#dcdfe4", intensity = "Bold" },
    }
  },
  ["Light"] = {
    foreground = "#24292e",
    background = "#f5f5f5",
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
      background = "#E0E0E0",
      active_tab = {
        bg_color = "#f5f5f5",
        fg_color = "#cc342b",
        intensity = "Normal",
        underline = "None",
        italic = false,
        strikethrough = false,
      },
      inactive_tab = { bg_color = "#E0E0E0", fg_color = "#24292e", intensity = "Normal", },
      inactive_tab_hover = { bg_color = "#E0E0E0", fg_color = "#24292e", intensity = "Bold" },
      new_tab = { bg_color = "#E0E0E0", fg_color = "#24292e" },
      new_tab_hover = { bg_color = "#f1f1f1", fg_color = "#24292e", intensity = "Bold" },
    },
  },
}

local cur_os = get_current_os()
local font_cfg = os_fonts[cur_os]

local cfg = {
  front_end = "OpenGL",
  -- cell_width = 0.94,

  default_prog = progs[cur_os],
  automatically_reload_config = true,

  color_scheme = color(),
  color_schemes = color_schemes,
  bold_brightens_ansi_colors = true,

  check_for_updates = false,

  -- fonts
  font = wezterm.font_with_fallback(font_cfg.fonts),
  font_size = font_cfg.size,
  adjust_window_size_when_changing_font_size = false,
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  warn_about_missing_glyphs = false,
  underline_thickness = "160%",
  underline_position = "-4pt",
  line_height = 1.2,
  freetype_load_target = 'Light',
  freetype_render_target = 'HorizontalLcd',
  freetype_load_flags = 'FORCE_AUTOHINT|MONOCHROME',
  freetype_interpreter_version = 40,
  allow_square_glyphs_to_overflow_width = "Always",

  -- scroll_bar
  scrollback_lines = 9000,
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
  window_padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = "0" },
  window_close_confirmation = "NeverPrompt",
  window_frame = {
    font = wezterm.font { family = 'JetBrains Mono', weight = 'Regular' },
  },
  initial_rows = 30,
  initial_cols = 120,

  native_macos_fullscreen_mode = true,

  command_palette_font_size = 15.0,
  command_palette_bg_color = color_schemes[color()].tab_bar.background,
  command_palette_fg_color = color_schemes[color()].foreground,

  -- keys
  disable_default_key_bindings = false,
  leader = { key = "`", mods = "CTRL|ALT", timeout_milliseconds = 1000 },
  keys = {

    -- from: https://github.com/wez/wezterm/discussions/2329
    -- Window management
    { key = "c",  mods = "LEADER", action = act { SpawnTab = "CurrentPaneDomain" } },
    { key = "-",  mods = "LEADER", action = act { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "\\", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "h",  mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j",  mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k",  mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l",  mods = "LEADER", action = act.ActivatePaneDirection("Right") },

    { key = "H",  mods = "LEADER", action = act { AdjustPaneSize = { "Left", 5 } } },
    { key = "J",  mods = "LEADER", action = act { AdjustPaneSize = { "Down", 5 } } },
    { key = "K",  mods = "LEADER", action = act { AdjustPaneSize = { "Up", 5 } } },
    { key = "L",  mods = "LEADER", action = act { AdjustPaneSize = { "Right", 5 } } },

    -- { key = "`",  mods = "LEADER", action = act.ActivateLastTab },
    { key = " ",  mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "1",  mods = "LEADER", action = act { ActivateTab = 0 } },
    { key = "2",  mods = "LEADER", action = act { ActivateTab = 1 } },
    { key = "3",  mods = "LEADER", action = act { ActivateTab = 2 } },
    { key = "4",  mods = "LEADER", action = act { ActivateTab = 3 } },
    { key = "5",  mods = "LEADER", action = act { ActivateTab = 4 } },
    { key = "6",  mods = "LEADER", action = act { ActivateTab = 5 } },
    { key = "7",  mods = "LEADER", action = act { ActivateTab = 6 } },
    { key = "8",  mods = "LEADER", action = act { ActivateTab = 7 } },
    { key = "9",  mods = "LEADER", action = act { ActivateTab = 8 } },
    { key = "x",  mods = "LEADER", action = act { CloseCurrentPane = { confirm = true } } },

    {
      key = '.',
      mods = 'LEADER',
      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },

    -- Activate Copy Mode
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
    -- Paste from Copy Mode
    { key = "]", mods = "LEADER", action = act.PasteFrom("PrimarySelection") },

    { key = "q", mods = "CMD",    action = "QuitApplication" },
  },

  key_tables = {
    -- added new shortcuts to the end
    copy_mode = {
      { key = "c",          mods = "CTRL",  action = act.CopyMode("Close") },
      { key = "g",          mods = "CTRL",  action = act.CopyMode("Close") },
      { key = "q",          mods = "NONE",  action = act.CopyMode("Close") },
      { key = "Escape",     mods = "NONE",  action = act.CopyMode("Close") },

      { key = "h",          mods = "NONE",  action = act.CopyMode("MoveLeft") },
      { key = "j",          mods = "NONE",  action = act.CopyMode("MoveDown") },
      { key = "k",          mods = "NONE",  action = act.CopyMode("MoveUp") },
      { key = "l",          mods = "NONE",  action = act.CopyMode("MoveRight") },

      { key = "LeftArrow",  mods = "NONE",  action = act.CopyMode("MoveLeft") },
      { key = "DownArrow",  mods = "NONE",  action = act.CopyMode("MoveDown") },
      { key = "UpArrow",    mods = "NONE",  action = act.CopyMode("MoveUp") },
      { key = "RightArrow", mods = "NONE",  action = act.CopyMode("MoveRight") },

      { key = "RightArrow", mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
      { key = "f",          mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
      { key = "Tab",        mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
      { key = "w",          mods = "NONE",  action = act.CopyMode("MoveForwardWord") },

      { key = "LeftArrow",  mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
      { key = "b",          mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
      { key = "Tab",        mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
      { key = "b",          mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },

      { key = "0",          mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
      { key = "Enter",      mods = "NONE",  action = act.CopyMode("MoveToStartOfNextLine") },

      { key = "$",          mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
      { key = "$",          mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
      { key = "^",          mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "^",          mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "m",          mods = "ALT",   action = act.CopyMode("MoveToStartOfLineContent") },

      { key = " ",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Cell" } },
      { key = "v",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Cell" } },
      { key = "V",          mods = "NONE",  action = act.CopyMode { SetSelectionMode = "Line" } },
      { key = "V",          mods = "SHIFT", action = act.CopyMode { SetSelectionMode = "Line" } },
      { key = "v",          mods = "CTRL",  action = act.CopyMode { SetSelectionMode = "Block" } },

      { key = "G",          mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
      { key = "G",          mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
      { key = "g",          mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },

      { key = "H",          mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
      { key = "H",          mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
      { key = "M",          mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
      { key = "M",          mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
      { key = "L",          mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
      { key = "L",          mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },

      { key = "o",          mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
      { key = "O",          mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
      { key = "O",          mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

      { key = "PageUp",     mods = "NONE",  action = act.CopyMode("PageUp") },
      { key = "PageDown",   mods = "NONE",  action = act.CopyMode("PageDown") },

      { key = "b",          mods = "CTRL",  action = act.CopyMode("PageUp") },
      { key = "f",          mods = "CTRL",  action = act.CopyMode("PageDown") },

      -- Enter y to copy and quit the copy mode.
      {
        key = "y",
        mods = "NONE",
        action = act.Multiple {
          act.CopyTo("ClipboardAndPrimarySelection"),
          act.CopyMode("Close"),
        }
      },
      -- Enter search mode to edit the pattern.
      -- When the search pattern is an empty string the existing pattern is preserved
      { key = "/", mods = "NONE", action = act { Search = { CaseSensitiveString = "" } } },
      { key = "?", mods = "NONE", action = act { Search = { CaseInSensitiveString = "" } } },
      { key = "n", mods = "CTRL", action = act { CopyMode = "NextMatch" } },
      { key = "p", mods = "CTRL", action = act { CopyMode = "PriorMatch" } },
    },

    search_mode = {
      { key = "Escape", mods = "NONE", action = act { CopyMode = "Close" } },
      -- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
      -- to navigate search results without conflicting with typing into the search area.
      { key = "Enter",  mods = "NONE", action = "ActivateCopyMode" },
      { key = "c",      mods = "CTRL", action = "ActivateCopyMode" },
      { key = "n",      mods = "CTRL", action = act { CopyMode = "NextMatch" } },
      { key = "p",      mods = "CTRL", action = act { CopyMode = "PriorMatch" } },
      { key = "r",      mods = "CTRL", action = act.CopyMode("CycleMatchType") },
      { key = "u",      mods = "CTRL", action = act.CopyMode("ClearPattern") },
    },
  },
  ssh_domains = { { name = "dev", remote_address = "dev.loc" } },
}

-- events
-- ----------------------------------------------------------------------------
-- params: tab, tabs, panes, config, hover, max_width
wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
  local idx = tab.tab_index + 1
  -- return { { Text = " " .. idx .. ": " .. tab.get_title() .. " " } }
  local process = basename(tab.active_pane.foreground_process_name)
  local title = ""
  if process ~= "" and #process > 0 then
    process = process == "zsh" and "DIR" or process
    local dir = basename(tab.active_pane.current_working_dir)
    title = " " .. idx .. ":" .. process .. " (" .. dir .. ")" .. " "
  else
    title = " " .. idx .. ": " .. tab.active_pane.title .. " "
  end
  if tab.is_active then
    return { { Attribute = { Intensity = "Normal" } }, { Text = title } }
  end
  return { { Text = title } }
end)


--- params: window, pane
local function refresh_config(window, _)
  if cur_os == os_mac then
    local overrides = window:get_config_overrides() or {}
    local macDisplay = wezterm.gui.screens().active.name == "Built-in Retina Display"
    local font_size = macDisplay and 16 or 15
    if window:effective_config().font_size ~= font_size then
      overrides.font_size = font_size
      window:set_config_overrides(overrides)
    end
  end
end
--
wezterm.on("window-config-reloaded", refresh_config)
wezterm.on("window-resized", refresh_config)

wezterm.on('update-status', function(window, _)
  local output = os.exec("uptime | /opt/homebrew/bin/rg '^.*?(load av.+:)(.*)' -r '$2'")
  local text = output:gsub("%s+", " ")
  window:set_right_status(wezterm.format {
    { Foreground = { Color = color_schemes[color()].foreground } },
    { Text = text },
  })
end)

return cfg
