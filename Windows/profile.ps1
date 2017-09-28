# Zsh-like completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Increase history size
$global:MaximumHistoryCount = 1000

# Disable beep
Set-PSReadlineOption -BellStyle None

# Bash-like keys
Set-PSReadlineOption -EditMode Emacs

# Theme
Function Prompt {
  Write-Host "$env:username" -NoNewline -ForegroundColor Green
  Write-Host "@" -NoNewline
  Write-Host "$env:computername" -NoNewline -ForegroundColor Red
  Write-Host " " -NoNewline
  Write-Host "$PWD" -ForegroundColor Yellow
  Write-Host "$" -NoNewline
  Return " "
}

