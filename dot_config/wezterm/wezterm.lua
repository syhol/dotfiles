-- Pull in the wezterm API
local wezterm = require 'wezterm'

return {
  color_scheme = 'Catppuccin Macchiato',
  font = wezterm.font('JetBrainsMono NF', { weight = 'Medium' }),
  font_size = 11,
  freetype_load_flags = 'NO_HINTING',
  window_padding = {
    left = '40px',
    right = '40px',
    top = '40px',
    bottom = '40px',
  },
  -- enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = true,
  dpi_by_screen = {
    ['Built-in Retina Display'] = 188,
    ['C34J79x'] = 94,
    -- ['C34J79x'] = 81.75,
  },
  window_decorations = 'RESIZE',
  -- window_background_opacity = 0.85,
  -- macos_window_background_blur = 20,
  line_height = 1.2,
  keys = {
    -- Make Option-Left equivalent to Alt-b; backward-word
    {
      key = 'LeftArrow',
      mods = 'OPT',
      action = wezterm.action { SendString = '\x1bb' },
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
      key = 'RightArrow',
      mods = 'OPT',
      action = wezterm.action { SendString = '\x1bf' },
    },
    {
      key = 'Enter',
      mods = 'CMD|OPT',
      action = wezterm.action.SplitVertical,
    },
    {
      key = 'Enter',
      mods = 'CMD',
      action = wezterm.action.SplitHorizontal,
    },
    {
      key = 'UpArrow',
      mods = 'CMD|OPT',
      action = wezterm.action.AdjustPaneSize { 'Up', 2 },
    },
    {
      key = 'DownArrow',
      mods = 'CMD|OPT',
      action = wezterm.action.AdjustPaneSize { 'Down', 2 },
    },
    {
      key = 'LeftArrow',
      mods = 'CMD|OPT',
      action = wezterm.action.AdjustPaneSize { 'Left', 2 },
    },
    {
      key = 'RightArrow',
      mods = 'CMD|OPT',
      action = wezterm.action.AdjustPaneSize { 'Right', 2 },
    },
  },
  mouse_bindings = {
    {
      event = { Drag = { streak = 1, button = 'Left' } },
      mods = 'SUPER',
      action = wezterm.action.StartWindowDrag,
    },
  },
}
