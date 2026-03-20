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
  rm -rf  ~/.config/gitui/key_bindings.ron
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
  mkdir -p $Home/.config/gitui/
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
  ln -sf ~/dotfile/grc/grc.conf ~/.grc/grc.conf
  ln -sf ~/dotfile/grc/colourfiles/* ~/.grc
  ln -sf $Home/dotfile/.alacritty.toml ~/.config/alacritty/alacritty.toml
  ln -sf $Home/dotfile/.alacritty.toml ~/.alacritty.toml
  ln -sf $Home/dotfile/.mpv.conf ~/.config/mpv/mpv.conf
  ln -sf $Home/dotfile/.mpv.input.conf ~/.config/mpv/input.conf
  ln -sf $Home/dotfile/.zed.settings.js ~/.config/zed/settings.json
  ln -sf $Home/dotfile/.zed.keymap.js ~/.config/zed/keymap.json
  ln -sf $Home/dotfile/.helix.config.toml ~/.config/helix/config.toml
  ln -sf $Home/dotfile/.gitui.key_bindings.ron ~/.config/gitui/key_bindings.ron

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

InstallDotfileGitBash()
{
  rm -rf "$HOME/dotfile"
  rm -rf ~/.grc
  git clone --depth=1 git@github.com:joeky888/dotfile.git "$HOME/dotfile"

  mkdir -p "$HOME/Documents/WindowsPowerShell"
  mkdir -p "$HOME/.config/fish/"
  mkdir -p "$HOME/.pip/"
  mkdir -p "$HOME/pip/"
  mkdir -p "$HOME/.grc/"
  mkdir -p "$HOME/AppData/Local/nvim"
  mkdir -p "$HOME/AppData/Roaming/mpv"
  mkdir -p "$HOME/AppData/Roaming/alacritty"
  mkdir -p "$HOME/AppData/Roaming/Code/User"
  mkdir -p "$HOME/AppData/Roaming/VSCodium/User"
  mkdir -p "$HOME/AppData/Roaming/helix"
  mkdir -p "$HOME/AppData/Roaming/gitui"
  mkdir -p "$HOME/scoop/apps/mpv/current/portable_config/scripts"
  mkdir -p "$HOME/scoop/apps/mpv/current/portable_config/script-opts"
  mkdir -p "$HOME/scoop/apps/mpv-git/current/portable_config/scripts"
  mkdir -p "$HOME/scoop/apps/mpv-git/current/portable_config/script-opts"

  # Helper function to run elevated mklink in Git Bash
  win_link() {
    # Usage: win_link "target_link" "source_file"
    powershell.exe -Command "Start-Process cmd -ArgumentList '/c mklink \"$1\" \"$2\"' -Verb RunAs"
  }

  rm -f "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.tmux.conf" "$HOME/.zshrc" "$HOME/.nanorc" \
        "$HOME/.minttyrc" "$HOME/.pythonrc" "$HOME/AppData/Local/nvim/init.vim" "$HOME/pip/pip.ini" \
        "$HOME/.pip/pip.conf" "$HOME/.condarc" "$HOME/.npmrc" "$HOME/.yarnrc" "$HOME/.tigrc" \
        "$HOME/.gitconfig" "$HOME/.gitmessage" "$HOME/.Xresources" "$HOME/.alacritty.toml" \
        "$HOME/.myclirc" "$HOME/.config/fish/config.fish" \
        "$HOME/Documents/WindowsPowerShell/profile.ps1" \
        "$HOME/scoop/apps/vscode/current/data/user-data/User/settings.json" \
        "$HOME/scoop/apps/vscode/current/data/user-data/User/keybindings.json" \
        "$HOME/AppData/Zed/settings.json" \
        "$HOME/AppData/Zed/keymap.json"

  win_link "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
  win_link "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bashrc"
  win_link "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
  win_link "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.bashrc"
  win_link "%USERPROFILE%\.nanorc" "%USERPROFILE%\dotfile\.nanorc"
  win_link "%USERPROFILE%\.minttyrc" "%USERPROFILE%\dotfile\Windows\.minttyrc"
  win_link "%USERPROFILE%\.tigrc" "%USERPROFILE%\dotfile\.tigrc"
  win_link "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfile\.gitconfig"
  win_link "%USERPROFILE%\.gitmessage" "%USERPROFILE%\dotfile\.gitmessage"
  win_link "%USERPROFILE%\.pythonrc" "%USERPROFILE%\dotfile\.pythonrc"
  win_link "%USERPROFILE%\.pip\pip.conf" "%USERPROFILE%\dotfile\.pip.ini"
  win_link "%USERPROFILE%\pip\pip.ini" "%USERPROFILE%\dotfile\.pip.ini"
  win_link "%USERPROFILE%\.condarc" "%USERPROFILE%\dotfile\.condarc"
  win_link "%USERPROFILE%\.npmrc" "%USERPROFILE%\dotfile\.npmrc"
  win_link "%USERPROFILE%\.yarnrc" "%USERPROFILE%\dotfile\.yarnrc"
  win_link "%USERPROFILE%\.Xresources" "%USERPROFILE%\dotfile\.Xresources"
  win_link "%USERPROFILE%\.alacritty.toml" "%USERPROFILE%\dotfile\.alacritty.toml"
  win_link "%USERPROFILE%\.myclirc" "%USERPROFILE%\dotfile\.myclirc"
  win_link "%USERPROFILE%\.config\fish\config.fish" "%USERPROFILE%\dotfile\.config.fish"
  win_link "%USERPROFILE%\.config\starship.toml" "%USERPROFILE%\dotfile\starship.toml"

  cd "$HOME/dotfile" && git submodule update --init --remote && cd - ;

  win_link "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1" "%USERPROFILE%\dotfile\powershell\profile.ps1"
  win_link "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\vimrc\.vimrc"
  win_link "%USERPROFILE%\AppData\Local\nvim\init.vim" "%USERPROFILE%\dotfile\vimrc\.vimrc"
  win_link "%APPDATA%\mpv\mpv.conf" "%USERPROFILE%\dotfile\.mpv.conf"
  win_link "%APPDATA%\mpv\input.conf" "%USERPROFILE%\dotfile\.mpv.input.conf"
  win_link "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfile\.vscode.settings.js"
  win_link "%APPDATA%\VSCodium\User\settings.json" "%USERPROFILE%\dotfile\.vscode.settings.js"
  win_link "%APPDATA%\Code\User\keybindings.json" "%USERPROFILE%\dotfile\.vscode.keybindings.js"
  win_link "%APPDATA%\VSCodium\User\keybindings.json" "%USERPROFILE%\dotfile\.vscode.keybindings.js"
  win_link "%APPDATA%\helix\config.toml" "%USERPROFILE%\dotfile\.helix.config.toml"
  win_link "%APPDATA%\gitui\key_bindings.ron" "%USERPROFILE%\dotfile\.gitui.key_bindings.ron"
  win_link "%APPDATA%\Zed\settings.json" "%USERPROFILE%\dotfile\.zed.settings.js"
  win_link "%APPDATA%\Zed\keymap.json" "%USERPROFILE%\dotfile\.zed.keymap.js"
  win_link "%USERPROFILE%\AppData\Roaming\alacritty\alacritty.toml" "%USERPROFILE%\dotfile\.alacritty.toml"
  win_link "%USERPROFILE%\scoop\apps\vscode\current\data\user-data\User\keybindings.json" "%USERPROFILE%\dotfile\.vscode.keybindings.js"
  win_link "%USERPROFILE%\scoop\apps\vscode\current\data\user-data\User\settings.json" "%USERPROFILE%\dotfile\.vscode.settings.js"
  win_link "%USERPROFILE%\scoop\apps\mpv\current\portable_config\mpv.conf" "%USERPROFILE%\dotfile\.mpv.conf"
  win_link "%USERPROFILE%\scoop\apps\mpv\current\portable_config\input.conf" "%USERPROFILE%\dotfile\.mpv.input.conf"
  win_link "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\mpv.conf" "%USERPROFILE%\dotfile\.mpv.conf"
  win_link "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\input.conf" "%USERPROFILE%\dotfile\.mpv.input.conf"
  win_link "%USERPROFILE%\.wezterm.lua" "%USERPROFILE%\dotfile\.wezterm.lua"

  # Run Registry import elevated
  powershell.exe -Command "Start-Process reg -ArgumentList 'import \"%USERPROFILE%\\dotfile\\install.reg\"' -Verb RunAs"

  ln -sf "$HOME/dotfile/grc/grc.conf" "$HOME/.grc/grc.conf"
  ln -sf "$HOME/dotfile/grc/colourfiles/"* "$HOME/.grc/"
}


InstallPIP()
{
  curl 'https://bootstrap.pypa.io/get-pip.py' | $SUDO python3
#   echo y | $SUDO pip install --upgrade https://github.com/yt-dlp/yt-dlp/archive/master.zip https://github.com/yt-dlp/ejs/archive/master.zip
#   echo y | $SUDO pip install streamlink
}

InstallMiniforge()
{
  ARCH=$(uname -m)
  [ -z $1 ] && return;
  # rm -rf ~/Miniconda2 && aria2c "https://repo.anaconda.com/miniconda/Miniconda2-latest-$1-x86_64.sh" && chmod +x Miniconda2-latest-$1-x86_64.sh && bash Miniconda2-latest-$1-x86_64.sh -p ~/Miniconda2 -b -f && rm Miniconda2-latest-$1-x86_64.sh
  rm -rf ~/Miniforge3 && aria2c "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$1-$ARCH.sh" -o Miniforge3.sh && bash Miniforge3.sh -b -f -p ~/Miniforge3 && rm Miniforge3.sh
#   ~/Miniforge3/bin/pip install --upgrade https://github.com/yt-dlp/yt-dlp/archive/master.zip https://github.com/yt-dlp/ejs/archive/master.zip
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
  InstallMiniforge Linux








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
  InstallMiniforge MacOSX




elif [[ "$OSTYPE" == "msys" ]]; then # Git bash
  InstallDotfileGitBash


elif [[ "$OSTYPE" == "linux-android" ]]; then # Android Termux
  export SUDO=''
  export Home="$HOME"

  termux-change-repo
  termux-setup-storage
  pkg update
  # apt install -y --assume-yes git aria2
  apt install -y --assume-yes aria2 fish fzf proot-distro 7zip helix helix-grammars gopls
  # InstallDotfile
  # ~/dotfile/app-fast/app-fast install -y man vim git tig zsh fish tmux curl file tar wget bash-completion htop openssh grep sed gawk ffmpeg proot-distro
  # ~/dotfile/app-fast/app-fast install -y clang autoconf automake bison bzip2 util-linux cmake coreutils diffutils flex gzip make patch perl silversearcher-ag
  # ~/dotfile/app-fast/app-fast install -y libtool ncurses-utils python-dev libffi-dev libcrypt-dev openssl-dev readline-dev
  # InstallPIP
  curl -L https://raw.githubusercontent.com/joeky888/dotfile/master/.bashrc > ~/.bashrc
  mkdir -p ~/.config/fish && curl https://raw.githubusercontent.com/joeky888/dotfile/master/.config.fish -o ~/.config/fish/config.fish
  # chsh -s fish
  apt install -y zellij # This will failed on arm32 system
  # apt install python-pip -y
  # pip install --upgrade --no-cache-dir https://github.com/yt-dlp/yt-dlp/archive/master.zip
  # Ref: https://stackoverflow.com/a/77604799
  # CFLAGS="-Wno-error=incompatible-function-pointer-types -O0" pip install --upgrade --no-cache-dir https://github.com/streamlink/streamlink/archive/master.zip





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
