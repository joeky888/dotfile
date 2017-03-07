#!/bin/sh

if [[ "$OSTYPE" == "linux-gnu" ]]; then # Ubuntu
  sudo apt-get update
  sudo apt-get install tmux zsh git curl wget p7zip-full p7zip-rar build-essential vim ffmpeg ttf-ubuntu-font-family fonts-droid-fallback fontconfig vim-gtk3 network-manager file-roller software-properties-kde baobab gnome-system-monitor gnome-disk-utility -y
  rm -rf ~/dotfile
  rm -rf ~/.oh-my-zsh
  git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  git config --global core.editor vim
  ln -sf ~/dotfile/.bashrc ~/.bashrc
  ln -sf ~/dotfile/.bash_profile ~/.bash_profile
  ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf ~/dotfile/.zshrc ~/.zshrc
  ln -sf ~/dotfile/.vimrc ~/.vimrc
  ln -sf ~/dotfile/.gitconfig ~/.gitconfig
  ln -sf ~/dotfile/.fbtermrc ~/.fbtermrc
  mkdir -p ~/.config/openbox
  ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/rc.xml
  ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/lxqt-rc.xml
  ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/lxde-rc.xml
  sudo ln -sf ~/dotfile/.vimrc /root/.vimrc
  sudo ln -sf ~/dotfile/.bash_profile /root/.bash_profile
  sudo ln -sf ~/dotfile/.bashrc /root/.bashrc
  sudo ln -sf ~/dotfile/.zshrc /root/.zshrc
  sudo rm -rf /root/.oh-my-zsh
  sudo git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh
  sudo chsh -s $(command -v zsh) root
  sudo install ~/dotfile/Linux/reconnect /usr/bin/reconnect
  sudo chmod 755 /usr/bin/reconnect
  sudo install ~/dotfile/Linux/reconnect.service /lib/systemd/system/reconnect.service
  sudo chmod 755 /lib/systemd/system/reconnect.service
  sudo install ~/dotfile/Linux/sddm.conf /etc/sddm.conf
  sudo systemctl enable reconnect.service
  sudo desktop-file-install ~/dotfile/Linux/BaiduCloud.desktop
  sudo desktop-file-install ~/dotfile/Linux/gvim.desktop
  curl -LOC - 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh'
  chmod 777 Miniconda3-latest-Linux-x86_64.sh
  ./Miniconda3-latest-Linux-x86_64.sh -p ~/Miniconda3 -b -f
  rm Miniconda3-latest-Linux-x86_64.sh
  echo y | ~/Miniconda3/bin/pip install youtube-dl
  echo y | ~/Miniconda3/bin/pip install you-get
python3 <<END
import sys, os, site

pkgLocation = site.getsitepackages()
for location in pkgLocation:
  os.system("sudo install -D ~/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
END





elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
  alias ls='ls -G'
  rm -rf ~/dotfile
  rm -rf ~/.oh-my-zsh
  git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  git config --global core.editor vim
  ln -sf ~/dotfile/.bashrc ~/.bashrc
  ln -sf ~/dotfile/.bash_profile ~/.bash_profile
  ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf ~/dotfile/.zshrc ~/.zshrc
  ln -sf ~/dotfile/.vimrc ~/.vimrc
  ln -sf ~/dotfile/.gitconfig ~/.gitconfig




elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
  curl https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
  install apt-cyg /bin && rm apt-cyg
  curl -LOC - 'https://cygwin.com/setup-x86_64.exe' && install setup-x86_64.exe /bin && rm setup-x86_64.exe
  apt-cyg install wget curl tar p7zip git openssh vim tmux zsh procps fontconfig fontforge ghostscript ImageMagick make automake cmake gcc-core gcc-g++
  apt-cyg install cygwin-devel openssl-devel libevent-devel libncurses-devel libncursesw-devel libtool yasm yasm-devel binutils diffutils dos2unix libfontconfig-devel libiconv-devel libass-devel fribidi libfribidi-devel libfreetype-devel libopenjpeg-devel libopus-devel libvorbis-devel libvpx-devel libwebp-devel libbz2-devel
  grep -q -F '/cygdrive/c/Users /home none bind 0 0' /etc/fstab || echo '/cygdrive/c/Users /home none bind 0 0' >> /etc/fstab
  grep -q -F 'none /tmp usertemp binary,posix=0 0 0' /etc/fstab || echo 'none /tmp usertemp binary,posix=0 0 0' >> /etc/fstab
  sed -i 's/.*db_shell.*/db_shell: \/bin\/zsh/' /etc/nsswitch.conf
  mount -a
  curl 'https://bootstrap.pypa.io/get-pip.py' | python3
  echo y | pip install youtube-dl
  echo y | pip install you-get
  rm -rf ~/dotfile
  rm -rf ~/.oh-my-zsh
  git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
python3 <<END
import sys, os, site

pkgLocation = site.getsitepackages()
for location in pkgLocation:
  os.system("install -D ~/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
END





elif [[ "$OSTYPE" == "msys" ]]; then # Msys
  pacman -S tmux zsh git vim curl wget





elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
  sudo pkg update
  echo y | sudo pkg install tmux zsh git vim curl ubuntu-font
  chsh -s $(command -v zsh) $(whoami)
  rm -rf ~/dotfile
  rm -rf ~/.oh-my-zsh
  git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  git config --global core.editor vim
  ln -sf ~/dotfile/.bashrc ~/.bashrc
  ln -sf ~/dotfile/.bash_profile ~/.bash_profile
  ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf ~/dotfile/.zshrc ~/.zshrc
  ln -sf ~/dotfile/.vimrc ~/.vimrc
  ln -sf ~/dotfile/.gitconfig ~/.gitconfig





else # Unknown OS
  echo "Unknown OS"
fi
