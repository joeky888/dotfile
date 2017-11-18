Install
====
```bash
curl -s https://raw.githubusercontent.com/j16180339887/dotfile/master/install.sh | bash
```

Install vimrc only
====
```sh
# Unix-like & Powershell: Use curl
curl https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc -o ~/.vimrc

# Unix-like: Use python2
python2 -c "import urllib;from os.path import expanduser; urllib.urlretrieve('https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc', expanduser('~') + '/.vimrc')"
# python2 -c "import urllib; print urllib.urlopen('https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc'.encode('UTF-8')).read()" > ~/.vimrc

# Unix-like: Use python3
python3 -c "import urllib.request;from os.path import expanduser; urllib.request.urlretrieve('https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc', expanduser('~') + '/.vimrc')"
# python3 -c "import urllib.request as ur; print (ur.urlopen('https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc').read().decode('utf-8'))" > ~/.vimrc

# Windows: Use cmd
C:\windows\explorer.exe https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc

# Windows: Use Powershell
Invoke-WebRequest "https://raw.githubusercontent.com/j16180339887/dotfile/master/.vimrc" -OutFile "$ENV:UserProfile\\.vimrc"
```

Features in vimrc
=====
* No plugins, just one file
* Fast
* Autocomplete
* 256-color Monokai theme
* Sans-serif mono font automatic detection (GUI)
* Extra menu items under Edit option (GUI)
* For vim beginners only

This vimrc is based on [MiniVim](https://github.com/sd65/MiniVim). It runs on both Vim>=7.4 and neovim even though

I am not a fan of neovim. I do not intend to release it to an extra public repo.

In case you are interested, the code is under Public-domain licence.

| Keys      | Action                                                | Description |
| --------- | ----------------------------------------------------- | ----------- |
| Ctrl A    | Move cursor to the beginning of the line              | |
| Ctrl E    | Move cursor to the end of the line                    | |
| Ctrl C    | Copy current line / Copy Selection                    | |
| Ctrl X    | Cut current line / Cut Selection                      | |
| Ctrl V    | Paste                                                 | |
| Ctrl D    | Duplicate current line                                | |
| Ctrl K    | Delete current line                                   | |
| Ctrl F    | Search                                                | Case insensitive  |
| /         | Search                                                | Case sensitive    |
| Ctrl R    | Replace                                               | Case sensitive    |
| Ctrl G    | Select all                                            | |
| Ctrl \\   | Comment/Uncomment	                                    | Depends on file type |
| Ctrl T    | New tab                                               | |
| Ctrl Z    | Undo                                                  | |
| Ctrl Y    | Redo                                                  | |
| Ctrl S    | Save                                                  | |
| Ctrl W    | Close                                                 | |
| Ctrl Q    | Visual-Block mode                                     | |
| \| (bar)  | Enter multiple-line editing from Visual-Block mode    | |
| Ctrl N    | Next word                                             | |
| Ctrl P    | Previous word                                         | |
| Ctrl U    | Jump multiple lines up                                | Depends on window size |
| Ctrl J    | Jump multiple lines down                              | Depends on window size |
| Ctrl →    | Next word                                             | |
| Ctrl ←    | Previous word                                         | |
| Ctrl ↑    | Jump multiple lines up                                | Depends on window size |
| Ctrl ↓    | Jump multiple lines down                              | Depends on window size |
| Alt →     | Next word                                             | In case Ctrl key is not working in terminal emulators |
| Alt ←     | Previous word                                         | |
| Alt ↑     | Jump multiple lines up                                | Depends on window size |
| Alt ↓     | Jump multiple lines down                              | Depends on window size |
| Ctrl B    | Delete a word backward                                | |
| Tab       | Indent                                                | |
| Shift Tab | Unindent                                              | |
| F2        | New tab                                               | Like Byobu |
| F3        | Move to next tab                                      | Like Byobu |
| F4        | Move to previous tab                                  | Like Byobu |
| F10       | Enable/Disable autocomplete                           | |
| PageUp    | Move current line / Selection up                      | |
| PageDown  | Move current line / Selection down                    | |
| Home      | Increase font size                                    | GUI only |
| End       | Decrease font size                                    | GUI only |
| Ctrl Backspace    |  Delete a word backward                       | |
| Alt  Backspace    |  Delete a word backward                       | In case Ctrl key is not working in terminal emulators |
| Ctrl Delete       |  Delete a word forward                        | |

## Extra commands (Most of them were added to the GUI Edit menu already)

| Command   | Action                                                    | Description |
| --------- | --------------------------------------------------------- | ----------- |
| OpenDroppedFiles      | Open multiple files to each tabs at one time  | |
| JsonBeautify          | Json file beautify                            | Require Python 2/3 |
| JsonMinify            | Json file minify                              | |
| XmlBeautify           | XML file beautify                             | |
| MergeToOneLine        | Merge selection to one single line            | |
| RemoveLeadingSpace    |                                               | |
| RemoveTrailingSpace   |                                               | |
| RemoveEmptyLines      |                                               | |
| ToggleCaseToUpper     | Toggle case from selection                    | |
| ToggleCaseToLower     | Toggle case from selection                    | |
| ReverseString         | Reverse selected string                       | |
| FastRender            | Disable everything which makes Vim slow       | |
| Split2Vertical        | Split window                                  | |
| Split3Vertical        |                                               | |
| Split2Horizontal      |                                               | |
| Split3Horizontal      |                                               | |
| Split4                |                                               | |
| SplitMoveRight        | Move window                                   | |
| SplitMoveLeft         |                                               | |
| SplitMoveUp           |                                               | |
| SplitMoveDown         |                                               | |
| SplitResizeRight      | Resize window                                 | |
| SplitResizeLeft       |                                               | |
| SplitResizeUp         |                                               | |
| SplitResizeDown       |                                               | |
| IndentSpace2          | 2 space indention                             | |
| IndentSpace4          | 4 space indention                             | |
| IndentSpace8          | 8 space indention                             | |
| IndentTab2            | 2 tab indention                               | |
| IndentTab4            | 4 tab indention                               | |
| IndentTab8            | 8 tab indention                               | |
| LineEndingUnix        | \\n line ending                               | |
| LineEndingDos         | \\r\\n line ending                            | |
| LineEndingMac         | \\r line ending                               | |
| EncodingUTF8          |                                               | |
| EncodingBig5          |                                               | |
| EncodingGBK           |                                               | |
| EncodingJapan         |                                               | |
| EncodingKorea         |                                               | |
| EncodingUTF16LE       |                                               | |
| EncodingUTF16BE       |                                               | |
| EncodingAnsi          |                                               | |
| Download              | Download a file from given URL                | |

Extra notes
=====
* There are some keys one should never map
    * Ctrl-I = Space in terminal
    * Ctrl-M = Enter in terminal
    * Ctrl-H = Backspace in terminal
    * Ctrl-[ = ESC in terminal
    * Ctrl-/ Vim doesn't support it
    * Ctrl-AnyNumberkeys Vim doesn't support it
    * More than three combination keys like Ctrl-Shift-S, terminals don't accept this
* An example setup should like this
```sh
# Add this to bash_profile, bashrc or zshrc
if [[ "$TERM" == "xterm"* ]]; then
  export TERM=xterm-256color
fi
stty -ixon -ixoff # In order to use Ctrl Q and ctrl S
stty lnext '^-' stop undef start undef -ixon # In order to use Ctrl V
```
