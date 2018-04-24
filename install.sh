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
  ln -sf $Home/dotfile/.gitconfig ~/.gitconfig
  ln -sf $Home/dotfile/.gitmessage ~/.gitmessage
  ln -sf $Home/dotfile/.fbtermrc ~/.fbtermrc
  ln -sf $Home/dotfile/.pythonrc ~/.pythonrc
  ln -sf $Home/dotfile/.condarc ~/.condarc
  ln -sf $Home/dotfile/.Xresources ~/.Xresources
  ln -sf $Home/dotfile/.minttyrc ~/.minttyrc
  cd $Home/dotfile && git pull origin master && git submodule update --init --recursive --remote --merge && git submodule foreach git pull origin master && cd -
  mkdir -p $Home/.config/nvim/
  ln -sf $Home/dotfile/vimrc/.vimrc ~/.vimrc
  ln -sf $Home/dotfile/vimrc/.vimrc ~/.config/nvim/init.vim
}

InstallDotfileCygwin()
{
  rm -rf $Home/dotfile
  git clone --depth=1 https://github.com/j16180339887/dotfile.git $Home/dotfile
  mkdir -p $Home/Documents/WindowsPowerShell
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.bashrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.bash_profile"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.tmux.conf"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.zshrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.minttyrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.vimrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\AppData\Local\nvim\init.vim"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.pythonrc"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.gitconfig"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.gitmessage"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\.Xresources"
  cygstart --action=runas cmd.exe /c del "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.minttyrc" "%USERPROFILE%\dotfile\Windows\.minttyrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfile\.gitconfig"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitmessage" "%USERPROFILE%\dotfile\.gitmessage"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.pythonrc" "%USERPROFILE%\dotfile\.pythonrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.condarc" "%USERPROFILE%\dotfile\.condarc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.Xresources" "%USERPROFILE%\dotfile\.Xresources"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1" "%USERPROFILE%\dotfile\powershell\profile.ps1"
  cd $Home/dotfile && git pull origin master && git submodule update --init --recursive --remote --merge && git submodule foreach git pull origin master && cd -
  mkdir -p $Home/AppData/Local/nvim
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\vimrc\.vimrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\AppData\Local\nvim\init.vim" "%USERPROFILE%\dotfile\vimrc\.vimrc"
  cygstart --action=runas cmd.exe /c regedit /S "%USERPROFILE%\dotfile\install.reg"
}

InstallGRC()
{
  rm -rf grc
  git clone --depth 1 https://github.com/garabik/grc.git grc && cd grc && $SUDO zsh install.sh && cd ..
  rm -rf grc
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
  echo y | $SUDO pip install ykdl
  echo y | $SUDO pip install bypy
}

InstallMinicondaLinux()
{
  rm -rf ~/Miniconda2 && aria2c 'https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh' && chmod 777 Miniconda2-latest-Linux-x86_64.sh && bash Miniconda2-latest-Linux-x86_64.sh -p ~/Miniconda2 -b -f && rm Miniconda2-latest-Linux-x86_64.sh
  rm -rf ~/Miniconda3 && aria2c 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh' && chmod 777 Miniconda3-latest-Linux-x86_64.sh && bash Miniconda3-latest-Linux-x86_64.sh -p ~/Miniconda3 -b -f && rm Miniconda3-latest-Linux-x86_64.sh
  echo y | ~/Miniconda3/bin/pip install youtube-dl
  echo y | ~/Miniconda3/bin/pip install you-get
  echo y | ~/Miniconda3/bin/pip install ykdl
  echo y | ~/Miniconda3/bin/pip install bypy
}

InstallMinicondaMac()
{
  rm -rf ~/Miniconda3 && aria2c 'https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh' && chmod 777 Miniconda3-latest-MacOSX-x86_64.sh && bash Miniconda3-latest-MacOSX-x86_64.sh -p ~/Miniconda3 -b -f && rm Miniconda3-latest-MacOSX-x86_64.sh
  echo y | ~/Miniconda3/bin/pip install youtube-dl
  echo y | ~/Miniconda3/bin/pip install you-get
  echo y | ~/Miniconda3/bin/pip install ykdl
  echo y | ~/Miniconda3/bin/pip install bypy
}



if [[ "$OSTYPE" == "linux-gnu" ]]; then

  export Home="$HOME"
  if [[ $(command -v apt) ]]; then
    $SUDO apt update
    $SUDO apt install vim tmux zsh git curl aria2 bash-completion -y

  elif [[ $(command -v pacman) ]]; then
    $SUDO pacman -Sy vim tmux zsh git curl aria2 bash-completion powerpill yaourt --noconfirm --needed
    $SUDO sed -i '/XferCommand/d' /etc/pacman.conf
    $SUDO sed -i '/\[options\]/a XferCommand = aria2c -c -s16 -k1M -x16 --dir=/ -o %o %u' /etc/pacman.conf
    $SUDO sed -i 's/^python3/\/usr\/bin\/python3/' $(which powerpill)
  else
    echo "Distro does not support at this moment."
    exit 1
  fi
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
  if [[ $(command -v apt) ]]; then
    $SUDO install ~/dotfile/Linux/apt-fast /usr/bin/apt-fast
    $SUDO apt-fast install p7zip-full p7zip-rar build-essential command-not-found nano ffmpeg neofetch fontconfig traceroute glances dnsutils mtr-tiny rsync python3 wget tig -y
    $SUDO apt-fast install libssl-dev -y
  elif [[ $(command -v pacman) ]]; then
    $SUDO powerpill -S p7zip base-devel command-not-found nano ffmpeg neofetch fontconfig traceroute glances bind-tools rsync python3 wget tig --noconfirm --needed
  fi

  $SUDO aria2c https://raw.githubusercontent.com/j16180339887/CJK-font/master/DroidSansFallback.ttf --dir=/ -o usr/share/fonts/truetype/DroidSansFallback.ttf
  $SUDO aria2c https://raw.githubusercontent.com/j16180339887/CJK-font/master/UbuntuMono.ttf --dir=/ -o usr/share/fonts/truetype/UbuntuMono.ttf
  fc-cache -fv
  find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
  InstallMinicondaLinux
  InstallGRC
  InstallPy3UTF8








elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
  export Home="$HOME"
  export SUDO=""
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew install git vim ffmpeg aria2 tig tmux p7zip rsync mas grc qpdf
  brew cask install macvim iterm2
#   brew linkapps
  InstallMinicondaMac
  InstallDotfile
  InstallPy3UTF8




elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
  if [[ ! $(command -v aria2c) ]]; then
    echo "Please install aria2"
    exit 1
  fi
#   export SUDO='cygstart --action=runas "$@" '
  export SUDO=""
  export Home=$(cygpath -u "$USERPROFILE")
  if ! [[ $(command -v choco) ]]; then # Don't reinstall chocolatey
    cygstart --action=runas cmd.exe /c RD /S /Q "%ALLUSERSPROFILE%\\chocolatey"
    cygstart --action=runas cmd.exe /c @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    [[ "$PATH" != *"chocolatey/bin"* ]] && cygstart --action=runas cmd.exe /c "setlocal EnableDelayedExpansion & setx /M PATH \"%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin\""
  fi
  rm -rf /bin/apt-cyg
  rm -rf /bin/setup-x86_64.exe
  curl https://raw.githubusercontent.com/j16180339887/apt-cyg/master/apt-cyg -o /bin/apt-cyg && chmod 777 /bin/apt-cyg
  curl -LOC - 'https://cygwin.com/setup-x86_64.exe' && install setup-x86_64.exe /bin && rm setup-x86_64.exe
  apt-cyg install p7zip wget curl aria2 git vim nano tmux zsh
  InstallDotfileCygwin
  grep -q -F '/cygdrive/c/Users /home none bind 0 0' /etc/fstab || echo '/cygdrive/c/Users /home none bind 0 0' >> /etc/fstab
  grep -q -F 'none /tmp usertemp binary,posix=0 0 0' /etc/fstab || echo 'none /tmp usertemp binary,posix=0 0 0' >> /etc/fstab
  sed -i 's/.*db_shell.*/db_shell: \/bin\/zsh/' /etc/nsswitch.conf
  find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > $Home/.nanorc

  apt-cyg install openssh rsync bind-utils bash-completion tig tar python3
  apt-cyg install cygport procps fontconfig fontforge ghostscript ImageMagick make automake cmake gcc-core gcc-g++
  apt-cyg install cygwin-devel doxygen python3-devel openssl-devel libevent-devel libncurses-devel libncursesw-devel libtool yasm yasm-devel binutils diffutils dos2unix libfontconfig-devel libiconv-devel libass-devel fribidi libfribidi-devel libfreetype-devel libopenjpeg-devel libopus-devel libvorbis-devel libvpx-devel libwebp-devel libbz2-devel libffi-devel gettext-devel
  InstallPIP
  InstallGRC
  InstallPy3UTF8






elif [[ "$OSTYPE" == "msys" ]]; then # Msys
  export SUDO=''
  export Home="$HOME"
  pacman -R catgets libcatgets --noconfirm
  pacman -Sy zsh git vim curl wget bash-completion base-devel msys2-devel mercurial cvs p7zip perl ruby python2 python3 python3-pip --noconfirm --needed
#   sed -i '/XferCommand/d' /etc/pacman.conf
#   sed -i '/\[options\]/a XferCommand = /mingw64/bin/aria2c -c -s16 -k1M -x16 %u' /etc/pacman.conf
  sed -i '/./d' /etc/fstab
  echo 'C:/Users /home ntfs binary,noacl,auto 1 1' >> /etc/fstab
  echo 'none /tmp usertemp binary,posix=0 0 0' >> /etc/fstab
  pacman -S mingw-w64-x86_64-aria2 --noconfirm --needed
#   pacman -S mingw-w64-x86_64-toolchain --noconfirm
#   InstallGRC # Windows can not use python os.fork()
  InstallPy3UTF8





elif [[ "$OSTYPE" == "linux-android" ]]; then # Android Termux
  export SUDO=''
  export Home="$HOME"
  apt update && apt upgrade
  termux-setup-storage
  apt install -y clang man vim git tig zsh tmux curl aria2 rsync bash-completion openssh grep sed python ffmpeg p7zip util-linux ncurses-utils neofetch python-dev libffi-dev openssl-dev
  InstallDotfile
  InstallPIP
  InstallPy3UTF8





elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
  export Home="$HOME"
  $SUDO pkg update -f
  echo y | $SUDO pkg install tmux zsh git tig vim-lite nano curl python3 aria2 p7zip neofetch bind-tools
  chsh -s $(command -v zsh) $(whoami)
  find /usr/local/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
  InstallDotfile
  echo y | $SUDO pkg install coreutils bash-completion gcc binutils automake autogen autotools autoconf pkgconf libtool gmake ncurses cmake ubuntu-font
  InstallPIP
  InstallPy3UTF8
  InstallGRC
#   echo y | $SUDO pkg install clang-devel



else # Unknown OS
  echo "Unknown OS"
fi
