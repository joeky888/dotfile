#! /bin/bash

export SUDO=''
[ "`whoami`" = "root" ] || export SUDO='sudo'

InstallDotfile()
{
  [ $Home ] || export Home="$HOME"
  rm -rf $Home/dotfile
  rm -rf ~/.bashrc
  rm -rf ~/.bash_profile
  rm -rf ~/.tmux.conf
  rm -rf ~/.zshrc
  rm -rf ~/.tigrc
  rm -rf ~/.gitconfig
  rm -rf ~/.gitmessage
  rm -rf ~/.fbtermrc
  rm -rf ~/.Xresources
  rm -rf ~/.xprofile
  rm -rf ~/.vimrc
  rm -rf ~/.nanorc
  rm -rf ~/.pythonrc
  rm -rf ~/.pip/pip.conf
  rm -rf ~/.condarc
  rm -rf ~/.config/nvim/init.vim
  rm -rf ~/AppData/Local/nvim/init.vim
  rm -rf ~/.grc
  rm -rf ~/.config/alacritty/alacritty.toml
  rm -rf ~/.alacritty.toml
  rm -rf ~/.myclirc
  rm -rf ~/.config/fish/config.fish
  rm -rf ~/.config/starship.toml
  rm -rf ~/.config/mpv/mpv.conf
  rm -rf ~/.config/mpv/input.conf
  rm -rf ~/.hammerspoon/init.lua
  rm -rf  ~/.config/zed/settings.json
  rm -rf  ~/.config/zed/keymap.json
  rm -rf "$Home/Library/Application Support/Code/User/settings.json"
  rm -rf "$Home/Library/Application Support/VSCodium/User/settings.json"
  rm -rf "$Home/scoop/apps/vscode/current/data/user-data/User/settings.json"
  rm -rf "$Home/.config/Code/User/settings.json"
  rm -rf "$Home/.config/VSCodium/User/settings.json"
  rm -rf "$Home/scoop/apps/vscode/current/data/user-data/User/keybindings.json"
  rm -rf "$Home/.config/Code/User/keybindings.json"
  rm -rf "$Home/.config/VSCodium/User/keybindings.json"

  git clone --depth=1 git@github.com:joeky888/dotfile.git $Home/dotfile
  ln -sf $Home/dotfile/.bashrc ~/.bashrc
  ln -sf $Home/dotfile/.bashrc ~/.bash_profile
  ln -sf $Home/dotfile/.tmux.conf ~/.tmux.conf
  ln -sf $Home/dotfile/.bashrc ~/.zshrc
  ln -sf $Home/dotfile/.nanorc ~/.nanorc
  ln -sf $Home/dotfile/.tigrc ~/.tigrc
  ln -sf $Home/dotfile/.gitconfig ~/.gitconfig
  ln -sf $Home/dotfile/.gitmessage ~/.gitmessage
  ln -sf $Home/dotfile/.fbtermrc ~/.fbtermrc
  ln -sf $Home/dotfile/.pythonrc ~/.pythonrc
  ln -sf $Home/dotfile/.condarc ~/.condarc
  ln -sf $Home/dotfile/.npmrc ~/.npmrc
  ln -sf $Home/dotfile/.yarnrc ~/.yarnrc
  ln -sf $Home/dotfile/.Xresources ~/.Xresources
  ln -sf $Home/dotfile/.xprofile ~/.xprofile
  ln -sf $Home/dotfile/.myclirc ~/.myclirc
  cd $Home/dotfile && git pull &&\
  git submodule update --init --remote
  cd - ;
  mkdir -p $Home/.config/nvim/
  mkdir -p $Home/.config/alacritty/
  mkdir -p $Home/.config/mpv/
  mkdir -p $Home/.config/mpv/scripts
  mkdir -p $Home/.config/mpv/script-opts
  mkdir -p $Home/.config/fish/
  mkdir -p $Home/.config/zed/
  mkdir -p $Home/.config/helix/
  mkdir -p $Home/.pip/
  mkdir -p $Home/.grc/
  mkdir -p $Home/.hammerspoon/
  mkdir -p "$Home/Library/Application Support/Code/User"
  mkdir -p "$Home/Library/Application Support/VSCodium/User"
  mkdir -p "$Home/.config/Code/User"
  mkdir -p "$Home/.config/VSCodium/User"
  ln -sf $Home/dotfile/vimrc/.vimrc ~/.vimrc
  ln -sf $Home/dotfile/vimrc/.vimrc ~/.config/nvim/init.vim
  ln -sf $Home/dotfile/.pip.ini ~/.pip/pip.conf
  ln -sf $Home/dotfile/.config.fish ~/.config/fish/config.fish
  ln -sf $Home/dotfile/starship.toml ~/.config/starship.toml
  ln -sf ~/dotfile/grc/grc.conf ~/.grc/grc.conf
  ln -sf ~/dotfile/grc/colourfiles/* ~/.grc
  ln -sf $Home/dotfile/.alacritty.toml ~/.config/alacritty/alacritty.toml
  ln -sf $Home/dotfile/.alacritty.toml ~/.alacritty.toml
  ln -sf $Home/dotfile/.mpv.conf ~/.config/mpv/mpv.conf
  ln -sf $Home/dotfile/.mpv.input.conf ~/.config/mpv/input.conf
  ln -sf $Home/dotfile/.mpv_thumbnail_script.conf ~/.config/mpv/script-opts/mpv_thumbnail_script.conf
  ln -sf $Home/dotfile/.mpv_thumbnail_script_client_osc.lua ~/.config/mpv/scripts/.mpv_thumbnail_script_client_osc.lua
  ln -sf $Home/dotfile/.mpv_thumbnail_script_server.lua ~/.config/mpv/scripts/.mpv_thumbnail_script_server.lua
  ln -sf $Home/dotfile/.zed.settings.js ~/.config/zed/settings.json
  ln -sf $Home/dotfile/.zed.keymap.js ~/.config/zed/keymap.json
  ln -sf $Home/dotfile/.helix.config.toml ~/.config/helix/config.toml

  case $OSTYPE in
  linux-gnu)
    ln -sf $Home/dotfile/.vscode.settings.js ~/.config/Code/User/settings.json
    ln -sf $Home/dotfile/.vscode.settings.js ~/.config/VSCodium/User/settings.json
    ln -sf $Home/dotfile/.vscode.keybindings.js ~/.config/Code/User/keybindings.json
    ln -sf $Home/dotfile/.vscode.keybindings.js ~/.config/VSCodium/User/keybindings.json
    ;;
  darwin*)
    ln -sf $Home/dotfile/MacOS/hammerspoon.lua ~/.hammerspoon/init.lua
    ln -sf $Home/dotfile/.vscode.settings.js "$Home/Library/Application Support/Code/User/settings.json"
    ln -sf $Home/dotfile/.vscode.settings.js "$Home/Library/Application Support/VSCodium/User/settings.json"
    ln -sf $Home/dotfile/.vscode.keybindings.js "$Home/Library/Application Support/Code/User/keybindings.json"
    ln -sf $Home/dotfile/.vscode.keybindings.js "$Home/Library/Application Support/VSCodium/User/keybindings.json"
    ;;
  cygwin)
    echo "Cygwin"
    ;;
  *)
    echo "Unknown OS"
    ;;
  esac
}

InstallDotfileCygwin()
{
  rm -rf $Home/dotfile
  rm -rf ~/.grc
  git clone --depth=1 git@github.com:joeky888/dotfile.git $Home/dotfile
  mkdir -p $Home/Documents/WindowsPowerShell
  mkdir -p $Home/.config/fish/
  mkdir -p $Home/.pip/
  mkdir -p $Home/pip/
  mkdir -p $Home/.grc/
  mkdir -p $Home/AppData/Local/nvim
  mkdir -p $Home/AppData/Roaming/mpv
  mkdir -p $Home/AppData/Roaming/alacritty
  mkdir -p $Home/AppData/Roaming/Code/User
  mkdir -p $Home/AppData/Roaming/VSCodium/User
  mkdir -p $Home/AppData/Roaming/helix
  mkdir -p $Home/scoop/apps/mpv/current/portable_config/scripts
  mkdir -p $Home/scoop/apps/mpv/current/portable_config/script-opts
  mkdir -p $Home/scoop/apps/mpv-git/current/portable_config/scripts
  mkdir -p $Home/scoop/apps/mpv-git/current/portable_config/script-opts
  rm -f $Home/.bashrc
  rm -f $Home/.bash_profile
  rm -f $Home/.tmux.conf
  rm -f $Home/.zshrc
  rm -f $Home/.nanorc
  rm -f $Home/.minttyrc
  rm -f $Home/.pythonrc
  rm -f $Home/AppData/Local/nvim/init.vim
  rm -f $Home/pip/pip.ini
  rm -f $Home/.pip/pip.conf
  rm -f $Home/.condarc
  rm -f $Home/.npmrc
  rm -f $Home/.yarnrc
  rm -f $Home/.tigrc
  rm -f $Home/.gitconfig
  rm -f $Home/.gitmessage
  rm -f $Home/.Xresources
  rm -f $Home/.alacritty.toml
  rm -f $Home/.myclirc
  rm -f $Home/.config/fish/config.fish
  rm -f $Home/.config/starship.toml
  rm -f $Home/Documents/WindowsPowerShell/profile.ps1
  rm -f $Home/scoop/apps/vscode/current/data/user-data/User/settings.json
  rm -f $Home/scoop/apps/vscode/current/data/user-data/User/keybindings.json
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.bashrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.nanorc" "%USERPROFILE%\dotfile\.nanorc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.minttyrc" "%USERPROFILE%\dotfile\Windows\.minttyrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tigrc" "%USERPROFILE%\dotfile\.tigrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfile\.gitconfig"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitmessage" "%USERPROFILE%\dotfile\.gitmessage"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.pythonrc" "%USERPROFILE%\dotfile\.pythonrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.pip\pip.conf" "%USERPROFILE%\dotfile\.pip.ini"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\pip\pip.ini" "%USERPROFILE%\dotfile\.pip.ini"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.condarc" "%USERPROFILE%\dotfile\.condarc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.npmrc" "%USERPROFILE%\dotfile\.npmrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.yarnrc" "%USERPROFILE%\dotfile\.yarnrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.Xresources" "%USERPROFILE%\dotfile\.Xresources"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.alacritty.toml" "%USERPROFILE%\dotfile\.alacritty.toml"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.myclirc" "%USERPROFILE%\dotfile\.myclirc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.config\fish\config.fish" "%USERPROFILE%\dotfile\.config.fish"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.config\starship.toml" "%USERPROFILE%\dotfile\starship.toml"
  cd $Home/dotfile
  git submodule update --init --remote
  cd - ;
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1" "%USERPROFILE%\dotfile\powershell\profile.ps1"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\vimrc\.vimrc"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\AppData\Local\nvim\init.vim" "%USERPROFILE%\dotfile\vimrc\.vimrc"
  cygstart --action=runas cmd.exe /c mklink "%APPDATA%\mpv\mpv.conf" "%USERPROFILE%\dotfile\.mpv.conf"
  cygstart --action=runas cmd.exe /c mklink "%APPDATA%\mpv\input.conf" "%USERPROFILE%\dotfile\.mpv.input.conf"
  cygstart --action=runas cmd.exe /c mklink "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfile\.vscode.settings.js"
  cygstart --action=runas cmd.exe /c mklink "%APPDATA%\VSCodium\User\settings.json" "%USERPROFILE%\dotfile\.vscode.settings.js"
  cygstart --action=runas cmd.exe /c mklink "%APPDATA%\Code\User\keybindings.json" "%USERPROFILE%\dotfile\.vscode.keybindings.js"
  cygstart --action=runas cmd.exe /c mklink "%APPDATA%\VSCodium\User\keybindings.json" "%USERPROFILE%\dotfile\.vscode.keybindings.js"
  cygstart --action=runas cmd.exe /c mklink "%APPDATA%\helix\config.toml" "%USERPROFILE%\dotfile\.helix.config.toml"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\AppData\Roaming\alacritty\alacritty.toml" "%USERPROFILE%\dotfile\.alacritty.toml"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\vscode\current\data\user-data\User\keybindings.json" "%USERPROFILE%\dotfile\.vscode.keybindings.js"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\vscode\current\data\user-data\User\settings.json" "%USERPROFILE%\dotfile\.vscode.settings.js"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv\current\portable_config\mpv.conf" "%USERPROFILE%\dotfile\.mpv.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv\current\portable_config\input.conf" "%USERPROFILE%\dotfile\.mpv.input.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv\current\portable_config\scripts\mpv_thumbnail_script_client_osc.lua" "%USERPROFILE%\dotfile\.mpv_thumbnail_script_client_osc.lua"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv\current\portable_config\scripts\mpv_thumbnail_script_server.lua" "%USERPROFILE%\dotfile\.mpv_thumbnail_script_server.lua"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv\current\portable_config\script-opts\mpv_thumbnail_script.conf" "%USERPROFILE%\dotfile\.mpv_thumbnail_script.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\mpv.conf" "%USERPROFILE%\dotfile\.mpv.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\input.conf" "%USERPROFILE%\dotfile\.mpv.input.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\scripts\mpv_thumbnail_script_client_osc.lua" "%USERPROFILE%\dotfile\.mpv_thumbnail_script_client_osc.lua"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\scripts\mpv_thumbnail_script_server.lua" "%USERPROFILE%\dotfile\.mpv_thumbnail_script_server.lua"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\script-opts\mpv_thumbnail_script.conf" "%USERPROFILE%\dotfile\.mpv_thumbnail_script.conf"
  cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.wezterm.lua" "%USERPROFILE%\dotfile\.wezterm.lua"
  cygstart --action=runas cmd.exe /c regedit /S "%USERPROFILE%\dotfile\install.reg"
  ln -sf ~/dotfile/grc/grc.conf ~/.grc/grc.conf
  ln -sf ~/dotfile/grc/colourfiles/* ~/.grc/
}

InstallPIP()
{
  curl 'https://bootstrap.pypa.io/get-pip.py' | $SUDO python3
  echo y | $SUDO pip install --upgrade https://github.com/yt-dlp/yt-dlp/archive/master.zip
#   echo y | $SUDO pip install streamlink
}

InstallMiniconda()
{
  ARCH=$(uname -m)
  [ -z $1 ] && return;
  # rm -rf ~/Miniconda2 && aria2c "https://repo.anaconda.com/miniconda/Miniconda2-latest-$1-x86_64.sh" && chmod 777 Miniconda2-latest-$1-x86_64.sh && bash Miniconda2-latest-$1-x86_64.sh -p ~/Miniconda2 -b -f && rm Miniconda2-latest-$1-x86_64.sh
  rm -rf ~/Miniconda3 && aria2c "https://repo.anaconda.com/miniconda/Miniconda3-latest-$1-$ARCH.sh" && chmod 777 Miniconda3-latest-$1-$ARCH.sh && bash Miniconda3-latest-$1-$ARCH.sh -p ~/Miniconda3 -b -f && rm Miniconda3-latest-$1-$ARCH.sh
  echo y | ~/Miniconda3/bin/pip install --upgrade https://github.com/yt-dlp/yt-dlp/archive/master.zip
#   echo y | ~/Miniconda3/bin/pip install streamlink
}

InstallAlpine()
{
  ARCH=$(uname -m)
  ALPINE_VER=$(curl -s http://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/$ARCH/latest-releases.yaml | grep -m 1 -o version.* | sed 's/[^0-9.]*//g')
  ALPINE_URL="http://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/$ARCH/alpine-minirootfs-$ALPINE_VER-$ARCH.tar.gz"
  ALPINE_HOME="$HOME/Alpine"
  rm -rf $ALPINE_HOME && mkdir -p $ALPINE_HOME && cd $ALPINE_HOME
  aria2c $ALPINE_URL
  proot --link2symlink -0 bsdtar -xpf *.tar.gz 2> /dev/null || :
  cd -
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then

  export Home="$HOME"
  if [[ $(command -v apt) ]]; then
    $SUDO apt update
    $SUDO apt install -y git aria2
    InstallDotfile
    $SUDO install ~/dotfile/app-fast/app-fast /usr/bin/app-fast
    app-fast install vim tmux zsh curl bash-completion -y

  elif [[ $(command -v pacman) ]]; then
    $SUDO pacman -S git aria2 --needed --noconfirm
    InstallDotfile
    $SUDO install ~/dotfile/app-fast/app-fast /usr/bin/app-fast
#     $SUDO cp /etc/pacman.conf /etc/pacman.conf.bak
#     $SUDO sed -i '/XferCommand/d' /etc/pacman.conf
#     $SUDO sed -i '/Color/d' /etc/pacman.conf
#     $SUDO sed -i '/\[options\]/a Color' /etc/pacman.conf
#     $SUDO sed -i '/\[options\]/a XferCommand = aria2c -c -s16 -k1M -x16 --dir=/ -o %o %u' /etc/pacman.conf
    app-fast -S vim tmux zsh curl bash-completion yay --needed --noconfirm
  else
    echo "Distro does not support at this moment."
    exit 1
  fi
  [[ $(command -v zsh) ]] && chsh -s $(command -v zsh) $(whoami)
#   if [[ $(command -v NetworkManager) ]]; then
#     $SUDO install ~/dotfile/Linux/reconnect /usr/bin/reconnect
#     $SUDO chmod 755 /usr/bin/reconnect
#     $SUDO install ~/dotfile/Linux/reconnect.service /lib/systemd/system/reconnect.service
#     $SUDO systemctl enable --now reconnect.service
#   fi
  if [ $(command -v apt) ]; then
    app-fast install build-essential automake command-not-found nano ffmpeg atool fontconfig traceroute dnsutils mtr-tiny python3 wget tig htop -y
    app-fast install libssl-dev -y
  elif [ $(command -v pacman) ]; then
    app-fast -S --noconfirm --needed base-devel nano ripgrep fd ffmpeg atool fontconfig traceroute mtr nmap openssl net-tools iproute2 bind python3 wget tig upx htop btop fastfetch onefetch bottom
  fi

  if [ $(command -v pacman-mirrors) ] && [ $(command -v systemctl) ]; then
    $SUDO install ~/dotfile/Linux/pacmirror /usr/bin/pacmirror
    $SUDO chmod 755 /usr/bin/pacmirror
    $SUDO install ~/dotfile/Linux/pacmirror.service /lib/systemd/system/pacmirror.service
    $SUDO systemctl enable --now pacmirror.service
  fi

#   $SUDO aria2c https://raw.githubusercontent.com/joeky888/CJK-font/master/DroidSansFallback.ttf --dir=/ -o usr/share/fonts/truetype/DroidSansFallback.ttf
#   $SUDO aria2c https://raw.githubusercontent.com/joeky888/CJK-font/master/UbuntuMono.ttf --dir=/ -o usr/share/fonts/truetype/UbuntuMono.ttf
#   $SUDO aria2c https://raw.githubusercontent.com/joeky888/CJK-font/master/iosevka.ttf --dir=/ -o usr/share/fonts/truetype/iosevka.ttf
#   fc-cache -fv
#   find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
#   if [ -n "$SUDO" ]; then
#     sudo bash -c 'find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > /etc/nanorc'
#   else
#     find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > /etc/nanorc
#   fi
  if [ $(command -v localectl) ]; then
    $SUDO localectl set-locale LANG="en_US.UTF-8"
    $SUDO localectl set-locale LANGUAGE="en_US.UTF-8"
    $SUDO localectl set-locale LC_CTYPE="en_US.UTF-8"
    $SUDO localectl set-locale LC_NUMERIC="en_US.UTF-8"
    $SUDO localectl set-locale LC_TIME="en_US.UTF-8"
    $SUDO localectl set-locale LC_COLLATE="en_US.UTF-8"
    $SUDO localectl set-locale LC_MONETARY="en_US.UTF-8"
    $SUDO localectl set-locale LC_MESSAGES="en_US.UTF-8"
    $SUDO localectl set-locale LC_PAPER="en_US.UTF-8"
    $SUDO localectl set-locale LC_NAME="en_US.UTF-8"
    $SUDO localectl set-locale LC_ADDRESS="en_US.UTF-8"
    $SUDO localectl set-locale LC_TELEPHONE="en_US.UTF-8"
    $SUDO localectl set-locale LC_MEASUREMENT="en_US.UTF-8"
    $SUDO localectl set-locale LC_IDENTIFICATION="en_US.UTF-8"
  fi
  InstallMiniconda Linux








elif echo "$OSTYPE" | grep -q "darwin"; then # macOS
  export Home="$HOME"
  export SUDO=""
  [ $(command -v /opt/homebrew/bin/brew) ] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  /opt/homebrew/bin/brew update
  /opt/homebrew/bin/brew install git aria2 zsh vim tmux neovim curl coreutils grep findutils file-formula gnu-sed make fastfetch onefetch bottom opencc ffmpeg tig htop btop watch atool nmap mtr shellcheck
  InstallDotfile

  # ~/dotfile/app-fast/app-fast install bash zsh vim neovim curl coreutils grep findutils file-formula gnu-sed make automake autoconf wget opencc ffmpeg tig tmux htop watch atool nmap mtr shellcheck

  #chsh -s $(command -v zsh) $(whoami)
  #brew tap homebrew/cask-fonts
  #brew tap homebrew/cask-versions
  #brew tap beeftornado/rmtree
#   brew tap homebrew/cask-drivers
  InstallMiniconda MacOSX




elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
  if [[ ! $(command -v aria2c) ]]; then
    echo "Please install aria2"
    exit 1
  fi
#   export SUDO='cygstart --action=runas "$@" '
  export SUDO=""
  export Home=$(cygpath -u "$USERPROFILE")
#   if ! [[ $(command -v choco) ]]; then # Don't reinstall chocolatey
#     cygstart --action=runas cmd.exe /c RD /S /Q "%ALLUSERSPROFILE%\\chocolatey"
#     cygstart --action=runas cmd.exe /c @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
#     [[ "$PATH" != *"chocolatey/bin"* ]] && cygstart --action=runas cmd.exe /c "setlocal EnableDelayedExpansion & setx /M PATH \"%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin\""
#   fi
  rm -rf /bin/apt-cyg
  rm -rf /bin/setup-x86_64.exe
  curl https://raw.githubusercontent.com/joeky888/apt-cyg/master/apt-cyg -o /bin/apt-cyg && chmod 777 /bin/apt-cyg
  curl -LOC - 'https://cygwin.com/setup-x86_64.exe' && install setup-x86_64.exe /bin && rm setup-x86_64.exe
  apt-cyg install wget curl aria2 git vim nano tmux zsh fish atool
  InstallDotfileCygwin
  grep -q -F '/cygdrive/c/Users /home none bind 0 0' /etc/fstab || echo '/cygdrive/c/Users /home none bind 0 0' >> /etc/fstab
  grep -q -F 'none /tmp usertemp binary,posix=0 0 0' /etc/fstab || echo 'none /tmp usertemp binary,posix=0 0 0' >> /etc/fstab
#   sed -i 's/.*db_shell.*/db_shell: \/bin\/fish/' /etc/nsswitch.conf
#   find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; > $Home/.nanorc

  apt-cyg install openssh bind-utils bash-completion tig tar python3 python3-pip
#   apt-cyg install cygport procps fontconfig fontforge ghostscript ImageMagick make automake cmake gcc-core gcc-g++
#   apt-cyg install cygwin-devel doxygen python3-devel openssl-devel libevent-devel libncurses-devel libncursesw-devel libtool yasm yasm-devel binutils diffutils dos2unix libfontconfig-devel libiconv-devel libass-devel fribidi libfribidi-devel libfreetype-devel libopenjpeg-devel libopus-devel libvorbis-devel libvpx-devel libwebp-devel libbz2-devel libffi-devel gettext-devel
  InstallPIP






elif [[ "$OSTYPE" == "msys" ]]; then # Msys
  export SUDO=''
  export Home="$HOME"
#   pacman -R catgets libcatgets --noconfirm
  app-fast -Sy zsh git vim curl wget bash-completion base-devel msys2-devel mercurial cvs perl ruby python2 python3 python3-pip --noconfirm --needed
#   sed -i '/XferCommand/d' /etc/pacman.conf
#   sed -i '/\[options\]/a XferCommand = /mingw64/bin/aria2c -c -s16 -k1M -x16 %u' /etc/pacman.conf
#   sed -i '/./d' /etc/fstab
#   echo 'C:/Users /home ntfs binary,noacl,auto 1 1' >> /etc/fstab
#   echo 'none /tmp usertemp binary,posix=0 0 0' >> /etc/fstab
#   app-fast -S mingw-w64-x86_64-aria2 --noconfirm --needed
#   pacman -S mingw-w64-x86_64-toolchain --noconfirm





elif [[ "$OSTYPE" == "linux-android" ]]; then # Android Termux
  export SUDO=''
  export Home="$HOME"

  termux-change-repo
  termux-setup-storage
  # apt install -y --assume-yes git aria2
  apt install -y --assume-yes aria2 fish fastfetch libxml2 libxslt fzf proot-distro 7zip helix helix-grammars
  # InstallDotfile
  # ~/dotfile/app-fast/app-fast install -y man vim git tig zsh fish tmux curl file tar wget bash-completion htop openssh grep sed gawk ffmpeg proot-distro
  # ~/dotfile/app-fast/app-fast install -y clang autoconf automake bison bzip2 util-linux cmake coreutils diffutils flex gzip make patch perl silversearcher-ag
  # ~/dotfile/app-fast/app-fast install -y libtool ncurses-utils python-dev libffi-dev libcrypt-dev openssl-dev readline-dev
  # InstallPIP
  curl -L https://raw.githubusercontent.com/joeky888/dotfile/master/.bashrc > ~/.bashrc
  mkdir -p ~/.config/fish && curl https://raw.githubusercontent.com/joeky888/dotfile/master/.config.fish -o ~/.config/fish/config.fish
  # chsh -s fish
  apt install -y zellij # This will failed on arm32 system
  apt install python-pip -y
  pip install --upgrade --no-cache-dir https://github.com/yt-dlp/yt-dlp/archive/master.zip
  # Ref: https://stackoverflow.com/a/77604799
  CFLAGS="-Wno-error=incompatible-function-pointer-types -O0" pip install --upgrade --no-cache-dir https://github.com/streamlink/streamlink/archive/master.zip





elif echo "$OSTYPE" | grep -i -q "freebsd"; then # FreeBSD or TrueOS
  export Home="$HOME"
#   $SUDO pkg update -f
  echo y | $SUDO pkg install tmux zsh git tig vim-lite nano curl python3 aria2 bind-tools
  chsh -s $(command -v zsh) $(whoami)
#   find /usr/local/share/nano/ -iname "*.nanorc" -exec echo include {} \; > ~/.nanorc
  InstallDotfile
  echo y | $SUDO pkg install coreutils bash-completion gcc binutils automake autogen autotools autoconf pkgconf libtool gmake ncurses cmake ubuntu-font
  InstallPIP
#   echo y | $SUDO pkg install clang-devel



else # Unknown OS
  echo "Unknown OS: $OSTYPE"
fi
