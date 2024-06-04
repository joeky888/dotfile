Pre-install
=====
* rufus
* Windows.iso
* wi-fi drivers (optional)

Post-install
=====
* Install wi-fi drivers (optional)
* Install choco
* Install Sarasa Mono TC, Ubuntu mono and Droid Mono fonts
* Install Media Feature Pack
  *  Settings > Apps > Apps and Features > Optional features > Add a feature. Find the "Media Feature Pack"
* Disable battery automatically sleeping -> Setting -> System -> Power & Sleep -> Sleep -> Never
* Disable animations in Windows
* Disable sleep when Lid closed
* Run Windows10Debloater.ps1
* Set system non-utf to big5
* Show hidden files and file name extensions
* File Explorer -> Options -> General -> Privacy
  * Show recently used files -> Uncheck
  * Show frequently used folders -> Uncheck
  * Clear File Explorer history -> Clear
* Disable Sticky Keys by pressing shift key 5 times
* cmd.exe -> netplwiz -> User must enter a user name -> Uncheck
* Exclude cygwin path in anti-virus
* Settings -> Personalization -> Colors -> Custom color -> Select black color
* Settings -> Virus & threat protection settings > Manage settings > Exclusions > Add "D:" and "C:\Users\Name"
* DNS server
```resolv
nameserver 8.8.4.4
nameserver 180.76.76.76
nameserver 8.8.8.8
nameserver 114.114.114.114
```

Powershell Monokai theme
=====
* Execute ~/dotfile/install.reg first
* Execute this powershell script
```ps1
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\\Desktop\\Powershell.lnk")
$Shortcut.TargetPath = "$env:SYSTEMROOT\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
$Shortcut.Save()
```

Install softwares
=====
* Scoop
```ps1
Set-ExecutionPolicy RemoteSigned -Force
iex (New-Object System.Net.WebClient).downloadstring('https://get.scoop.sh')
scoop bucket add extras
scoop config aria2-enabled true
scoop config aria2-retry-wait 3
scoop config aria2-split 8
scoop config aria2-max-connection-per-server 8
scoop config aria2-min-split-size 1M
scoop config aria2-options "--continue=true --timeout=12 --connect-timeout=12 --content-disposition-default-utf8=true --check-certificate=false --max-tries=50 --max-concurrent-downloads=150 --max-connection-per-server=16 --split=16 --min-split-size=1M --http-accept-gzip=true --parameterized-uri=false"
# scoop bucket add dorado https://github.com/chawyehsu/dorado
scoop bucket add nerd-fonts
scoop install CascadiaCode-NF UbuntuMono-NF # Then set powershell to use this font
scoop install twemoji-color-font # MPV uses this font
scoop install Noto-CJK-Mega-OTC # Browsers font set to "Noto Sans CJK"
scoop install aria2 fd ripgrep erdtree neovim curl ffmpeg mpv-git adb go upx nodejs-lts phantomjs miniconda3 wezterm rustup gitui fastfetch bottom starship blender
Set the wezterm desktop shortcut target to 'C:\Users\joeky\scoop\apps\wezterm\current\wezterm-gui.exe start -- powershell.exe'

# "" means "(Default)" which equals to "@"
[Microsoft.Win32.Registry]::SetValue("HKEY_CLASSES_ROOT\*\shell\Edit with Neovim\command","","$env:USERPROFILE\scoop\apps\neovim\current\bin\nvim-qt.exe `"%1`"", [Microsoft.Win32.RegistryValueKind]::String)
# [Microsoft.Win32.Registry]::SetValue("HKEY_CLASSES_ROOT\Applications\gvim.exe\shell\open\command","","$env:USERPROFILE\scoop\apps\neovim\current\bin\nvim-qt.exe -p --remote-tab-silent `"%1`"", [Microsoft.Win32.RegistryValueKind]::String)
```
* Chocolatey
```ps1
Set-ExecutionPolicy RemoteSigned -Force
Unblock-File $profile.CurrentUserAllHosts
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name DontUsePowerShellOnWinX -PropertyType DWord –Value 0 -force
PowerShellGet\Install-Module posh-git -Scope CurrentUser
PowerShellGet\Install-Module oh-my-posh -Scope CurrentUser
PowerShellGet\Install-Module posh-docker -Scope CurrentUser
PowerShellGet\Install-Module windows-screenfetch -Scope CurrentUser
choco install onefetch cascadiamonopl 7zip-zstd git poshgit openssl.light skype vscode greenshot wps-office-free obs-studio nomacs fontforge sumatrapdf.commandline xnviewmp krita brave discord messenger -y
choco install directx vcredist2005 vcredist2008 vcredist2010 vcredist2012 vcredist2013 vcredist2015 vcredist2017 vcredist-all -y
```
* Gaming dlls
  * $ choco install openal physx.legacy msxml6.sp1 gfwlive xna xna31 silverlight dotnet3.5 dotnet4.0 dotnet4.5 -y

Git config
=====
* For Powershell
```sh
git config --system core.autocrlf false
git config --system core.fileMode false
```

Install alacritty to use Cygwin
=====
* $ choco install alacritty -y
* Edit shortcut on the Desktop
  * C:\ProgramData\alacritty\alacritty.exe --command C:\cygwin64\bin\bash.exe --login -i

Mono sound
=====
* Setting -> Ease of Access settings -> Other options -> Audio options -> Mono audio -> Check

Set MPV as default player
=====
* $ scoop install mpv
```ps1
Set-ExecutionPolicy RemoteSigned -Force
$url = "https://raw.githubusercontent.com/rossy/mpv-install/master/mpv-install.bat"
$path = "$env:TEMP\mpv-install.bat"
(New-Object System.Net.WebClient).DownloadFile($url, $path)
$url = "https://raw.githubusercontent.com/rossy/mpv-install/master/mpv-document.ico"
$path = "$env:USERPROFILE\scoop\apps\mpv-git\current\installer\mpv-icon.ico"
(New-Object System.Net.WebClient).DownloadFile($url, $path)

Get-Content "$env:TEMP\mpv-install.bat" | Set-Content "$env:USERPROFILE\scoop\apps\mpv\current\mpv-install.bat"
cmd.exe /c $env:USERPROFILE\scoop\apps\mpv-git\current\installer\mpv-install.bat

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\\Desktop\\mpv.lnk")
$Shortcut.TargetPath = "$env:USERPROFILE\\scoop\\apps\\mpv-git\\current\\mpv.exe"
$Shortcut.Save()
```

God mode
=====
* Rename an empty folder to "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"

Multiple desktop
=====
* win+tab to create new a desktop
* ctrl+win+left/right to switch between desktops

Delete a Disk partition
=====
* Open powershell as admin, run `diskpart`
* `list disk` to list all disks
* `select disk n` to select nth disk
* `list partition` to list all partitions
* `select partition n` to select nth partition
* `delete partition override` to remove current selection

Delete an UEFI boot option
=====
* Open cmd (not powershell) as admin
```dosbatch
:: List all boot options
bcdedit /enum firmware
:: It will produce a list of all entries in the BCD store. Export the list
bcdedit /export newbcd
:: and make a backup copy just in case.
copy newbcd bcdbackup
:: Now copy and paste the IDs of the unused entries and delete them one at a time by this command.
bcdedit /store newbcd /delete {….-….-….}
:: After you removed all unwanted, save the file with this command.
bcdedit /import newbcd /clean
:: That’s it. You won’t see those entries anymore on next reboot.
```
