local wezterm = require 'wezterm'
local act = wezterm.action

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if pane:get_title():find("nvim") ~= nil or pane:get_title():find("ssh") ~= nil then
    window:perform_action(act.SendKey({ key = vim_direction, mods = 'CTRL' }), pane)
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)

wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)

wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)

wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)

local function sendTmuxKey(key)
  return act.Multiple {
    act.SendKey{ key = 'b', mods = 'CTRL'},
    act.SendKey{ key = key },
  }
end

local LEADER = 'SHIFT|CMD'
local TMUX_LEADER = 'SHIFT|ALT'

return {
  font = wezterm.font 'MesloLGS Nerd Font',
  font_size = 12.0,

  tab_bar_at_bottom = false,
  window_frame = {
    font = wezterm.font 'MesloLGS Nerd Font',
    font_size = 10.0,
  },

  color_scheme = "Tomorrow Night Eighties",

  scrollback_lines = 3500,

  adjust_window_size_when_changing_font_size = false,

  disable_default_key_bindings = true,

  keys = {
    { key = 't', mods = LEADER, action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 't', mods = TMUX_LEADER, action = sendTmuxKey('c') },
    { key = 'RightArrow', mods = LEADER, action = act.ActivateTabRelative(1) },
    { key = 'LeftArrow', mods = LEADER, action = act.ActivateTabRelative(-1) },
    { key = 'RightArrow', mods = TMUX_LEADER, action = sendTmuxKey('n') },
    { key = 'LeftArrow', mods = TMUX_LEADER, action = sendTmuxKey('p') },

    { key = '|', mods = LEADER, action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = '_', mods = LEADER, action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = '|', mods = TMUX_LEADER, action = sendTmuxKey('%') },
    { key = '_', mods = TMUX_LEADER, action = sendTmuxKey('"') },

    { key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },
    { key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'LeftArrow', mods = 'ALT', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'ALT', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'ALT', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'ALT', action = act.AdjustPaneSize{ 'Down', 1 } },

    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
    { key = '0', mods = 'CMD', action = act.ResetFontSize },
    { key = '=', mods = 'CMD', action = act.IncreaseFontSize },
    { key = '-', mods = 'CMD', action = act.DecreaseFontSize },

    { key = 'f', mods = LEADER, action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'k', mods = LEADER, action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'l', mods = LEADER, action = act.ShowDebugOverlay },

    { key = 's', mods = LEADER, action = act.ActivateCopyMode },
    { key = 'y', mods = LEADER, action = act.QuickSelect },
    { key = 'z', mods = LEADER, action = act.TogglePaneZoomState },
    { key = 'z', mods = TMUX_LEADER, action = sendTmuxKey('z') },
    { key = 'c', mods = LEADER, action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = LEADER, action = act.PasteFrom 'Clipboard' },

    { key = 'U', mods = 'CTRL', action = act.ScrollByPage(-0.5) },
    { key = 'D', mods = 'CTRL', action = act.ScrollByPage(0.5) },
  },

  key_tables = {
    copy_mode = {
      { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
      { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
    },

    search_mode = {
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },
  }
}
