$ lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
$ install apt-cyg /bin && rm apt-cyg
$ apt-cyg install wget curl tar p7zip git openssh sed wget vim tmux zsh make automake gcc-core gcc-g++
$ echo "/cygdrive/c/Users /home none bind 0 0" >> /etc/fstab
$ curl -LOC - "https://cygwin.com/setup-x86_64.exe" && install setup-x86_64.exe /bin && rm setup-x86_64.exe
$ alias upgradeCygwin="setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode"

# Install GUI desktop environment
$ apt-cyg install xorg-server xinit lxde-common
$ XWin :0 -clipboard -multiwindow
$ DISPLAY=:0.0 xterm
$ startlxde
# OR
$ DISPLAY=:0.0 startlxde