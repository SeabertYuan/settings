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

config.default_gui_startup_args = { 'connect', 'unix' }

config.initial_cols = 190
config.initial_rows = 50

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.5,
}

return config
