#!/usr/bin/env python3

# Install dotfile for Windows
# $ ./install.py windows
# Install dotfile for Linux
# $ ./install.py linux

import sys, os, site

if len(sys.argv) == 1:
    print("Usage: ./install.py <Operating System>")
    sys.exit(1)

commands = []

def windows():
#     commands.append("lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg");
#     commands.append("install apt-cyg /bin && rm apt-cyg");
    commands.append("curl -LOC - 'https://cygwin.com/setup-x86_64.exe' && install setup-x86_64.exe /bin && rm setup-x86_64.exe")
    commands.append("setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --packages wget curl tar p7zip git openssh sed vim tmux zsh procps fontconfig fontforge ghostscript ImageMagick make automake cmake gcc-core gcc-g++")
    commands.append("setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --packages cygwin-devel openssl-devel libevent-devel libncurses-devel libncursesw-devel libtool yasm yasm-devel binutils diffutils dos2unix libfontconfig-devel libiconv-devel libass-devel fribidi libfribidi-devel libfreetype-devel libopenjpeg-devel libopus-devel libvorbis-devel libvpx-devel libwebp-devel libbz2-devel")
    commands.append("grep -q -F '/cygdrive/c/Users /home none bind 0 0' /etc/fstab || echo '/cygdrive/c/Users /home none bind 0 0' >> /etc/fstab")
    commands.append("grep -q -F 'none /tmp usertemp binary,posix=0 0 0' /etc/fstab || echo 'none /tmp usertemp binary,posix=0 0 0' >> /etc/fstab")
    commands.append("mount -a")
    commands.append("rm -rf ~/dotfile")
    commands.append("rm -rf ~/.oh-my-zsh")
    commands.append("git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile")
    commands.append("git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh")
    commands.append("git config --global core.editor vim")
    print("Run install.bat to install dotfiles.")
    print("Make sure miniconda is installed.")
#     commands.append("curl -LOC - 'https://bootstrap.pypa.io/get-pip.py'")
#     commands.append("python3 get-pip.py")
#     commands.append("rm get-pip.py")
    commands.append("echo y | pip install youtube-dl")
    commands.append("echo y | pip install you-get")
    commands.append("install -D ~/dotfile/Windows/sitecustomize.py ~/Miniconda3/Lib/site-packages/sitecustomize.py")
    commands.append("rm -rf /usr/share/fonts/win-fonts")
    commands.append("mkdir /usr/share/fonts/win-fonts")
    commands.append("find /cygdrive/c/Windows/Fonts -iname '*.ttc' -printf '%P\n' -o -iname '*.ttf' -printf '%P\n' | xargs -I % bash -c 'ln -s /cygdrive/c/Windows/Fonts/$0 /usr/share/fonts/win-fonts/$0' %")
#     commands.append("fc-cache -fv")

def linux():
    commands.append("sudo apt-get update")
    commands.append("sudo apt-get install tmux zsh git curl wget p7zip-full p7zip-rar build-essential vim ffmpeg ttf-ubuntu-font-family fonts-droid-fallback fontconfig vim-gnome network-manager file-roller software-properties-gtk baobab gnome-system-monitor gnome-disk-utility -y")
    commands.append("rm -rf ~/dotfile")
    commands.append("rm -rf ~/.oh-my-zsh")
    commands.append("git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile")
    commands.append("git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh")
    commands.append("git config --global core.editor vim")
    commands.append("ln -sf ~/dotfile/.bashrc ~/.bashrc")
    commands.append("ln -sf ~/dotfile/.bash_profile ~/.bash_profile")
    commands.append("ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf")
    commands.append("ln -sf ~/dotfile/.zshrc ~/.zshrc")
    commands.append("ln -sf ~/dotfile/.vimrc ~/.vimrc")
    commands.append("ln -sf ~/dotfile/.fbtermrc ~/.fbtermrc")
    commands.append("mkdir -p ~/.config/openbox")
    commands.append("ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/rc.xml")
    commands.append("ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/lxqt-rc.xml")
    commands.append("ln -sf ~/dotfile/Linux/.config_openbox_rc.xml ~/.config/openbox/lxde-rc.xml")
    commands.append("sudo install ~/dotfile/Linux/reconnect /usr/bin/reconnect")
    commands.append("sudo chmod 755 /usr/bin/reconnect")
    commands.append("sudo install ~/dotfile/Linux/reconnect.service /lib/systemd/system/reconnect.service")
    commands.append("sudo chmod 755 /lib/systemd/system/reconnect.service")
    commands.append("sudo install ~/dotfile/Linux/sddm.conf /etc/sddm.conf")
    commands.append("sudo systemctl enable reconnect.service")
    commands.append("sudo cp ~/dotfile/Linux/BaiduCloud.desktop /usr/share/applications/BaiduCloud.desktop")
    commands.append("sudo cp ~/dotfile/Linux/gvim.desktop /usr/share/applications/gvim.desktop")
    commands.append("curl -LOC - 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh'");
    commands.append("chmod 777 Miniconda3-latest-Linux-x86_64.sh");
    commands.append("./Miniconda3-latest-Linux-x86_64.sh -p ~/Miniconda3 -b -f");
    commands.append("rm Miniconda3-latest-Linux-x86_64.sh");
    commands.append("export PATH=~/Miniconda3/bin:$PATH");
    commands.append("echo y | pip install youtube-dl");
    commands.append("echo y | pip install you-get");
    pkgLocation = site.getsitepackages()
    for location in pkgLocation:
        commands.append("sudo install -D ~/dotfile/Windows/sitecustomize.py " + location + "/sitecustomize.py")
    commands.append("openbox --reconfigure")

def bsd():
    commands.append("sudo pkg update")
    commands.append("echo y | sudo pkg install tmux zsh git vim curl ubuntu-font")
    commands.append("chsh -s $(command -v zsh) $(whoami)")
    commands.append("rm -rf ~/dotfile")
    commands.append("rm -rf ~/.oh-my-zsh")
    commands.append("git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile")
    commands.append("git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh")
    commands.append("git config --global core.editor vim")
    commands.append("grep -q -F 'Control Mod1 T :Exec qterminal' ~/.config/lumina-desktop/fluxbox-keys || echo 'Control Mod1 T :Exec qterminal' >> ~/.config/lumina-desktop/fluxbox-keys");
    commands.append("grep -q -F 'Control Mod1 G :Exec vim' ~/.config/lumina-desktop/fluxbox-keys || echo 'Control Mod1 G :Exec gvim' >> ~/.config/lumina-desktop/fluxbox-keys");
    commands.append("ln -sf ~/dotfile/.bashrc ~/.bashrc")
    commands.append("ln -sf ~/dotfile/.bash_profile ~/.bash_profile")
    commands.append("ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf")
    commands.append("ln -sf ~/dotfile/.zshrc ~/.zshrc")
    commands.append("ln -sf ~/dotfile/.vimrc ~/.vimrc")

def container():
    commands.append("apt-get update")
    commands.append("apt-get install tmux zsh git curl vim wget nano -y")
    commands.append("rm -rf ~/dotfile")
    commands.append("rm -rf ~/.oh-my-zsh")
    commands.append("git clone --depth=1 https://github.com/j16180339887/dotfile.git ~/dotfile")
    commands.append("git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh")
    commands.append("git config --global core.editor vim")
    commands.append("ln -sf ~/dotfile/.bashrc ~/.bashrc")
    commands.append("ln -sf ~/dotfile/.bash_profile ~/.bash_profile")
    commands.append("ln -sf ~/dotfile/.tmux.conf ~/.tmux.conf")
    commands.append("ln -sf ~/dotfile/.zshrc ~/.zshrc")
    commands.append("ln -sf ~/dotfile/.vimrc ~/.vimrc")
    commands.append("ln -sf ~/dotfile/.fbtermrc ~/.fbtermrc")

def install():
    for cmd in commands:
        if os.system(cmd) != 0:
            print("Error: " + cmd)
            sys.exit(1)

target = sys.argv[1].lower()

if   target == "windows":
    windows()
    install()
elif target == "linux":
    linux()
    install()
elif target == "bsd":
    bsd()
    install()
elif target == "container":
    container()
    install()
else:
    print("System not support")
    sys.exit(1)

sys.exit(0)
