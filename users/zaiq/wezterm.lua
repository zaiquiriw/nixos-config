local wezterm = require 'wezterm'

local config = {}

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16.0
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = .9
config.color_scheme = 'Gruvbox dark, hard (base16)'

config.keys = {
  {
    key = 'C',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
  },
  {
    key = 'V',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom 'Clipboard'
  },
}

return config
