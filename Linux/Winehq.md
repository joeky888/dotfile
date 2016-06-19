Install
=====
* sudo add-apt-repository ppa:wine/wine-builds -y
* sudo apt-get update
* sudo apt-get install --install-recommends winehq-devel -y
* winecfg # Configure OS
* winetricks # Install wqy-microhei.ttc

Install CJK font
=====
* Install a Chinese input method on Linux
* Using Winetricks install wqy-microhei.ttc 
* Run $ wine regedit cjk.reg
* 如果想使用其它字體，也可直接將相應的ttf或ttc文件複製到~/.wine/drive_c/windows/Fonts/，再用其文件名替換上面的wqy-zenhei.ttc即可