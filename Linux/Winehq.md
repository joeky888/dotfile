Install without ppa
=====
* $ sudo apt-fast update
* $ sudo apt-fast install --install-recommends wine32-development-preloader winbind -y
* Or
* $ sudo apt-fast install --install-recommends wine64-development-preloader winbind -y
* $ export WINEARCH=win32
* $ winecfg-development # Configure OS, Win7 is a good option
* DO NOT INSTALL winetricks

Install from ppa
=====
* $ sudo add-apt-repository ppa:wine/wine-builds -y
* $ sudo apt-fast update
* $ sudo apt-fast install --install-recommends winehq-devel winbind -y
* $ winecfg # Configure OS

Install CJK font
=====
1. manual
    * Install a Chinese input method on Linux
```sh
aria2c "http://7xpdnl.dl1.z0.glb.clouddn.com/inziu-iosevka-1.13.3.7z" && 7z -o"inziu" x "inziu-iosevka-1.13.3.7z" && sudo cp -r inziu /usr/share/fonts/truetype && sudo fc-cache -f ; mv -f inziu/*  ~/.wine/drive_c/windows/Fonts/ && wine regedit ~/dotfile/Linux/cjk.reg && rm -rf inziu*
```
    * 如果想使用其它字體，也可直接將相應的ttf或ttc文件複製到~/.wine/drive\_c/windows/Fonts/，再用其文件名替換上面的wqy-zenhei.ttc即可
2. Using winetricks
    * $ export WINEARCH=win32
    * $ aria2c https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
    * $ sh winetricks wenquanyi
    * $ wine regedit ~/dotfile/Linux/cjk.reg

Open cmd and run .bat file
======
* $ wineconsole cmd
* Run .bat file

Install a .msi file
=====
* $ wine msiexec /i filename.msi

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
