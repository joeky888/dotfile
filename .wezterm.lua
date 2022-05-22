local wezterm = require 'wezterm';

return {
  default_prog = {"powershell.exe"},
  color_scheme = "Molokai",
  window_background_opacity = 0.8,
  keys = {
    {key="LeftArrow", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=-1}},
    {key="RightArrow", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=1}},
    {key="u", mods="CTRL", action=wezterm.action{ScrollByPage=-0.5}},
    {key="j", mods="CTRL", action=wezterm.action{ScrollByPage=0.5}},
  },
  hyperlink_rules = {
    -- Disable clickable hyper links
    {
      regex = "",
      format = "",
    },
  },
}
