local wezterm = require 'wezterm';

function font_with_fallback(name, params)
  local names = { name, "YouYuan", "Microsoft YaHei" }
  return wezterm.font_with_fallback(names, params)
end

return {
  color_scheme = "Gruvbox Dark",

  -- https://aka.ms/powershell
  default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" },

  -- fonts
  font = font_with_fallback("CodeNewRoman NF"),
  font_size = 12.0,
  line_height = 1.3,

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
    font = font_with_fallback("JetBrains Mono"),
    font_size = 10.0,
    active_titlebar_bg = "#333333",
    inactive_titlebar_bg = "#333333"
  }
}
