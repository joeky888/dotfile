# UTF8
[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

# Zsh-like completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Increase history size
$global:MaximumHistoryCount = 1000

# Disable beep
Set-PSReadlineOption -BellStyle None

# Bash-like keys
Set-PSReadlineOption -EditMode Emacs

# Theme
$Host.UI.RawUI.ForegroundColor = "Gray"
$Host.UI.RawUI.BackgroundColor = "Black"

Function Prompt {
  Write-Host "$env:username" -NoNewline -ForegroundColor Green
  Write-Host "@" -NoNewline
  Write-Host "$env:computername" -NoNewline -ForegroundColor Red
  Write-Host " " -NoNewline
  Write-Host "$PWD" -ForegroundColor Yellow
  Write-Host "$" -NoNewline
  Return " "
}

