Setting
=====
```json
{
    "editor.fontSize": 20,
    "editor.fontFamily": "'Ubuntu Mono', 'Droid Sans Fallback', 'Sarasa Mono TC', 'Consolas', 'NSimsun', monospace",
    "editor.wordWrap": "off",
    "editor.tabSize": 4,
    "files.encoding": "utf8",
    "files.eol": "\r\n",
    "files.trimTrailingWhitespace": true,
    "files.autoSave": "afterDelay",
    "powermode.enabled": true,
    "editor.minimap.enabled": true,
    "workbench.colorTheme": "Monokai Dimmed",
    "editor.mouseWheelZoom": true,
    "editor.cursorBlinking": "solid",
    "git.ignoreMissingGitWarning": true,
    "emmet.showSuggestionsAsSnippets": true,
    "editor.snippetSuggestions": "top",
    "terminal.integrated.fontSize": 18,
    "Enable Live-Share-Function": "This is a comming soon feature"
}
```

Extension
=====
* HookyQR.beautify
* hoovercj.vscode-power-mode

Key
=====
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
    { "key": "pageup", "command": "editor.action.moveLinesUpAction",
        "when": "editorTextFocus && !editorReadonly" },
    { "key": "pagedown","command": "editor.action.moveLinesDownAction",
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
    { "key": "ctrl+b", "command": "HookyQR.beautify",
        "when": "editorTextFocus" }
]
```

Diff 2 file
=====
* Open a.txt
* Hit F1 -> Compare active file with -> Select b.txt
* Note that only b.txt can be modified
