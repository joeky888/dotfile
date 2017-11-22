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
* Disable battery automatically sleeping
* Disable animations in Windows
* cmd.exe -> netplwiz -> User must enter a user name -> Uncheck

Win8+ Set Powershell.exe to default shell to WinX
=====
* Control Panel -> Appearance and Personalization -> Taskbar and Navigation -> Navigation -> Coner navigation -> Check
* Or
* Setting -> Personalization -> Taskbar -> Replace cmd with Powershell in the menu -> Check

Add Control Panel to the WinX menu
=====
* Open file explorer and go to %LocalAppdata%\Microsoft\Windows\WinX\Group2
* Create a shourtcut
    * Location "%windir%\system32\control.exe"
    * Name "4 - Control Panel.lnk"
* Reboot

God mode
=====
* Rename an empty folder to "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
