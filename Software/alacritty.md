Setting
=====
```yaml
hints:
  enabled:
   - regex: "(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)\
             [^\u0000-\u001F\u007F-\u009F<>\"\\s{-}\\^⟨⟩`]+"
     command: xdg-open
     post_processing: true
     mouse:
       enabled: false # 👈
       mods: None
##############################
selection:
  save_to_clipboard: true
##############################
font:
  normal:
    family: Iosevka
  bold:
    family: Iosevka
  size: 16.0
##############################
cursor:
  style: Beam
##############################
window:
  opacity: 0.9
  dimensions:
    columns: 130
    lines: 30
```

Color (Monokai soda)
=====
```yaml
# Colors (Monokai Soda)
colors:
  # Default colors
  primary:
    background: '0x1a1a1a'
    foreground: '0xc4c5b5'

  # Normal colors
  normal:
    black:   '0x1a1a1a'
    red:     '0xf4005f'
    green:   '0x98e024'
    yellow:  '0xfa8419'
    blue:    '0x9d65ff'
    magenta: '0xf4005f'
    cyan:    '0x58d1eb'
    white:   '0xc4c5b5'

  # Bright colors
  bright:
    black:   '0x625e4c'
    red:     '0xf4005f'
    green:   '0x98e024'
    yellow:  '0xe0d561'
    blue:    '0x9d65ff'
    magenta: '0xf4005f'
    cyan:    '0x58d1eb'
    white:   '0xf6f6ef'
```
