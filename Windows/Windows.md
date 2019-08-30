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
* Disable battery automatically sleeping -> Setting -> System -> Power & Sleep -> Sleep -> Never
* Disable animations in Windows
* Disable sleep when Lid closed
* Run Windows10Debloater.ps1
* Set system non-utf to big5
* Show hidden files and file name extensions
* Disable Sticky Keys by pressing shift key 5 times
* cmd.exe -> netplwiz -> User must enter a user name -> Uncheck
* Exclude cygwin path in anti-virus
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
```sh
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\\Desktop\\Powershell.lnk")
$Shortcut.TargetPath = "$env:SYSTEMROOT\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
$Shortcut.Save()
```

Install softwares
=====
* Scoop
```sh
Set-ExecutionPolicy RemoteSigned -Force
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop bucket add extras https://github.com/lukesampson/scoop-extras.git
scoop bucket add dorado https://github.com/h404bi/dorado
scoop install aria2 win32-openssh vim lazygit busybox qemu youtube-dl curl ffmpeg micro adb nmap go upx nodejs phantomjs mpv miniconda2 miniconda3

# "" means "(Default)" which equals to "@"
[Microsoft.Win32.Registry]::SetValue("HKEY_CLASSES_ROOT\*\shell\Edit with Gvim\command","","$env:USERPROFILE\scoop\apps\vim\current\gvim.exe -p --remote-tab-silent `"%1`"", [Microsoft.Win32.RegistryValueKind]::String)
[Microsoft.Win32.Registry]::SetValue("HKEY_CLASSES_ROOT\Applications\gvim.exe\shell\open\command","","$env:USERPROFILE\scoop\apps\vim\current\gvim.exe -p --remote-tab-silent `"%1`"", [Microsoft.Win32.RegistryValueKind]::String)
```
* Chocolatey
```sh
Set-ExecutionPolicy RemoteSigned -Force
Unblock-File $profile.CurrentUserAllHosts
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name DontUsePowerShellOnWinX -PropertyType DWord –Value 0 -force
PowerShellGet\Install-Module posh-git -Scope CurrentUser
PowerShellGet\Install-Module oh-my-posh -Scope CurrentUser
PowerShellGet\Install-Module posh-docker -Scope CurrentUser
PowerShellGet\Install-Module windows-screenfetch -Scope CurrentUser
choco install 7zip git poshgit openssl.light skype vscodium greenshot wps-office-free obs-studio nomacs fontforge sumatrapdf.commandline xnviewmp krita -y --pre
choco install directx vcredist2005 vcredist2008 vcredist2010 vcredist2012 vcredist2013 vcredist2015 vcredist2017 vcredist-all -y --pre
```
* Gaming dlls
    * $ choco install openal physx.legacy msxml6.sp1 gfwlive xna xna31 silverlight dotnet3.5 dotnet4.0 dotnet4.5 -y -pre

Git config
=====
* For Powershell
```sh
git config --system core.autocrlf false
git config --system core.fileMode false
```

Mono sound
=====
* Setting -> Ease of Access settings -> Other options -> Audio options -> Mono audio -> Check

Win8+ Set Powershell.exe to default shell to WinX
=====
* Control Panel -> Appearance and Personalization -> Taskbar and Navigation -> Navigation -> Coner navigation -> Check
* Or
* Setting -> Personalization -> Taskbar -> Replace cmd with Powershell in the menu -> Check

Add Control Panel to the WinX menu
=====
```sh
# Powershell
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:LocalAppdata\\Microsoft\\Windows\\WinX\\Group2\\4 - Control Panel.lnk")
$Shortcut.TargetPath = "%windir%\system32\control.exe"
$Shortcut.Arguments = "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}"
$Shortcut.Save()
```
* Or
* Open file explorer and go to %LocalAppdata%\Microsoft\Windows\WinX\Group2
* Create a shourtcut
    * Location "%windir%\system32\control.exe"
    * Name "4 - Control Panel.lnk"
* Reboot

Set MPV as default player
=====
* $ scoop install mpv
```sh
Set-ExecutionPolicy RemoteSigned -Force
$url = "https://raw.githubusercontent.com/rossy/mpv-install/master/mpv-install.bat"
$path = "$env:TEMP\mpv-install.bat"
(New-Object System.Net.WebClient).DownloadFile($url, $path)
$url = "https://raw.githubusercontent.com/rossy/mpv-install/master/mpv-document.ico"
$path = "$env:USERPROFILE\scoop\apps\mpv\current\mpv-document.ico"
(New-Object System.Net.WebClient).DownloadFile($url, $path)

Get-Content "$env:TEMP\mpv-install.bat" | Set-Content "$env:USERPROFILE\scoop\apps\mpv\current\mpv-install.bat"
cmd.exe /c $env:USERPROFILE\scoop\apps\mpv\current\mpv-install.bat

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\\Desktop\\mpv.lnk")
$Shortcut.TargetPath = "$env:USERPROFILE\\scoop\\apps\\mpv\\current\\mpv.exe"
$Shortcut.Save()
```

God mode
=====
* Rename an empty folder to "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"

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
