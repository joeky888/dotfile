// Zed settings
//
// For information on how to configure Zed, see the Zed
// documentation: https://zed.dev/docs/configuring-zed
//
// To see all of Zed's default settings without changing your
// custom settings, run the `open default settings` command
// from the command palette or from `Zed` application menu.
{
  "ui_font_size": 16,
  "buffer_font_size": 20,
  "ui_font_family": "Noto Sans CJK TC",
  "buffer_font_family": "UbuntuMono Nerd Font",
  "soft_wrap": "none",
  "format_on_save": "on",
  "autosave": "on_focus_change",
  "remove_trailing_whitespace_on_save": true,
  "theme": "Ayu Dark",
  "terminal": {
    "font_family": "UbuntuMono Nerd Font",
    "copy_on_select": true,
    "line_height": "standard",
    "font_size": 16
  },
  // Deno is my default language server for zed
  "languages": {
    "TypeScript": {
      "language_servers": [
        "deno",
        "emmet-language-server",
        "!typescript-language-server",
        "!eslint"
      ]
    },
    "TSX": {
      "language_servers": [
        "deno",
        "emmet-language-server",
        "!typescript-language-server",
        "!eslint",
        "tailwindcss-language-server"
      ]
    }
  }
}
