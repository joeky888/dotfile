local wezterm = require 'wezterm';

return {
  default_prog = {"powershell.exe"},
  color_scheme = "Molokai",
  window_background_opacity = 0.8,
  text_background_opacity = 0.9,
  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance", -- Prefer dGPU
  leader = { key="b", mods="CTRL", timeout_milliseconds=1500 }, -- Like tmux ctrl-b
  keys = {
    {key="LeftArrow", mods="CTRL|SHIFT", action=wezterm.action{ ActivateTabRelative=-1} }, -- Move to left tab
    {key="RightArrow", mods="CTRL|SHIFT", action=wezterm.action{ ActivateTabRelative=1} }, -- Move to right tab
    {key="u", mods="CTRL", action=wezterm.action{ ScrollByPage=-0.5 }}, -- Scroll up
    {key="j", mods="CTRL", action=wezterm.action{ ScrollByPage=0.5 }}, -- Scroll down
    {
      key="_", mods="LEADER|SHIFT", action=wezterm.action{
        SplitVertical={
          domain="CurrentPaneDomain",
        },
      },
    }, -- Split Horizontally
    {
      key="|", mods="LEADER|SHIFT", action=wezterm.action{
        SplitHorizontal={
          domain="CurrentPaneDomain",
        },
      },
    }, -- Split Vertically
    {
      key="+", mods="LEADER|SHIFT", action={
        Multiple={
          {
            SplitHorizontal={
              domain="CurrentPaneDomain",
            },
          },
          {
            SplitVertical={
              domain="CurrentPaneDomain",
            },
          },
        }
      }
    }, -- TODO: Split Horizontally&&Horizontally
  },
  hyperlink_rules = {
    -- Disable clickable hyper links
    {
      regex = "",
      format = "",
    },
  },
}
