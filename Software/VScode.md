Setting (search `json`)
=====
* View -> Command Palette -> Search for "open settings (json)"
```js
{
    "editor.fontSize": 20,
    "editor.fontFamily": "'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', monospace",
    "terminal.integrated.fontFamily": "'Iosevka', 'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', 'Monaco', monospace",
    "editor.wordWrap": "off",
    "editor.tabSize": 4,
    "editor.detectIndentation": true,
    "editor.formatOnSave": true,
    "files.encoding": "utf8",
    "files.eol": "\n",
    "files.trimTrailingWhitespace": true,
    "files.autoSave": "afterDelay",
    "explorer.compactFolders": false,
    "powermode.enabled": true,
    "editor.minimap.enabled": true,
    "workbench.colorTheme": "Monokai",
    "editor.mouseWheelZoom": true,
    "editor.cursorBlinking": "solid",
    "git.ignoreMissingGitWarning": true,
    "emmet.showSuggestionsAsSnippets": true,
    "editor.snippetSuggestions": "top",
    "terminal.integrated.fontSize": 18,
    "workbench.editor.enablePreview": false,
    "editor.dragAndDrop": false,
    "window.zoomLevel": 0,
    "debug.console.fontFamily": "'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', 'Monaco', monospace",
    "debug.console.fontSize": 20,
    "debug.internalConsoleOptions": "openOnSessionStart",
    "debug.allowBreakpointsEverywhere": true,
    "eslint.autoFixOnSave": true,
    "eslint.alwaysShowStatus": true,
    "[makefile]": {
        "editor.tabSize": 8,
        "editor.insertSpaces": false,
        "files.eol": "\n"
    },
    "[yaml]": {
        "editor.tabSize": 2,
        "editor.insertSpaces": true,
    },
    "rust-client.engine": "rust-analyzer",
    "rust-analyzer.enableCargoWatchOnStartup": "enabled",
    "rust-analyzer.lruCapacity": 1024,
    "rust-analyzer.featureFlags": {
        "lsp.diagnostics": true,
        "completion.insertion.add-call-parenthesis": true,
        "completion.enable-postfix": true,
        "notifications.workspace-loaded": true,
    },
    "rust-analyzer.inlayHints.enable": false,
    "[csharp]": {
        "editor.tabSize": 4,
        "editor.insertSpaces": false,
    },
    "[go]": {
        "editor.tabSize": 8,
        "editor.insertSpaces": false,
        "files.eol": "\n",
        "editor.codeActionsOnSave": {
            "source.organizeImports": true
        },
    },
    "go.testFlags": ["-count=1"],
    "go.useLanguageServer": true,
    "go.languageServerExperimentalFeatures": {
        "format": false, // Disable to use "go.formatTool"
        "autoComplete": true,
        "rename": true,
        "goToDefinition": true,
        "signatureHelp": true,
        "goToTypeDefinition": true,
        "goToImplementation": true,
        "documentSymbols": true,
        "workspaceSymbols": true,
        "findReferences": true,
        "diagnostics": true,
    },
    "go.lintTool":"golangci-lint",
    "go.lintFlags": [
        // "--enable-all",
        "--fast",
    ],
    "go.formatTool": "goimports",
    "go.formatFlags": [
        "-e",
    ],
    "go.delveConfig": {
        "dlvLoadConfig": {
            "followPointers": true,
            "maxVariableRecurse": 1,
            "maxStringLen": 1024,
            "maxArrayValues": 1024,
            "maxStructFields": -1
          },
          "apiVersion": 2,
          "showGlobalVariables": true
    },
    "gopls": {
        "usePlaceholders": true,
        "completeUnimported": true,
    },
    "[javascript]": {
        "editor.formatOnSave": true
    },
    "csharp.referencesCodeLens.enabled": false,
    "terminal.integrated.rendererType": "dom",
    "workbench.editor.tabSizing": "shrink",
    "workbench.colorCustomizations": {
      "terminal.background":"#1a1a1a",
      "terminal.foreground":"#c4c5b5",
      "terminalCursor.background":"#A5A2A2",
      "terminalCursor.foreground":"#A5A2A2",
      "terminal.ansiBlack":"#1a1a1a",
      "terminal.ansiBlue":"#9d65ff",
      "terminal.ansiBrightBlack":"#625e4c",
      "terminal.ansiBrightBlue":"#9d65ff",
      "terminal.ansiBrightCyan":"#58d1eb",
      "terminal.ansiBrightGreen":"#98e024",
      "terminal.ansiBrightMagenta":"#f4005f",
      "terminal.ansiBrightRed":"#f4005f",
      "terminal.ansiBrightWhite":"#f6f6ef",
      "terminal.ansiBrightYellow":"#e0d561",
      "terminal.ansiCyan":"#58d1eb",
      "terminal.ansiGreen":"#98e024",
      "terminal.ansiMagenta":"#f4005f",
      "terminal.ansiRed":"#f4005f",
      "terminal.ansiWhite":"#c4c5b5",
      "terminal.ansiYellow":"#fa8419"
    }
}
```

Extension
=====
* Rust
    * vadimcn.vscode-lldb
    * rust-lang.rust (`"rust-client.engine": "rust-analyzer"`)
    * or matklad.rust-analyzer
* ms-vscode.go
* eslint
* Markdown All in One (opt+shift+f to format tables)
* Gitlens
* Vscode-proto3
* Shellcheck
* Versionlens - Check update for package.json
* humao.rest-client - Postman-like http client, support curl
* ms-azuretools.vscode-docker
* be5invis.toml
* hediet.vscode-drawio
* serayuzgur.crates

Key
=====
* View -> Command Palette -> Search for "keyboard shortcuts (json)"
```json
[
    { "key": "ctrl+k", "command": "editor.action.deleteLines",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "ctrl+d", "command": "editor.action.copyLinesDownAction",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "ctrl+up", "command": "cursorPageUp",
        "when": "editorTextFocus" },
    { "key": "ctrl+down", "command": "cursorPageDown",
        "when": "editorTextFocus" },
    { "key": "ctrl+t", "command": "workbench.action.files.newUntitledFile" },
    { "key": "ctrl+u", "command": "editor.action.moveLinesUpAction" },
    { "key": "ctrl+j", "command": "editor.action.moveLinesDownAction" },
    { "key": "pageup", "command": "cursorPageUp",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "pagedown","command": "cursorPageDown",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "ctrl+a", "command": "cursorHome",
        "when": "editorTextFocus" },
    { "key": "ctrl+e", "command": "cursorEnd",
        "when": "editorTextFocus" },
    { "key": "ctrl+g", "command": "editor.action.selectAll" },
    { "key": "tab", "command": "selectNextSuggestion",
        "when": "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible" },
    { "key": "ctrl+oem_5", "command": "editor.action.commentLine",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "ctrl+f", "command": "actions.find" },
    { "key": "ctrl+h", "command": "editor.action.startFindReplaceAction" },
    { "key": "ctrl+r", "command": "editor.action.startFindReplaceAction" },
    { "key": "ctrl+n", "command": "editor.action.addSelectionToNextFindMatch" },
    { "key": "ctrl+q", "command": "editor.action.insertCursorBelow" },
    { "key": "ctrl+y", "command": "redo", "when": "editorTextFocus" },
    { "key": "ctrl+b", "command": "editor.action.formatDocument",
        "when": "editorTextFocus" },
    { "key": "ctrl+[Slash]", "command": "editor.action.commentLine",
        "when": "editorTextFocus && !editorReadonly" }
    { "key": "alt+enter", "command": "editor.action.quickFix"},

     { "key": "cmd+k", "command": "editor.action.deleteLines",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "cmd+d", "command": "editor.action.copyLinesDownAction",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "cmd+up", "command": "cursorPageUp",
        "when": "editorTextFocus" },
    { "key": "cmd+down", "command": "cursorPageDown",
        "when": "editorTextFocus" },
    { "key": "cmd+t", "command": "workbench.action.files.newUntitledFile" },
    { "key": "cmd+u", "command": "editor.action.moveLinesUpAction" },
    { "key": "cmd+j", "command": "editor.action.moveLinesDownAction" },
    { "key": "cmd+a", "command": "cursorHome",
        "when": "editorTextFocus" },
    { "key": "cmd+e", "command": "cursorEnd",
        "when": "editorTextFocus" },
    { "key": "cmd+g", "command": "editor.action.selectAll" },
    { "key": "cmd+oem_5", "command": "editor.action.commentLine",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "cmd+f", "command": "actions.find" },
    { "key": "cmd+h", "command": "editor.action.startFindReplaceAction" },
    { "key": "cmd+r", "command": "editor.action.startFindReplaceAction" },
    { "key": "cmd+n", "command": "editor.action.addSelectionToNextFindMatch" },
    { "key": "cmd+q", "command": "editor.action.insertCursorBelow" },
    { "key": "cmd+y", "command": "redo", "when": "editorTextFocus" },
    { "key": "cmd+b", "command": "editor.action.formatDocument",
        "when": "editorTextFocus" },
    { "key": "cmd+[Slash]", "command": "editor.action.commentLine",
        "when": "editorTextFocus && !editorReadonly" }
]
```

Diff 2 file
=====
* Open a.txt
* Hit F1 -> Compare active file with -> Select b.txt
* Note that only b.txt can be modified

Typscript auto completion
=====
* Install DefinitelyTyped like this
* $ npm install --save-dev @types/d3
* Add the path to the first line of the .js file
```javascript
/// <reference path="/home/joeky/project/node_modules/@types/d3/index.d.ts" />
```

Golang auto completion
=====
* Install ms-vscode.go extension
* Install all recommend go packages from vscode-go
* Enable auto-save
