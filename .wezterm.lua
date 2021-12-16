local wezterm = require 'wezterm';

return {
  default_prog = {"powershell.exe"},
  color_scheme = "Molokai",
  window_background_opacity = 0.8,
  keys = {
    {key="LeftArrow", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=-1}},
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {key="RightArrow", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=1}},
  },
  hyperlink_rules = {
    -- Disable clickable hyper links
    {
      regex = "",
      format = "",
    },
  },
}
