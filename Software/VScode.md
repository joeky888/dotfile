Setting (search `json`)
=====
* View -> Command Palette -> Search for "open settings (json)"
```js
{
    "editor.fontSize": 20,
    "editor.fontFamily": "'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', monospace",
    "terminal.integrated.fontFamily": "'Iosevka', 'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', monospace",
    "editor.wordWrap": "off",
    "editor.tabSize": 4,
    "editor.detectIndentation": true,
    "files.encoding": "utf8",
    "files.eol": "\r\n",
    "files.trimTrailingWhitespace": true,
    "files.autoSave": "afterDelay",
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
    "debug.console.fontFamily": "'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', monospace",
    "debug.console.fontSize": 20,
    "debug.internalConsoleOptions": "openOnSessionStart",
    "eslint.autoFixOnSave": true,
    "eslint.alwaysShowStatus": true,
    "[go]": {
        "editor.formatOnSave": true,
        "editor.tabSize": 8,
        "editor.insertSpaces": false,
        "files.eol": "\n"
    },
    "go.useLanguageServer": true,
    "go.languageServerExperimentalFeatures": {
            "diagnostics": true
    },
    "gopls": {
        "usePlaceholders": true
    },
    "[javascript]": {
        "editor.formatOnSave": true
    },
    "terminal.integrated.env.osx": {
      "VS_CODE": "true"
    },
    "terminal.integrated.env.linux": {
      "VS_CODE": "true"
    },
    "workbench.editor.tabSizing": "shrink",
    "workbench.colorCustomizations": {
      "terminal.background":"#090300",
      "terminal.foreground":"#A5A2A2",
      "terminalCursor.background":"#A5A2A2",
      "terminalCursor.foreground":"#A5A2A2",
      "terminal.ansiBlack":"#090300",
      "terminal.ansiBlue":"#01A0E4",
      "terminal.ansiBrightBlack":"#5C5855",
      "terminal.ansiBrightBlue":"#01A0E4",
      "terminal.ansiBrightCyan":"#B5E4F4",
      "terminal.ansiBrightGreen":"#01A252",
      "terminal.ansiBrightMagenta":"#A16A94",
      "terminal.ansiBrightRed":"#DB2D20",
      "terminal.ansiBrightWhite":"#F7F7F7",
      "terminal.ansiBrightYellow":"#FDED02",
      "terminal.ansiCyan":"#B5E4F4",
      "terminal.ansiGreen":"#01A252",
      "terminal.ansiMagenta":"#A16A94",
      "terminal.ansiRed":"#DB2D20",
      "terminal.ansiWhite":"#A5A2A2",
      "terminal.ansiYellow":"#FDED02"
    }
}
```

Extension
=====
* HookyQR.beautify
* hoovercj.vscode-power-mode
* ms-vscode.go
* eslint
* Markdown All in One (opt+shift+f to format tables)
* Gitlens

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
    { "key": "ctrl+p", "command": "editor.action.addSelectionToPreviousFindMatch" },
    { "key": "ctrl+q", "command": "editor.action.insertCursorBelow" },
    { "key": "ctrl+b", "command": "HookyQR.beautify",
        "when": "editorTextFocus" },
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
    { "key": "cmd+p", "command": "editor.action.addSelectionToPreviousFindMatch" },
    { "key": "cmd+q", "command": "editor.action.insertCursorBelow" },
    { "key": "cmd+b", "command": "HookyQR.beautify",
        "when": "editorTextFocus" }
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
