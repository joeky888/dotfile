// Zed settings
//
// For information on how to configure Zed, see the Zed
// documentation: https://zed.dev/docs/configuring-zed
//
// To see all of Zed's default settings without changing your
// custom settings, run the `open default settings` command
// from the command palette or from `Zed` application menu.
{
  "agent": {
    "default_profile": "ask",
    "default_model": {
      "provider": "zed.dev",
      "model": "gemini-3-flash",
    },
    "always_allow_tool_actions": true,
    "model_parameters": [],
  },
  "icon_theme": "Material Icon Theme",
  "ui_font_size": 16,
  "buffer_font_size": 20,
  "ui_font_family": "Noto Sans CJK TC",
  "buffer_font_family": "UbuntuMono Nerd Font",
  "soft_wrap": "none",
  "format_on_save": "on",
  "autosave": "on_focus_change",
  "remove_trailing_whitespace_on_save": true,
  "theme": "Ayu Dark",
  "minimap": { "show": "always" },
  "use_system_window_tabs": true, // macOS native tab
  "terminal": {
    "font_family": "UbuntuMono Nerd Font",
    "copy_on_select": true,
    "line_height": "standard",
    "font_size": 16,
  },
  "project_panel": {
    "auto_fold_dirs": false,
  },
  "lsp": {
    "golangci-lint": {
      "initialization_options": {
        "command": [
          "golangci-lint",
          "run",
          "--output.json.path",
          "stdout",
          "--show-stats=false",
          "--output.text.path=",
          "-E=govet",
          "-E=ineffassign",
          "-E=unused",
          "-E=paralleltest",
          "-E=staticcheck",
          "-E=gocritic",
          "-E=errchkjson",
          "-E=rowserrcheck",
          "-E=errcheck",
          "-E=revive",
          "--timeout=5m",
        ],
      },
    },
    "rust-analyzer": {
      "initialization_options": {
        "check": {
          "command": "clippy",
        },
      },
    },
    "yaml-language-server": {
      "settings": {
        "yaml": {
          "format": {
            "singleQuote": false,
            "printWidth": 80,
            "proseWrap": "never",
          },
        },
      },
    },
  },
  "languages": {
    "YAML": {
      "formatter": "language_server",
    },
    "Go": {
      "language_servers": ["gopls", "golangci-lint"],
    },
    "Rust": {
      "format_on_save": "on",
    },
    "TypeScript": {
      "language_servers": [
        "deno",
        "emmet-language-server",
        "tsgo",
        "!typescript-language-server",
        "!vtsls",
        "!eslint",
      ],
      "formatter": "language_server",
    },
    "TSX": {
      "language_servers": [
        "deno",
        "emmet-language-server",
        "!typescript-language-server",
        "!vtsls",
        "!eslint",
        "tailwindcss-language-server",
      ],
      "formatter": "language_server",
    },
    // Use pyrefly as lsp, ruff as lint
    "Python": {
      "language_servers": ["ty", "ruff", "!pyright", "!pylsp"],
      "format_on_save": "on",
      "formatter": [
        { "code_action": "source.organizeImports.ruff" },
        {
          "language_server": {
            "name": "ruff",
          },
        },
      ],
    },
  },
}
