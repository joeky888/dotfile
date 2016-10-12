Install without ppa
=====
* $ sudo apt-get update
* $ sudo apt-get install --install-recommends wine32-development-preloader winbind -y
* Or
* $ sudo apt-get install --install-recommends wine64-development-preloader winbind -y
* $ export WINEARCH=win32
* $ winecfg-development # Configure OS, Win7 is a good option
* DO NOT INSTALL winetricks

Install from ppa
=====
* $ sudo add-apt-repository ppa:wine/wine-builds -y
* $ sudo apt-get update
* $ sudo apt-get install --install-recommends winehq-devel winbind -y
* $ winecfg # Configure OS

Install CJK font
=====
* Download wqy-zenhei.ttc and place it to ~/.wine/drive_c/windows/Fonts/
* Install a Chinese input method on Linux
* $ wine regedit ~/dotfile/Linux/cjk.reg
* 如果想使用其它字體，也可直接將相應的ttf或ttc文件複製到~/.wine/drive_c/windows/Fonts/，再用其文件名替換上面的wqy-zenhei.ttc即可

Install mono or dotnet
=====
1. Using Linux Mono
    * $ sudo apt-get install --install-recommends mono-complete mono-runtime -y
    * $ mono *.exe
2. Using Wine Mono
    * $ sudo add-apt-repository ppa:ubuntu-wine/ppa -y
    * $ sudo apt-get update
    * $ sudo apt-get install --install-recommends wine-mono4.5.6
    * $ wine *.exe
3. Using winetricks dotnet (Best way to go)
    * $ rm -rf ~/.wine
    * $ export WINEARCH=win32
    * $ winecfg # Configure OS
    * $ wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
    * $ sh winetricks dotnet46
    * $ sh winetricks xna40 # Optional
    * $ wine *.exe
    
Issues
=====
* If winecfg/winecfg-development can not create .wine/ successfully
    * $ export WINEARCH=win32
    * $ winecfg # Win7 is a good option
