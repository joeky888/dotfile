Install Wine
=====
* $ sudo apt-fast update
* $ sudo apt-fast install --install-recommends wine32-development-preloader winbind cabextract zenity -y
* Or
* $ sudo dpkg --add-architecture i386
* $ sudo apt-fast install --install-recommends wine64-development-preloader winbind cabextract zenity -y
* $ export WINEARCH=win32
* $ winecfg-development # Configure OS, Win7 is a good option
* DO NOT INSTALL winetricks

Install CJK font
=====
1. manual
    * Install a Chinese input method on Linux
```sh
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
* $ bash winetricks cjkfonts cmd corefonts 7zip vcrun2005 vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 vcrun2017 d3dx9 d3dx10 d3dxof d3drm allcodecs quartz wininet xact xinput
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
2. Using Wine Mono
    * $ sudo add-apt-repository ppa:ubuntu-wine/ppa -y
    * $ sudo apt-fast update
    * $ sudo apt-fast install --install-recommends wine-mono4.5.6
    * $ wine file.exe
3. Using winetricks dotnet
    * $ rm -rf ~/.wine
    * $ export WINEARCH=win32
    * $ winecfg # Configure OS
    * $ aria2c https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
    * $ sh winetricks dotnet462
    * $ sh winetricks xna40 # Optional
    * $ wine file.exe
4. Install dotnet from Microsoft
    * $ rm -rf ~/.wine
    * $ export WINEARCH=win32
    * $ winecfg # Select Win7
    * Download dotnet4.0 32bits from Microsoft
    * $ wine file.exe

Troubleshooting
=====
* If winecfg/winecfg-development can not create .wine/ successfully
    * $ export WINEARCH=win32
    * $ winecfg # Win7 is a good option
