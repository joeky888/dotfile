Install Wine
=====
* $ sudo apt-fast update
* $ sudo apt-fast install --install-recommends wine32-development-preloader winbind cabextract zenity -y && winecfg-development
* Or
* $ sudo dpkg --add-architecture i386 && sudo apt-fast update
* $ sudo apt-fast install --install-recommends wine64-development-preloader winbind cabextract zenity -y && winecfg-development
* DO NOT INSTALL winetricks

Install CJK font
=====
1. manual
    * Install a Chinese input method on Linux
```sh
LANG="zh_TW.Big5" && LC_CTYPE="zh_TW.Big5" && LC_NUMERIC="zh_TW.Big5" && LC_TIME="zh_TW.Big5" && LC_COLLATE="zh_TW.Big5" && LC_MONETARY="zh_TW.Big5" && LC_MESSAGES="zh_TW.Big5" && LC_ALL="zh_TW.Big5"
aria2c "https://github.com/j16180339887/CJK-font/raw/master/wqy-microhei.ttc" -d / -o ~/.wine/drive_c/windows/Fonts/wqy-microhei.ttc && wine regedit ~/dotfile/Linux/cjk.reg
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
* See https://github.com/Winetricks/winetricks/blob/master/files/verbs/download.txt
* $ bash winetricks cmd 7zip vcrun2005 vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 d3dx9 d3dx10 d3dxof d3drm quartz wininet xact xinput
* Nvidia only
* $ bash winetricks physx

Open cmd and run .bat file
=====
* $ wineconsole cmd
* Run .bat file

Install a .msi file
=====
* $ wine msiexec /i filename.msi
* Uninstall a .msi file
* $ wine msiexec /x filename.msi

Install mono or dotnet
=====
1. Using Linux Mono
    * $ sudo apt-fast install --install-recommends mono-complete mono-runtime -y
    * $ mono file.exe
2. Using winetricks dotnet
    * $ rm -rf ~/.wine
    * $ export WINEARCH=win32
    * $ winecfg # Configure OS
    * $ aria2c https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
    * $ sh winetricks dotnet462
    * $ sh winetricks xna40 # Optional
    * $ wine file.exe

Troubleshooting
=====
* If winecfg/winecfg-development can not create ~/.wine/ successfully
    * $ export WINEARCH=win32
    * $ winecfg # Win7 is a good option
