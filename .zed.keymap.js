[
  {
    "context": "Editor",
    "bindings": {
      "cmd-d": "editor::DuplicateLine",
      "cmd-q": "editor::AddSelectionBelow",
      "cmd-u": "editor::MoveLineUp",
      "cmd-j": "editor::MoveLineDown",
      "cmd-a": "editor::MoveToBeginningOfLine",
      "cmd-e": "editor::MoveToEndOfLine",
      "cmd-k": "editor::DeleteLine",
      "cmd-up": "editor::MovePageUp",
      "cmd-down": "editor::MovePageDown",
      "cmd-t": "workspace::NewFile",
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
