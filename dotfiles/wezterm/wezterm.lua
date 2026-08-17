local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local act = wezterm.action

local copy_mode = wezterm.gui.default_key_tables().copy_mode
local search_mode = wezterm.gui.default_key_tables().search_mode

-- q exits copy mode
table.insert(copy_mode, {
  key = 'q',
  mods = 'NONE',
  action = act.Multiple {
    act.CopyMode 'Close',
    act.ScrollToBottom,
  },
})

-- escape to deselect
table.insert(copy_mode, {
  key = 'Escape',
  mods = 'NONE',
  action = act.CopyMode 'ClearSelectionMode',
})
table.insert(copy_mode, {
  key = '[',
  mods = 'CTRL',
  action = act.CopyMode 'ClearSelectionMode',
})

-- Ctrl+[ exits search mode
table.insert(search_mode, {
  key = '[',
  mods = 'CTRL',
  action = act.CopyMode 'Close',
})

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.key_tables = {
  copy_mode = copy_mode,
  search_mode = search_mode,
}

config.leader = {
  key = 'b',
  mods = 'CTRL',
}

config.keys = {
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Left', 1 },
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Right', 1 },
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Up', 1 },
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Down', 1 },
  },
}


config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.Nop,
  },
  -- Keep double-click word selection working without copying
  {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = act.Nop,
  },
  -- Triple-click line selection without copying
  {
    event = { Up = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = act.Nop,
  },
}

config.unix_domains = {
  { name = 'unix' },
}
config.ssh_domains = {
  {
    name = "chococarrot",
    remote_address = "10.100.0.1",
    username = "seabert",
    multiplexing = "WezTerm",
  },
}

config.color_scheme = 'Seoul256 (Gogh)'

config.initial_cols = 190
config.initial_rows = 50

config.scrollback_lines = 4723

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.5,
}

config.font_size = 7.9
config.command_palette_font_size = 9.0
config.window_frame = {
  font_size = 7.5,
}

if wezterm.target_triple:find("apple") then
  config.font_size = 11.0
  config.command_palette_font_size = 10.0
  config.window_frame = {
    font_size = 9.0,
  }
end

config.hide_tab_bar_if_only_one_tab = true

-- needed for sway to prevent window issues
config.adjust_window_size_when_changing_font_size = false

return config
