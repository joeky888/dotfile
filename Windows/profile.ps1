# UTF8
[Console]::InputEncoding = [Text.UTF8Encoding]::UTF8
[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
# Python2 UTF8
$env:PYTHONIOENCODING = "UTF-8"
# Java UTF8
$env:JAVA_TOOL_OPTIONS = " -Dfile.encoding=UTF8 "

# Increase history size
$global:MaximumHistoryCount = 10000

# Increase history in console buffer
[Console]::BufferHeight = 20000

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
Set-PSReadlineKeyHandler -Chord Ctrl+K -Function DeleteLine
Set-PSReadlineKeyHandler -Chord Ctrl+Z -Function Undo
Set-PSReadlineKeyHandler -Chord Ctrl+Y -Function Redo
Set-PSReadlineKeyHandler -Chord Ctrl+Backspace -Function BackwardKillWord
Set-PSReadlineKeyHandler -Chord Shift+Insert -Function Paste
Set-PSReadlineKeyHandler -Chord Ctrl+T -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("Invoke-Item 'C:\Users\joeky\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk'")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
Set-PSReadlineKeyHandler -Chord Ctrl+L -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("clear")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# Set default starting path to USERPROFILE
Set-Location $env:USERPROFILE\\Desktop

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

# alias bash/zsh command
New-Alias which get-command
New-Alias grep select-string

# Command to upgrade all chocolatey packages
Function upgradeChoco {
  choco upgrade all -y --pre
}

# Command to upgrade all Conda packages
Function upgradeConda {
  conda update --all --yes
}
Function upgradePip {
  pip freeze -l > requirements.txt
  (Get-Content requirements.txt).replace('==', '>=') | Set-Content requirements.txt
  pip install -r requirements.txt --upgrade
  Remove-Item requirements.txt
  pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip
  pip install --upgrade https://github.com/requests/requests/archive/master.zip
}
Function upgradeProfile {
  curl https://raw.githubusercontent.com/j16180339887/dotfile/master/Windows/profile.ps1 -o ~/Documents/WindowsPowerShell/profile.ps1
}
Function gvim {
  $Commandvim = "C:\vim\vim80\gvim.exe"
  $Parmsvim = ""
  if ($args.count -gt 0) {
    $Parmsvim = "-p --remote-tab-silent $args"
    $Parmsvim = $Parmsvim.Split(" ")
  }
  & "$Commandvim" $Parmsvim
}

$env:DOWNLOADARGS="--continue=true --check-certificate=false --content-disposition-default-utf8=true --max-tries=0 --max-concurrent-downloads=1000 --max-connection-per-server=16 --split=16 --min-split-size=1M --bt-max-peers=0 --bt-request-peer-speed-limit=1M --seed-ratio=0"
Function aria2c {
  Invoke-Expression "aria2c.exe $env:DOWNLOADARGS '$args'"
}
Function youtube-dl {
  youtube-dl.exe -f "bestvideo[height<=1080][fps<=30]+bestaudio/best" --write-sub --sub-lang zh-TW,zh-Hant,zh-CN,zh-Hans,en,enUS,English --ignore-errors --external-downloader aria2c --external-downloader-args $env:DOWNLOADARGS '$args'
}
Function youtube-dl-mp3 {
  youtube-dl.exe --extract-audio --audio-format mp3 --write-sub --sub-lang zh-TW,zh-Hant,zh-CN,zh-Hans,en,enUS,English --ignore-errors --external-downloader aria2c --external-downloader-args $env:DOWNLOADARGS '$args'
}

# Add chocolatey packages to path
if($env:Path -NotLike "*C:\ProgramData\Miniconda3*") {
  # choco install miniconda3
  $env:Path += ";C:\ProgramData\Miniconda3"
  $env:Path += ";C:\ProgramData\Miniconda3\Scripts"
  Set-Alias pip3 C:\ProgramData\Miniconda3\Scripts\pip.exe
  Set-Alias conda3 C:\ProgramData\Miniconda3\Scripts\conda.exe
  Set-Alias python3 C:\ProgramData\Miniconda3\python.exe
}
if($env:Path -NotLike "*C:\ProgramData\Miniconda2*") {
  # choco install miniconda
  $env:Path += ";C:\ProgramData\Miniconda2"
  $env:Path += ";C:\ProgramData\Miniconda2\Scripts"
  Set-Alias pip2 C:\ProgramData\Miniconda2\Scripts\pip.exe
  Set-Alias conda2 C:\ProgramData\Miniconda2\Scripts\conda.exe
  Set-Alias python2 C:\ProgramData\Miniconda2\python.exe
}
if($env:Path -NotLike "*C:\GnuWin\bin*") {
  # choco install gnuwin
  $env:Path += ";C:\GnuWin\bin"
}
if($env:Path -NotLike "*C:\Program Files (x86)\Nmap*") {
  # choco install nmap
  $env:Path += ";C:\Program Files (x86)\Nmap"
}
if($env:Path -NotLike "*C:\zulu\bin*") {
  $env:Path += ";C:\zulu\bin"
}
$env:JAVA_HOME="C:\zulu"
