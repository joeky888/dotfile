Setting
=====
```toml
[[hints.enabled]]
command = "xdg-open"
post_processing = true
regex = "(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001F\u007F-<>\"\\s{-}\\^⟨⟩`]+"

[hints.enabled.mouse]
enabled = false
mods = "None"
##############################
[selection]
save_to_clipboard = true
##############################
[font]
size = 18.0
[font.bold]
family = "UbuntuMono Nerd Font"

[font.normal]
family = "UbuntuMono Nerd Font"
##############################
[cursor]
style = "Beam"
##############################
[window]
opacity = 0.9
[window.dimensions]
columns = 130
lines = 30
```

Color (Monokai soda)
=====
```toml
# Colors (Monokai Soda)

[colors.bright]
black = "0x625e4c"
blue = "0x9d65ff"
cyan = "0x58d1eb"
green = "0x98e024"
magenta = "0xf4005f"
red = "0xf4005f"
white = "0xf6f6ef"
yellow = "0xe0d561"

[colors.normal]
black = "0x1a1a1a"
blue = "0x9d65ff"
cyan = "0x58d1eb"
green = "0x98e024"
magenta = "0xf4005f"
red = "0xf4005f"
white = "0xc4c5b5"
yellow = "0xfa8419"

[colors.primary]
background = "0x1a1a1a"
foreground = "0xc4c5b5"
```

Windows shortcut for cygwin + tmux = mintty alternative
=====
* Credit:
  * https://github.com/alacritty/alacritty/issues/1687
  * https://github.com/microsoft/terminal/issues/5132
```sh
C:\Users\joeky\scoop\apps\alacritty\current\alacritty.exe --command "C:\cygwin64\bin\sh.exe" --login -c "script -c tmux"
```
