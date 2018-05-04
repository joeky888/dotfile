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
