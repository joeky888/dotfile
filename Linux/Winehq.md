Install Wine
=====
* $ app-fast update
* $ app-fast install --install-recommends wine32-development wine32-development-preloader wine32-development-tools winbind cabextract zenity -y && winecfg-development
* Or
* $ sudo dpkg --add-architecture i386 && app-fast update
* $ app-fast install --install-recommends wine64-development wine64-development-preloader wine64-development-tools winbind cabextract zenity -y && winecfg-development
* Or
* $ `app-fast -Sy --needed expac` # To install optional dependencies of wine-staging
* $ `app-fast -S --needed wine-staging $(expac -S '%o' wine-staging) wine-mono wine-gecko cabextract zenity && winecfg`
    * winecfg -> Staging
        * Enable VAAPI as backend for DXVA2 GPU decoding -> check
        * Hide wine version from applications -> check
        * Enable GTK3 Theming -> check

Install CJK font
=====
1. manual
    * Install a Chinese input method on Linux
```sh
aria2c "https://github.com/joeky888/CJK-font/raw/master/wqy-microhei.ttc" -d / -o ~/.wine/drive_c/windows/Fonts/wqy-microhei.ttc && wine regedit ~/dotfile/Linux/cjk.reg
```
    * 如果想使用其它字體，也可直接將相應的ttf或ttc文件複製到~/.wine/drive\_c/windows/Fonts/，再用其文件名替換上面的wqy-zenhei.ttc即可
2. Using winetricks
    * $ export WINEARCH=win32
    * $ aria2c https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
    * $ sh winetricks wenquanyi
    * $ wine regedit ~/dotfile/Linux/cjk.reg

Install winetricks and winetricks packages
=====
* $ aria2c https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
* Don't track https://github.com/Winetricks/winetricks/blob/master/files/verbs/download.txt because it's outdated
* $ bash winetricks list-all
* $ bash winetricks busybox cmd 7zip lucida ie8 msxml3 msxml4 msxml6 xmllite d3dx9 d3dx10 d3dxof d3drm directmusic directplay quartz wininet xact xinput xna31 xna40 allcodecs
* $ bash winetricks vb6run vcrun2005 vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015
* $ bash winetricks dotnet20sp2 dotnet30sp1 dotnet35sp1 dotnet40 dotnet452 dotnet462 nuget
* Nvidia only
* $ bash winetricks physx
* Register all dlls
* $ wine cmd
```dosbatch
REM This will take a long time
for %1 in (%windir%\system32\*.dll) do regsvr32.exe /s %1
```
* Run DirectX Repair (Enhanced Edition) DirectX dll 修復工具增強版 https://blog.csdn.net/vbcom
* Run Microsoft .NET Framework Repair Tool
* Run Microsoft .NET Framework Cleanup Tool
* Install busybox
```sh
aria2c https://frippery.org/files/busybox/busybox.exe
wine busybox.exe ash -l
# Or
wine busybox.exe sh -l
```

Open cmd and run .bat file
=====
* $ wine cmd
* Or
* $ wineconsole --backend=curses
* Run .bat file

Install a .msi file
=====
* $ wine msiexec /i filename.msi
* Uninstall a .msi file
* $ wine msiexec /x filename.msi
* Show all environment variables
* cmd> set

Install a .msu file (Windows Update file)
=====
* $ wine wusa file.msu

Set environment variables
=====
* means system side variable
* $ export PYTHONIOENCODING="UTF-16"
* $ wine cmd

Tab completion
=====
* Cmd.exe tab completion isn't possible at this moment
* Use bash instead
* (X) cmd> python install.py
* (O) $ wine python install.py

Install mono or dotnet
=====
1. Using Linux Mono
    * $ app-fast install --install-recommends mono-complete mono-runtime -y
    * $ mono file.exe
2. Using winetricks dotnet
    * $ rm -rf ~/.wine
    * $ export WINEARCH=win32
    * $ winecfg # Configure OS
    * $ aria2c https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
    * $ sh winetricks dotnet462
    * $ sh winetricks xna40 # Optional
    * $ wine file.exe

Gaming performance
=====
* Disable wine debug messages
```sh
WINEDEBUG=-all wine game.exe
```

Install powershell 2
=====
* Use Windows XP
* $ export WINEARCH=win32
* $ bash winetricks -q msxml3 dotnet35sp1 lucida
* $ taskset -c 0 bash winetricks windowscodecs
* $ wine ./WindowsXP-KB968930-x86-ENG.exe
* $ wine powershell

Reboot wine
=====
* $ wineboot --restart

Troubleshooting
=====
* If winecfg/winecfg-development can not create ~/.wine/ successfully
    * $ export WINEARCH=win32
    * $ winecfg # Win7 is a good option
