#! /bin/bash

export SUDO=''
if (( $EUID != 0 )); then
    export SUDO='sudo'
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then # Ubuntu
  $SUDO apt update
  $SUDO apt install tmux zsh git tig curl wget aria2 -y
  rm -rf ~/dotfile
  git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile
  cd ~/dotfile
  git submodule init
  git submodule update
  ln -sf ~/dotfile/.bashrc ~/.bashrc
  ln -sf ~/dotfile/.bashrc ~/.bash_profile
  ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf ~/dotfile/.bashrc ~/.zshrc
  ln -sf ~/dotfile/.vimrc ~/.vimrc
  ln -sf ~/dotfile/.gitconfig ~/.gitconfig
  ln -sf ~/dotfile/.fbtermrc ~/.fbtermrc
  ln -sf ~/dotfile/.Xresources ~/.Xresources
  mkdir -p ~/.config/openbox
  ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/rc.xml
  ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/lxqt-rc.xml
  ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/lxde-rc.xml
  ln -sf ~/dotfile/Linux/compton.conf ~/.config/compton.conf
  ln -sf ~/dotfile/Linux/Compton.desktop ~/.config/autostart/Compton.desktop
  $SUDO chsh -s $(command -v zsh) root
  $SUDO install ~/dotfile/Linux/reconnect /usr/bin/reconnect
  $SUDO chmod 755 /usr/bin/reconnect
  $SUDO install ~/dotfile/Linux/reconnect.service /lib/systemd/system/reconnect.service
  $SUDO chmod 755 /lib/systemd/system/reconnect.service
  $SUDO install ~/dotfile/Linux/sddm.conf /etc/sddm.conf
  $SUDO systemctl enable reconnect.service
  $SUDO desktop-file-install ~/dotfile/Linux/BaiduCloud.desktop
  $SUDO desktop-file-install ~/dotfile/Linux/gvim.desktop
  $SUDO install ~/dotfile/Linux/apt-fast /usr/bin/apt-fast
  $SUDO apt-fast install p7zip-full p7zip-rar build-essential vim nano ffmpeg chromium-codecs-ffmpeg-extra neofetch fontconfig compton gnome-terminal vim-gtk3 network-manager file-roller software-properties-kde baobab gnome-system-monitor gnome-disk-utility -y
  $SUDO apt-fast install libssl-dev -y
  $SUDO aria2c https://raw.githubusercontent.com/j16180339887/CJK-font/master/DroidSansFallback.ttf --dir=/ -o usr/share/fonts/truetype/DroidSansFallback.ttf
  aria2c http://font.ubuntu.com/download/ubuntu-font-family-0.83.zip && 7z x ubuntu-font-family-0.83.zip && $SUDO mv -v ubuntu-font-family-0.83 /usr/share/fonts/truetype/Ubuntu && rm ubuntu-font-family-0.83.zip
  fc-cache -fv
  find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
  rm -rf ~/Miniconda3 && aria2c 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh' && chmod 777 Miniconda3-latest-Linux-x86_64.sh && bash Miniconda3-latest-Linux-x86_64.sh -p ~/Miniconda3 -b -f && rm Miniconda3-latest-Linux-x86_64.sh
  echo y | ~/Miniconda3/bin/pip install youtube-dl
  echo y | ~/Miniconda3/bin/pip install you-get
  echo y | ~/Miniconda3/bin/pip install bypy
  git clone --depth 1 https://github.com/garabik/grc.git grc && cd grc && $SUDO sh install.sh && cd .. && rm -rf grc
python3 <<END
import sys, os, site

pkgLocation = site.getsitepackages()
for location in pkgLocation:
  os.system(os.environ['SUDO'] + " install -D ~/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
END





elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
  alias ls='ls -G'
  rm -rf ~/dotfile
  git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile
  cd ~/dotfile
  git submodule init
  git submodule update
  ln -sf ~/dotfile/.bashrc ~/.bashrc
  ln -sf ~/dotfile/.bashrc ~/.bash_profile
  ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf ~/dotfile/.bashrc ~/.zshrc
  ln -sf ~/dotfile/.vimrc ~/.vimrc
  ln -sf ~/dotfile/.gitconfig ~/.gitconfig
  ln -sf ~/dotfile/.Xresources ~/.Xresources




elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
  if [[ ! $(command -v aria2c) ]]; then
    echo "Please install aria2"
    exit 1
  fi
  curl https://raw.githubusercontent.com/j16180339887/apt-cyg/master/apt-cyg > apt-cyg
  install apt-cyg /bin && rm apt-cyg
  curl -LOC - 'https://cygwin.com/setup-x86_64.exe' && install setup-x86_64.exe /bin && rm setup-x86_64.exe
  apt-cyg install wget curl aria2 tar p7zip git tig openssh vim nano tmux zsh procps fontconfig fontforge ghostscript ImageMagick make automake cmake gcc-core gcc-g++
  apt-cyg install cygwin-devel python3-devel openssl-devel libevent-devel libncurses-devel libncursesw-devel libtool yasm yasm-devel binutils diffutils dos2unix libfontconfig-devel libiconv-devel libass-devel fribidi libfribidi-devel libfreetype-devel libopenjpeg-devel libopus-devel libvorbis-devel libvpx-devel libwebp-devel libbz2-devel libffi-devel gettext-devel
  grep -q -F '/cygdrive/c/Users /home none bind 0 0' /etc/fstab || echo '/cygdrive/c/Users /home none bind 0 0' >> /etc/fstab
  grep -q -F 'none /tmp usertemp binary,posix=0 0 0' /etc/fstab || echo 'none /tmp usertemp binary,posix=0 0 0' >> /etc/fstab
  find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
  curl 'https://bootstrap.pypa.io/get-pip.py' | python3
  echo y | pip install youtube-dl
  echo y | pip install you-get
  echo y | pip install bypy
  rm -rf ~/dotfile
  git clone --depth=1 https://github.com/j16180339887/dotfile.git $USERPROFILE/dotfile
  cd $USERPROFILE/dotfile
  git submodule init
  git submodule update
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.bashrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.bash_profile"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.tmux.conf"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.zshrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.minttyrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.vimrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.gitconfig"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.minttyrc" "%USERPROFILE%\dotfile\Windows\.minttyrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\.vimrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfile\.gitconfig"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.Xresources" "%USERPROFILE%\dotfile\.Xresources"
  cygstart --action=runas cmd.exe /c RD /S /Q "%ALLUSERSPROFILE%\\chocolatey"
  cygstart --action=runas cmd.exe /c @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
  cygstart --action=runas cmd.exe /c "setlocal EnableDelayedExpansion & setx /M PATH \"%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin\""

  git clone --depth 1 https://github.com/garabik/grc.git grc
  cd grc
  sh install.sh
  cd ..
  rm -rf grc
python3 <<END
import sys, os, site

pkgLocation = site.getsitepackages()
for location in pkgLocation:
  os.system("install -D ~/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
END





elif [[ "$OSTYPE" == "msys" ]]; then # Msys
  pacman -Syu
  pacman -S zsh git vim curl wget base-devel msys2-devel mercurial cvs p7zip perl ruby python2 python3 mingw-w64-x86_64-toolchain
  curl 'https://bootstrap.pypa.io/get-pip.py' | python3
  echo y | pip install youtube-dl
  echo y | pip install you-get
  echo y | pip install bypy
python3 <<END
import sys, os, site

pkgLocation = site.getsitepackages()
for location in pkgLocation:
  os.system("install -D ~/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
END





elif [[ "$OSTYPE" == "linux-android" ]]; then # Android Termux
  apt update && apt upgrade
  termux-setup-storage
  apt install -y clang man vim git tig zsh tmux curl aria2 openssh grep sed python ffmpeg p7zip util-linux neofetch python-dev libffi-dev openssl-dev
  rm -rf ~/dotfile
  git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile
  cd ~/dotfile
  git submodule init
  git submodule update
  ln -sf ~/dotfile/.bashrc ~/.bashrc
  ln -sf ~/dotfile/.bashrc ~/.bash_profile
  ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf ~/dotfile/.bashrc ~/.zshrc
  ln -sf ~/dotfile/.vimrc ~/.vimrc
  ln -sf ~/dotfile/.gitconfig ~/.gitconfig
  curl 'https://bootstrap.pypa.io/get-pip.py' | python3
  echo y | pip install youtube-dl
  echo y | pip install you-get
  echo y | pip install bypy

  python3 <<END
import sys, os, site

pkgLocation = site.getsitepackages()
for location in pkgLocation:
  os.system("install -D ~/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
END





elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
  $SUDO pkg update
  echo y | $SUDO pkg install tmux zsh git vim nano curl ubuntu-font
  chsh -s $(command -v zsh) $(whoami)
  find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
  rm -rf ~/dotfile
  git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile
  cd ~/dotfile
  git submodule init
  git submodule update
  ln -sf ~/dotfile/.bashrc ~/.bashrc
  ln -sf ~/dotfile/.bashrc ~/.bash_profile
  ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf ~/dotfile/.bashrc ~/.zshrc
  ln -sf ~/dotfile/.vimrc ~/.vimrc
  ln -sf ~/dotfile/.gitconfig ~/.gitconfig
  ln -sf ~/dotfile/.Xresources ~/.Xresources
  curl 'https://bootstrap.pypa.io/get-pip.py' | python3
  echo y | pip install youtube-dl
  echo y | pip install you-get
  echo y | pip install bypy

  git clone --depth 1 https://github.com/garabik/grc.git grc
  cd grc
  $SUDO sh install.sh
  cd ..
  rm -rf grc
python3 <<END
import sys, os, site

pkgLocation = site.getsitepackages()
for location in pkgLocation:
  os.system("install -D ~/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
END



else # Unknown OS
  echo "Unknown OS"
fi
