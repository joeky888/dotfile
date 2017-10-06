#! /bin/bash

export SUDO=''
if (( $EUID != 0 )); then
  export SUDO='sudo'
fi

InstallDotfile()
{
  rm -rf $Home/dotfile
  git clone --depth=1 https://github.com/j16180339887/dotfile.git $Home/dotfile
  ln -sf $Home/dotfile/.bashrc ~/.bashrc
  ln -sf $Home/dotfile/.bashrc ~/.bash_profile
  ln -sf $Home/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf $Home/dotfile/.bashrc ~/.zshrc
  ln -sf $Home/dotfile/.vimrc ~/.vimrc
  ln -sf $Home/dotfile/.gitconfig ~/.gitconfig
  ln -sf $Home/dotfile/.fbtermrc ~/.fbtermrc
  ln -sf $Home/dotfile/.Xresources ~/.Xresources
  cd $Home/dotfile
  git submodule update --init --recursive
}

InstallDotfileCygwin()
{
  rm -rf $Home/dotfile
  git clone --depth=1 https://github.com/j16180339887/dotfile.git $Home/dotfile
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.bashrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.bash_profile"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.tmux.conf"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.zshrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.minttyrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.vimrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.gitconfig"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.Xresources"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.minttyrc" "%USERPROFILE%\dotfile\Windows\.minttyrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\.vimrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfile\.gitconfig"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.Xresources" "%USERPROFILE%\dotfile\.Xresources"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1" "%USERPROFILE%\dotfile\Windows\profile.ps1"
  cd $Home/dotfile
  git submodule update --init --recursive
}

InstallGRC()
{
  git clone --depth 1 https://github.com/garabik/grc.git grc && cd grc && $SUDO zsh install.sh && cd .. && rm -rf grc
}

InstallPy3UTF8()
{
  python3 <<END
import sys, os, site

pkgLocation = site.getsitepackages()
for location in pkgLocation:
  os.system(os.environ['SUDO'] + " install -D " + os.environ['Home'] + "/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
END
}

InstallPIP()
{
  curl 'https://bootstrap.pypa.io/get-pip.py' | $SUDO python3
  echo y | $SUDO pip install youtube-dl
  echo y | $SUDO pip install you-get
  echo y | $SUDO pip install bypy
}

InstallMinicondaLinux()
{
  rm -rf ~/Miniconda3 && aria2c 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh' && chmod 777 Miniconda3-latest-Linux-x86_64.sh && bash Miniconda3-latest-Linux-x86_64.sh -p ~/Miniconda3 -b -f && rm Miniconda3-latest-Linux-x86_64.sh
  echo y | ~/Miniconda3/bin/pip install youtube-dl
  echo y | ~/Miniconda3/bin/pip install you-get
  echo y | ~/Miniconda3/bin/pip install bypy
}


if [[ "$OSTYPE" == "linux-gnu" ]]; then # Ubuntu
  export Home="$HOME"
  $SUDO apt update
  $SUDO apt install tmux zsh git tig curl wget aria2 dnsutils python3 -y

  mkdir -p ~/.config/openbox
  InstallDotfile
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
  $SUDO apt-fast install p7zip-full p7zip-rar build-essential vim nano ffmpeg neofetch fontconfig -y
  $SUDO apt-fast install libssl-dev -y
  $SUDO aria2c https://raw.githubusercontent.com/j16180339887/CJK-font/master/DroidSansFallback.ttf --dir=/ -o usr/share/fonts/truetype/DroidSansFallback.ttf
  aria2c http://font.ubuntu.com/download/ubuntu-font-family-0.83.zip && 7z -o"ubuntu" x ubuntu-font-family-0.83.zip && $SUDO mv -v ubuntu /usr/share/fonts/truetype/Ubuntu && rm ubuntu-font-family*
  fc-cache -fv
  find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
  InstallMinicondaLinux
  InstallGRC
  InstallPy3UTF8






elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
  export SUDO=''
  export Home="$HOME"
  alias ls='ls -G'
  InstallDotfile
  InstallPIP
  InstallPy3UTF8
  InstallGRC




elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
  if [[ ! $(command -v aria2c) ]]; then
    echo "Please install aria2"
    exit 1
  fi
  export SUDO=''
  export Home=$(cygpath -u "$USERPROFILE")
  curl https://raw.githubusercontent.com/j16180339887/apt-cyg/master/apt-cyg > apt-cyg
  install apt-cyg /bin && rm apt-cyg
  aria2c 'https://cygwin.com/setup-x86_64.exe' && install setup-x86_64.exe /bin && rm setup-x86_64.exe
  apt-cyg install wget curl aria2 tar p7zip git tig openssh vim nano tmux zsh bind-utils
  InstallDotfileCygwin
  cygstart --action=runas cmd.exe /c RD /S /Q "%ALLUSERSPROFILE%\\chocolatey"
  cygstart --action=runas cmd.exe /c @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
  [[ "$PATH" != *"chocolatey/bin"* ]] && cygstart --action=runas cmd.exe /c "setlocal EnableDelayedExpansion & setx /M PATH \"%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin\""
  grep -q -F '/cygdrive/c/Users /home none bind 0 0' /etc/fstab || echo '/cygdrive/c/Users /home none bind 0 0' >> /etc/fstab
  grep -q -F 'none /tmp usertemp binary,posix=0 0 0' /etc/fstab || echo 'none /tmp usertemp binary,posix=0 0 0' >> /etc/fstab
  sed -i 's/.*db_shell.*/db_shell: \/bin\/zsh/' /etc/nsswitch.conf
  find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > $Home/.nanorc

  apt-cyg install procps fontconfig fontforge ghostscript ImageMagick make automake cmake gcc-core gcc-g++
  apt-cyg install cygwin-devel doxygen python3-devel openssl-devel libevent-devel libncurses-devel libncursesw-devel libtool yasm yasm-devel binutils diffutils dos2unix libfontconfig-devel libiconv-devel libass-devel fribidi libfribidi-devel libfreetype-devel libopenjpeg-devel libopus-devel libvorbis-devel libvpx-devel libwebp-devel libbz2-devel libffi-devel gettext-devel
  InstallPIP
  InstallGRC
  InstallPy3UTF8






elif [[ "$OSTYPE" == "msys" ]]; then # Msys
  export SUDO=''
  export Home="$HOME"
  pacman -Syu
  pacman -S zsh git vim curl wget base-devel msys2-devel mercurial cvs p7zip perl ruby python2 python3 mingw-w64-x86_64-toolchain
  InstallPIP
  InstallGRC
  InstallPy3UTF8





elif [[ "$OSTYPE" == "linux-android" ]]; then # Android Termux
  export SUDO=''
  export Home="$HOME"
  apt update && apt upgrade
  termux-setup-storage
  apt install -y clang man vim git tig zsh tmux curl aria2 openssh grep sed python ffmpeg p7zip util-linux neofetch python-dev libffi-dev openssl-dev
  InstallDotfile
  InstallPIP
  InstallPy3UTF8





elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
  export Home="$HOME"
  $SUDO pkg update
  echo y | $SUDO pkg install tmux zsh git vim nano curl python3 aria2 clang-devel autotools autoconf gmake cmake ubuntu-font
  chsh -s $(command -v zsh) $(whoami)
  find /usr/local/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
  InstallDotfile
  InstallPIP
  InstallGRC
  InstallPy3UTF8



else # Unknown OS
  echo "Unknown OS"
fi
