Install without ppa
=====
* sudo apt-get update
* sudo apt-get install --install-recommends wine64-development wine64-development-tools wine64-development-preloader -y
* winecfg-development # Configure OS

Install from ppa
=====
* sudo add-apt-repository ppa:wine/wine-builds -y
* sudo apt-get update
* sudo apt-get install --install-recommends winehq-devel -y
* winecfg # Configure OS

Issues
=====
* If winecfg/winecfg-development can not create .wine/ successfully
    * $ export WINEARCH=win32
    * $ winecfg

Install CJK font
=====
* winetricks # Install wqy-microhei.ttc
* Install a Chinese input method on Linux
* Run $ wine regedit cjk.reg
* 如果想使用其它字體，也可直接將相應的ttf或ttc文件複製到~/.wine/drive_c/windows/Fonts/，再用其文件名替換上面的wqy-zenhei.ttc即可

Install Mono for dotnet
=====
1. Using Linux Mono
    * sudo apt-get install --install-recommends mono-complete mono-runtime -y
    * mono *.exe
2. Using Wine Mono
    * sudo add-apt-repository ppa:ubuntu-wine/ppa -y
    * sudo apt-get update
    * sudo apt-get install --install-recommends wine-mono4.5.6
    * wine *.exe
3. Using Wine32 Mono (Best way to go)
    * rm ~/.wine
    * export WINEARCH=win32
    * winetricks dotnet40
    * wine *.exe