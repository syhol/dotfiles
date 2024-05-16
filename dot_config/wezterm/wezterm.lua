-- Pull in the wezterm API
local wezterm = require 'wezterm'

return {
  color_scheme = 'Tokyo Night Storm',
  font = wezterm.font('MesloLGSDZ Nerd Font Mono', { weight = 'Medium' }),
  font_size = 14,
  freetype_load_flags = 'NO_HINTING',
  window_padding = {
    left = '40px',
    right = '40px',
    top = '40px',
    bottom = '40px',
  },
  enable_tab_bar = false,
  window_decorations = 'RESIZE',
  -- window_background_opacity = 0.85,
  macos_window_background_blur = 20,
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
      mods = 'CMD',
      action = wezterm.action.SplitVertical,
    },
    {
      key = 'Enter',
      mods = 'CMD|OPT',
      action = wezterm.action.SplitHorizontal,
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
