[
  {
    "context": "Editor",
    "bindings": {
      "cmd-d": "editor::DuplicateLineDown",
      "cmd-q": "editor::AddSelectionBelow",
      "cmd-u": "editor::MoveLineUp",
      "cmd-j": "editor::MoveLineDown",
      "cmd-a": "editor::MoveToBeginningOfLine",
      "cmd-e": "editor::MoveToEndOfLine",
      "cmd-k": "editor::DeleteLine",
      "cmd-up": "editor::MovePageUp",
      "cmd-down": "editor::MovePageDown",
      "cmd-t": "workspace::NewFile",
      "cmd-p": ["editor::SelectPrevious", { "replace_newest": false }],
      "cmd-n": ["editor::SelectNext", { "replace_newest": false }], // Add selection to Next Find Match
      "cmd-g": "editor::SelectAll",
      "cmd-f": [
        "buffer_search::Deploy",
        {
          "focus": true,
        }
      ],
      "cmd-r": "search::ToggleReplace",
      "cmd-z": "editor::Undo",
      "cmd-y": "editor::Redo"
    }
  }
]
