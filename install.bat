del "%USERPROFILE%\.bashrc"
del "%USERPROFILE%\.bash_profile"
del "%USERPROFILE%\.tmux.conf"
del "%USERPROFILE%\.zshrc"
del "%USERPROFILE%\.minttyrc"
del "%USERPROFILE%\.vimrc"
del "%USERPROFILE%\.gitconfig"

mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
mklink "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bash_profile"
mklink "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
mklink "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.zshrc"
mklink "%USERPROFILE%\.minttyrc" "%USERPROFILE%\dotfile\Windows\.minttyrc"
mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\.vimrc"
mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfile\.gitconfig"

pause
