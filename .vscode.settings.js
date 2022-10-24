{
    "editor.fontSize": 20,
    "editor.fontFamily": "'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', monospace",
    "terminal.integrated.fontFamily": "'Iosevka', 'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', 'Monaco', monospace",
    "editor.wordWrap": "off",
    "editor.tabSize": 2,
    "editor.detectIndentation": true,
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "files.encoding": "utf8",
    "files.eol": "\n",
    "files.trimTrailingWhitespace": true,
    "files.autoSave": "afterDelay",
    "explorer.compactFolders": false,
    "editor.minimap.enabled": true,
    "workbench.colorTheme": "Monokai",
    "editor.mouseWheelZoom": true,
    "editor.bracketPairColorization.enabled": true,
    "editor.cursorBlinking": "solid",
    "telemetry.telemetryLevel": "off",
    "editor.semanticHighlighting.enabled": true,
    "vscode_custom_css.imports": [
        "https://raw.githubusercontent.com/joeky888/dotfile/master/.vscode.monokai-neon-glow.css"
    ],
    "editor.semanticTokenColorCustomizations": {
        "[Monokai]": {
            "rules": {
                "type": {
                    "underline": false
                },
                "typeAlias": {
                    "underline": false
                },
                "class": {
                    "underline": false
                },
                "*.declaration": {
                    "underline": false
                },
                "unresolvedReference": {
                    "underline": false
                },
                "attribute": {
                    "underline": false
                },
                "interface": {
                    "underline": false
                },
                "enum": {
                    "underline": false
                },
                "struct": {
                    "underline": false
                },
                "namespace": {
                    "underline": false
                },
                "*.mutable": {
                    "underline": false
                },
            }
        }
    },
    "git.ignoreMissingGitWarning": true,
    "emmet.showSuggestionsAsSnippets": true,
    "editor.snippetSuggestions": "top",
    "terminal.integrated.fontSize": 18,
    "workbench.editor.enablePreview": false,
    "editor.dragAndDrop": false,
    "debug.console.fontFamily": "'Iosevka', 'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', 'Monaco', monospace",
    "debug.console.fontSize": 20,
    "debug.internalConsoleOptions": "openOnSessionStart",
    "debug.allowBreakpointsEverywhere": true,
    "eslint.alwaysShowStatus": true,
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": true
    },
    "editor.suggestSelection": "first",
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "[html]": {
        "editor.defaultFormatter": "vscode.html-language-features"
    },
    "[makefile]": {
        "editor.tabSize": 8,
        "editor.insertSpaces": false,
        "files.eol": "\n"
    },
    "[yaml]": {
        "editor.tabSize": 2,
        "editor.insertSpaces": true,
    },
    "[rust]": {
        "editor.defaultFormatter": "rust-lang.rust-analyzer",
        "editor.codeActionsOnSave": {
            "source.organizeImports": true,
            "source.fixAll": true,
        },
    },
    "rust-client.engine": "rust-analyzer",
    "rust-analyzer.checkOnSave.command": "clippy",
    "rust-analyzer.lru.capacity": 1024,
    "rust-analyzer.rustfmt.extraArgs": [
        "--config",
        "imports_granularity=Crate", // Merge imports into one line
    ],
    "lldb.adapterEnv": {
        "RUST_BACKTRACE": "1",
    },
    "[go]": {
        "editor.tabSize": 4,
        "editor.insertSpaces": false,
        "files.eol": "\n",
        "editor.codeActionsOnSave": {
            "source.organizeImports": true
        },
    },
    "go.testFlags": [
        "-count=1"
    ],
    "go.useLanguageServer": true,
    "go.languageServerExperimentalFeatures": {
        "diagnostics": true,
    },
    "go.lintTool": "golangci-lint",
    "go.lintFlags": [
        // Enable all fast linters
        "--fast",
        // and all default linter
        "-E=errcheck",
        "-E=gosimple",
        "-E=govet",
        "-E=ineffassign",
        "-E=staticcheck",
        "-E=typecheck",
        "-E=unused",
        "-E=paralleltest",
        "-E=gosec",
        "-E=gocritic",
        "-E=revive",
    ],
    "go.formatTool": "goimports",
    "go.formatFlags": [
        "-e",
    ],
    "go.delveConfig": {
        "apiVersion": 2,
        "showGlobalVariables": true
    },
    "gopls": {
        "usePlaceholders": true,
        "completeUnimported": true,
        "ui.semanticTokens": true
    },
    "go.generateTestsFlags": [
        "-parallel"
    ],
    "deno.enable": true,
    "deno.lint": true,
    "deno.codeLens.implementations": true,
    "deno.codeLens.references": true,
    "deno.codeLens.referencesAllFunctions": true,
    "deno.suggest.autoImports": true,
    "deno.suggest.completeFunctionCalls": true,
    "deno.suggest.names": true,
    "deno.suggest.paths": false,
    "[javascript]": {
        "editor.defaultFormatter": "vscode.typescript-language-features"
    },
    "[typescript]": {
        "editor.defaultFormatter": "vscode.typescript-language-features"
    },
    "[dart]": {
        "editor.formatOnSave": true,
        "editor.formatOnType": true,
        "editor.selectionHighlight": false,
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        "editor.suggestSelection": "first",
        "editor.tabCompletion": "onlySnippets",
        "editor.wordBasedSuggestions": false
    },
    "[markdown]": {
        "editor.defaultFormatter": "yzhang.markdown-all-in-one"
    },
    "terminal.integrated.gpuAcceleration": "auto",
    "workbench.editor.tabSizing": "shrink",
    "workbench.colorCustomizations": {
        "sideBarSectionHeader.background": "#180f21",
        "tab.inactiveBackground": "#4c3761",
        "list.hoverBackground": "#4c3761",
        "list.activeSelectionBackground": "#765299",
        "list.inactiveSelectionBackground": "#765299",
        "toolbar.hoverBackground": "#4c3761",
        "editor.lineHighlightBackground": "#4c3761",
        "activityBar.background": "#180f21",
        "editor.background": "#180f21",
        "sideBar.background": "#180f21",
        "terminal.background": "#180f21",
        "terminal.foreground": "#c4c5b5",
        "terminalCursor.background": "#A5A2A2",
        "terminalCursor.foreground": "#A5A2A2",
        "terminal.ansiBlack": "#1a1a1a",
        "terminal.ansiBlue": "#9d65ff",
        "terminal.ansiBrightBlack": "#625e4c",
        "terminal.ansiBrightBlue": "#9d65ff",
        "terminal.ansiBrightCyan": "#58d1eb",
        "terminal.ansiBrightGreen": "#98e024",
        "terminal.ansiBrightMagenta": "#f4005f",
        "terminal.ansiBrightRed": "#f4005f",
        "terminal.ansiBrightWhite": "#f6f6ef",
        "terminal.ansiBrightYellow": "#e0d561",
        "terminal.ansiCyan": "#58d1eb",
        "terminal.ansiGreen": "#98e024",
        "terminal.ansiMagenta": "#f4005f",
        "terminal.ansiRed": "#f4005f",
        "terminal.ansiWhite": "#c4c5b5",
        "terminal.ansiYellow": "#fa8419"
    },
    "[json]": {
        "editor.defaultFormatter": "vscode.json-language-features"
    },
    "redhat.telemetry.enabled": false,
    "workbench.iconTheme": "vscode-icons",
    "terraform.languageServer.enable": true,
    "terraform.languageServer.path": "",
}
