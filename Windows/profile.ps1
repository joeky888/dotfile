# UTF8
[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

# Increase history size
$global:MaximumHistoryCount = 1000

# Disable beep
Set-PSReadlineOption -BellStyle None

# Bash-like keys
Set-PSReadlineOption -EditMode Emacs

# Zsh-like completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Key mappings
Set-PSReadlineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Chord Ctrl+RightArrow -Function ForwardWord
Set-PSReadlineKeyHandler -Chord Ctrl+LeftArrow  -Function BackwardWord
Set-PSReadlineKeyHandler -Chord Ctrl+X -Function Cut
Set-PSReadlineKeyHandler -Chord Ctrl+V -Function Paste
Set-PSReadlineKeyHandler -Chord Ctrl+G -Function SelectAll
Set-PSReadlineKeyHandler -Chord Ctrl+Z -Function Undo
Set-PSReadlineKeyHandler -Chord Ctrl+Y -Function Redo
Set-PSReadlineKeyHandler -Chord Ctrl+Backspace -Function BackwardKillWord

# Set default starting path to USERPROFILE
Set-Location $env:USERPROFILE

# Theme
$Host.UI.RawUI.ForegroundColor = "Gray"
$Host.UI.RawUI.BackgroundColor = "Black"
Set-PSReadlineOption -TokenKind command   -ForegroundColor Green
Set-PSReadlineOption -TokenKind none      -ForegroundColor Red
Set-PSReadlineOption -TokenKind variable  -ForegroundColor White
Set-PSReadlineOption -TokenKind string    -ForegroundColor Yellow
Set-PSReadlineOption -TokenKind number    -ForegroundColor White

Function Prompt {
  Write-Host "$env:username" -NoNewline -ForegroundColor Red
  Write-Host "@" -NoNewline
  Write-Host "$env:computername" -NoNewline -ForegroundColor Green
  Write-Host " " -NoNewline
  Write-Host "$PWD" -ForegroundColor Yellow
  Write-Host "$" -NoNewline
  Return " "
}

# Command to upgrade all chocolatey packages
Function upgradeChoco {
  choco upgrade all -y --pre
}

# Command to upgrade all Conda packages
Function upgradeConda {
  conda update --all --yes
}


# Add chocolatey packages to path
if($env:Path -NotLike "*C:\ProgramData\Miniconda3*") {
  $env:Path += ";C:\ProgramData\Miniconda3"
  $env:Path += ";C:\ProgramData\Miniconda3\Scripts"
  Set-Alias pip3 C:\ProgramData\Miniconda3\Scripts\pip.exe
  Set-Alias conda3 C:\ProgramData\Miniconda3\Scripts\conda.exe
  Set-Alias python3 C:\ProgramData\Miniconda3\python.exe
}
if($env:Path -NotLike "*C:\ProgramData\Miniconda2*") {
  $env:Path += ";C:\ProgramData\Miniconda2"
  $env:Path += ";C:\ProgramData\Miniconda2\Scripts"
  Set-Alias pip2 C:\ProgramData\Miniconda2\Scripts\pip.exe
  Set-Alias conda2 C:\ProgramData\Miniconda2\Scripts\conda.exe
  Set-Alias python2 C:\ProgramData\Miniconda2\python.exe
}
if($env:Path -NotLike "*C:\GnuWin\bin*") {
  $env:Path += ";C:\GnuWin\bin"
}
