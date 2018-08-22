if [ -z "$PS1" ]; then
   return # Prevent scp command hangs
fi

export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export CLICOLOR=1 # Colors for FreeBSD and MacOS
export force_color_prompt=yes
export color_prompt=yes

if [[ "$TERM" == "xterm"* ]]; then
  export TERM=xterm-256color
elif [[ "$TERM" == "screen"* ]]; then
  export TERM=screen-256color
fi

emulator() {
    pid=$$
    pid=$(ps -h -o ppid -p $pid 2>/dev/null)
    ps -h -o comm -p $pid 2>/dev/null;
}

whichTTY=$(tty | sed -e "s:/dev/::")
if [[ "$(emulator)" == "xterm" ]] || [[ "$(emulator)" == "luit" ]]; then
  [ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
  echo -e -n "\x1b[\x36 q" # changes to steady bar
  # echo -e -n "\x1b[\x30 q" # changes to blinking block
  # echo -e -n "\x1b[\x31 q" # changes to blinking block also
  # echo -e -n "\x1b[\x32 q" # changes to steady block
  # echo -e -n "\x1b[\x33 q" # changes to blinking underline
  # echo -e -n "\x1b[\x34 q" # changes to steady underline
  # echo -e -n "\x1b[\x35 q" # changes to blinking bar
elif [ $(command -v tmux) ] && [[ $TERM != screen* ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == tty2 || $whichTTY == pty* || $whichTTY == ttyv0 || $whichTTY == ttys00* ]] ; then
  # Check if fbterm installed and x server isn't running
  cd ~
  if [ $(command -v fbterm) ] && [[ $whichTTY == tty1 || $whichTTY == tty2 ]] ; then
    if [ $(command -v byobu) ] ; then
      exec fbterm -- bash -c 'TERM=fbterm exec byobu'
    else
      exec fbterm -- bash -c 'TERM=fbterm && [[ -n $(tmux ls 2>/dev/null) ]] && exec tmux attach || exec tmux'
    fi
  else
    if [ $(command -v byobu) ] ; then
      exec byobu # Disable byobu if it breaks colors of vim
    else
       [[ -n $(tmux ls 2>/dev/null) ]] && exec tmux attach || exec tmux
    fi
  fi
elif [ -z $TMUX ] && [ $(command -v zsh) ] && [ -z "$ZSH_VERSION" ] && [ -z "$ZSH_IS_RUNNING" ] && [ -f ~/.zshrc ] ; then
  export ZSH_IS_RUNNING=1
  exec zsh
fi

export VISUAL="vim"
export EDITOR="$VISUAL"
export PYTHONIOENCODING="UTF-8"
export PYTHONHTTPSVERIFY=0
export JAVA_TOOL_OPTIONS=" -Dfile.encoding=UTF8 "
export DOWNLOADER_ARGUMENTS="--continue=true --file-allocation=none --check-certificate=false --content-disposition-default-utf8=true --max-tries=0 --max-concurrent-downloads=150 --max-connection-per-server=16 --split=16 --min-split-size=1M --bt-max-peers=0 --bt-request-peer-speed-limit=100M --seed-ratio=0 --bt-detach-seed-only=true --parameterized-uri=true" # aria2 & bypy
if [ $(command -v aria2c) ] && aria2c --version | grep -q "Async DNS" && [ -f /etc/resolv.conf ] ; then
  export DOWNLOADER_ARGUMENTS="$DOWNLOADER_ARGUMENTS --async-dns-server=$(grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' /etc/resolv.conf | tr '\n' ',' | sed 's/,$//')" # aria2 & bypy
fi

function getCondaPath()
{
  if [[ -d "$HOME/Miniconda$1" ]]; then
    echo "$HOME/Miniconda$1"
  elif [[ -d "$HOME/miniconda$1" ]]; then
    echo "$HOME/miniconda$1"
  elif [[ -d "$HOME/Anaconda$1" ]]; then
    echo "$HOME/Anaconda$1"
  elif [[ -d "$HOME/anaconda$1" ]]; then
    echo "$HOME/anaconda$1"
  else
    echo ""
  fi;
}

CONDA_2=$(getCondaPath 2)

if [ -n $CONDA_2 ]; then
  export PATH=$CONDA_2/bin:$PATH
  alias conda2=$(echo $CONDA_2/bin/conda)
  alias pip2=$(echo $CONDA_2/bin/pip)
  upgradeConda2() { $(echo $CONDA_2/bin/conda) -n base conda -y; $(echo $CONDA_2/bin/conda) update --all --yes ;}
  upgradePip2() { $(echo $CONDA_2/bin/pip) install --upgrade pip && $(echo $CONDA_2/bin/pip) install --upgrade $(pip freeze -l | sed "s/==.*//") && $(echo $CONDA_2/bin/pip) install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && $(echo $CONDA_2/bin/pip) install --upgrade https://github.com/requests/requests/archive/master.zip ;}
fi

CONDA_3=$(getCondaPath 3)

if [ -n $CONDA_3 ]; then
  export PATH=$CONDA_3/bin:$PATH
  alias conda3=$(echo $CONDA_3/bin/conda)
  alias pip3=$(echo $CONDA_3/bin/pip)
  upgradeConda3() { $(echo $CONDA_3/bin/conda) -n base conda -y; $(echo $CONDA_3/bin/conda) update --all --yes ;}
  upgradePip3() { $(echo $CONDA_3/bin/pip) install --upgrade pip && $(echo $CONDA_3/bin/pip) install --upgrade $(pip freeze -l | sed "s/==.*//") && $(echo $CONDA_3/bin/pip) install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && $(echo $CONDA_3/bin/pip) install --upgrade https://github.com/requests/requests/archive/master.zip ;}
fi

[ -f $HOME/.pythonrc ] && export PYTHONSTARTUP=$HOME/.pythonrc
[ -f $HOME/.pythonrc.py ] && export PYTHONSTARTUP=$HOME/.pythonrc.py
[ -d $HOME/dotfile/grc ] && export PATH=$HOME/dotfile/grc:$PATH
[ -d $HOME/dotfile/neofetch ] && export PATH=$HOME/dotfile/neofetch:$PATH
[ -d $HOME/.linuxbrew ] && export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"

if [[ -d "$HOME/node" ]]; then
  export PATH=~/node/bin:$PATH
  alias upgradeNpm='~/node/bin/npm install -g npm@latest ; ~/node/bin/npm update -g'
fi

if [[ -d "$HOME/go" ]]; then
  export GOROOT="$HOME/go"
  export GOPATH="$GOROOT/tool"
  export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
fi
[ $(command -v go) ] && alias upgradeGo='go get -insecure -v -u all'

if [[ -d "$HOME/zulu" ]]; then
  export PATH=~/zulu/bin:$PATH
  export JAVA_HOME=~/zulu
fi

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH=~/.local/bin:$PATH
fi

if [[ -d "$HOME/bin" ]]; then
  export PATH=$PATH:$HOME/bin
fi

if [[ -d "/sbin" ]]; then
  export PATH=$PATH:/sbin
fi

if [[ -d "/usr/sbin" ]]; then
  export PATH=$PATH:/usr/sbin
fi

if [[ -d "/data/local/tmp" ]]; then
  # This is for Android
  # adb push ./aria2c /data/local/tmp
  export PATH=$PATH:/data/local/tmp
fi

if [[ -d "/opt/bin" ]]; then
  # This is for opkg
  export PATH=$PATH:/opt/bin
fi

if [[ -d "/usr/local/opt/coreutils/libexec/gnubin" ]]; then
  # This is for mac
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

if [[ -d "/usr/local/opt/coreutils/libexec/gnuman" ]]; then
  # This is for mac
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# [ $(command -v xterm) ] && alias xterm="xterm -bg black -fg white -fa 'Monospace' -fs 14 > /dev/null 2>&1 &!"
[ $(command -v xterm) ] && alias xterm="xterm > /dev/null 2>&1 &!"
[ $(command -v nano) ] && alias nano='nano --smarthome --nonewlines --nowrap --mouse --smooth --autoindent'
alias tmux2SplitHorizontal='tmux split-window -v'
alias tmux2SplitVertical='tmux split-window -h'
alias tmux3SplitHorizontal='tmux split-window -v && tmux split-window -v && tmux select-layout even-vertical'
alias tmux3SplitVertical='tmux split-window -h && tmux split-window -h && tmux select-layout even-horizontal'
alias tmux4Split='tmux split-window -h && tmux split-window -v && tmux select-pane -L && tmux split-window -v && tmux select-pane -U'
alias tmuxMoveUp='tmux select-pane -U'
alias tmuxMoveDown='tmux select-pane -D'
alias tmuxMoveLeft='tmux select-pane -L'
alias tmuxMoveRight='tmux select-pane -R'
alias tmuxResizeUp='tmux resize-pane -U'
alias tmuxResizeDown='tmux resize-pane -D'
alias tmuxResizeLeft='tmux resize-pane -L'
alias tmuxResizeRight='tmux resize-pane -R'
alias upgradeConda='conda update -n base conda -y && conda update --all --yes'
alias upgradeBypy='pip install --upgrade https://github.com/houtianze/bypy/archive/master.zip'
alias upgradeYoutubedl='pip install --upgrade https://github.com/rg3/youtube-dl/archive/master.zip'
alias upgradeYou-get='pip install --upgrade https://github.com/soimort/you-get/archive/develop.zip'
alias upgradeYkdl='pip install --upgrade https://github.com/zhangn1985/ykdl/archive/master.zip'
alias sudoRoot='sudo -H ' # $HOME = /root
alias sudoUser='sudo -E ' # $HOME = /home/$USER
alias you-getNtust='you-get -x 140.118.31.62:3128'
alias you-getYouku='you-get -y proxy.uku.im:443'
if [ $(command -v youtube-dl) ]; then
  alias wget='wget -c -e robots=off --tries=10 --connect-timeout=4 --max-time=5 --read-timeout=30 --verbose --user-agent="$(youtube-dl --dump-user-agent)"'
  alias curl='curl --retry 2 --retry-max-time 0 --user-agent "$(youtube-dl --dump-user-agent)" -LC - '
  [ $(command -v axel) ] && alias axel='axel --num-connections=16 --user-agent="$(youtube-dl --dump-user-agent)"'
else
  alias wget='wget -c -e robots=off --tries=10 --connect-timeout=4 --max-time=5 --read-timeout=30 --verbose'
  alias curl='curl --retry 10 --retry-max-time 0 -LC - '
  [ $(command -v axel) ] && alias axel='axel --num-connections=16'
fi
if [ $(command -v aria2c) ]; then
  alias youtube-dl='youtube-dl -o "%(title)s.%(ext)s" --write-sub --sub-lang zh-tw,zh-cn,zh-hk,zh-hant,zh-hans,zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --ignore-errors --external-downloader aria2c --external-downloader-args $DOWNLOADER_ARGUMENTS'
else
  alias youtube-dl='youtube-dl -o "%(title)s.%(ext)s" --write-sub --sub-lang zh-tw,zh-cn,zh-hk,zh-hant,zh-hans,zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --ignore-errors'
fi
alias curl-asus-proxy-kungfu='curl -x 10.78.20.186:3128 -U kungfu:howkungfu'
alias curl-asus-proxy-zscaler='curl -x gateway.zscaler.net:80'
alias which='which -a'
alias youtube-dl-240="youtube-dl -f 'bestvideo[height<=240][fps<=30]+bestaudio/best'"
alias youtube-dl-360="youtube-dl -f 'bestvideo[height<=360][fps<=30]+bestaudio/best'"
alias youtube-dl-480="youtube-dl -f 'bestvideo[height<=480][fps<=30]+bestaudio/best'"
alias youtube-dl-720="youtube-dl -f 'bestvideo[height<=720][fps<=30]+bestaudio/best'"
alias youtube-dl-1080="youtube-dl -f 'bestvideo[height<=1080][fps<=30]+bestaudio/best'"
alias youtube-dl-playlist="youtube-dl --yes-playlist -o '%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s'"
alias youtube-dl-thumbnail="youtube-dl --write-thumbnail --write-all-thumbnails --skip-download"
alias youtube-dl-filename-ascii="youtube-dl --restrict-filenames"
alias youtube-dl-annotations="youtube-dl --write-annotations"
alias youtube-dl-auto-sub="youtube-dl --write-auto-sub"
alias youtube-dl-audio='youtube-dl --extract-audio'
alias youtube-dl-audio-MP3='youtube-dl --extract-audio --audio-format mp3'
alias youtube-dl-audio-Opus='youtube-dl --extract-audio --audio-format opus'
alias youtube-dlNtust='youtube-dl --proxy 140.118.31.62:3128'
alias youtube-dlYouku='youtube-dl --proxy proxy.uku.im:443'
alias youtube-dl-asus-proxy-kungfu='youtube-dl --no-check-certificate --write-sub --sub-lang zh-tw,zh-cn,zh-hk,zh-hant,zh-hans,zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --external-downloader-args "-c -s16 -k1M -x16 -j16 --enable-rpc=false --all-proxy=kungfu:howkungfu@10.78.20.186:3128 --all-proxy-user=kungfu --all-proxy-passwd=howkungfu"'
alias youtube-dl-asus-proxy-zscaler='youtube-dl --no-check-certificate --write-sub --sub-lang zh-tw,zh-cn,zh-hk,zh-hant,zh-hans,zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --external-downloader-args "-c -s16 -k1M -x16 -j16 --enable-rpc=false --all-proxy=gateway.zscaler.net:80"'
alias youtube-dl-asus-crt='command youtube-dl --no-check-certificate --write-sub --sub-lang zh-tw,zh-cn,zh-hk,zh-hant,zh-hans,zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --external-downloader aria2c --external-downloader-args "--check-certificate=true --ca-certificate=$HOME/Documents/asus.com.crt -c -s16 -k1M -x16 -j16" -o "%(title)s.%(ext)s" --write-sub --sub-lang zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --ignore-errors'
alias aria2c='aria2c $(echo $DOWNLOADER_ARGUMENTS) --user-agent="$(youtube-dl --dump-user-agent)"'
alias aria2c-asus-proxy-kungfu='aria2c --all-proxy=kungfu:howkungfu@10.78.20.186:3128 --all-proxy-user=kungfu --all-proxy-passwd=howkungfu'
alias aria2c-asus-proxy-zscaler='aria2c --all-proxy=gateway.zscaler.net:80'
alias aria2c-asus-crt='command aria2c --check-certificate=true --ca-certificate=$HOME/Documents/asus.com.crt -c -s16 -k1M -x16 -j16'
alias aria2c-bt-qBittorrent='aria2c $(echo $DOWNLOADER_ARGUMENTS)  --user-agent="qBittorrent/4.1.1" --peer-id-prefix="-qB4110-" --enable-dht=true --bt-enable-lpd=true --enable-peer-exchange=true'
alias aria2c-bt-uTorrent='aria2c $(echo $DOWNLOADER_ARGUMENTS) --user-agent="uTorrent/341(109279400)(30888)" --peer-id-prefix="-UT341-" --enable-dht=true --bt-enable-lpd=true --enable-peer-exchange=true'
alias aria2c-bt-Transmission='aria2c $(echo $DOWNLOADER_ARGUMENTS) --user-agent="Transmission/2.77" --peer-id-prefix="-TR2770-" --enable-dht=true --bt-enable-lpd=true --enable-peer-exchange=true'
alias bypy='bypy -d --retry 1 --downloader aria2'
alias bypy-processes-2='bypy --processes 2'
alias bypy-processes-4='bypy --processes 4'
alias bypy-processes-8='bypy --processes 8'
alias bypy-processes-16='bypy --processes 16'
alias scp='scp -v'
alias UrlDecode='python2 -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias UrlEncode='python2 -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias ffmpeg='ffmpeg -err_detect ignore_err'
alias l='ls -lah'
alias ll='ls -lh'
alias ls='ls -F --color=auto --show-control-chars'
alias less='less -R'
alias termux-ssh-server-start='pkill sshd ; sshd && logcat -s "syslog:*"'
alias termux-scp='rsync --archive --new-compress --verbose --partial --partial-dir=.rsync-partial --progress --rsh="ssh -p8022"' # termux-scp root@192.168.78.100:~/storage/external-1/j.mp4 ~/Desktop
alias ssh-asus-inside='ssh joeky@10.78.20.186'
alias ssh-asus-ml='ssh joeky@zenboml-api.eastasia.cloudapp.azure.com'
alias ssh-asus-temp='ssh -p 50022 joeky@contextualintelligence-temp.southeastasia.cloudapp.azure.com'
alias ssh-asus-jump='ssh -p 22681 chungyi@ai800mjp01.southeastasia.cloudapp.azure.com'
alias ptt-ssh='ssh bbsu@ptt.cc'
alias ptt-telnet-443='telnet ptt.cc 443'
alias ptt-telnet-3000='telnet ptt.cc 3000'
alias chrome-ignoreCrt='google-chrome --ignore-certificate-errors'
alias google-chrome-ignoreCrt='google-chrome --ignore-certificate-errors'
alias opera-ignoreCrt='opera --ignore-certificate-errors'
alias opera-developer-ignoreCrt='opera-developer --ignore-certificate-errors'

export SUDO=''
if (( $EUID != 0 )); then
  export SUDO='sudo'
fi

export GREP_OPTIONS=""
if $(echo | grep --color=auto "" > /dev/null 2>&1); then
  export GREP_OPTIONS="$GREP_OPTIONS --color=auto"
fi
export VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"
if $(echo | grep --exclude-dir=.cvs "" > /dev/null 2>&1); then
  export GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$VCS_FOLDERS"
elif $(echo | grep --exclude=.cvs "" > /dev/null 2>&1); then
  export GREP_OPTIONS="$GREP_OPTIONS --exclude=$VCS_FOLDERS"
fi
alias grep="grep $GREP_OPTIONS"

proxyNtust() { export http_proxy="140.118.31.62:3128" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyYouku() { export http_proxy="proxy.uku.im:443" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyAsusZscaler() { export http_proxy="gateway.zscaler.net:80" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyAsusInToOut() { export http_proxy="kungfu:howkungfu@10.78.20.186:3128" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyAsusOutToIn() { export http_proxy="kungfu:howkungfu@ceasar.dlinkdns.com:5566" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyUnset() { unset http_proxy && unset https_proxy && unset ftp_proxy ;}
EncodingToEN() { export LANG="en_US.UTF-8" && export LC_CTYPE="en_US.UTF-8" && export LC_NUMERIC="en_US.UTF-8" && export LC_TIME="en_US.UTF-8" && export LC_COLLATE="en_US.UTF-8" && export LC_MONETARY="en_US.UTF-8" && export LC_MESSAGES="en_US.UTF-8" && export LC_ALL="en_US.UTF-8" ;}
EncodingToBig5() { export LANG="zh_TW.Big5" && export LC_CTYPE="zh_TW.Big5" && export LC_NUMERIC="zh_TW.Big5" && export LC_TIME="zh_TW.Big5" && export LC_COLLATE="zh_TW.Big5" && export LC_MONETARY="zh_TW.Big5" && export LC_MESSAGES="zh_TW.Big5" && export LC_ALL="zh_TW.Big5" ;}
EncodingToTwUtf8() { export LANG="zh_TW.UTF-8" && export LC_CTYPE="zh_TW.UTF-8" && export LC_NUMERIC="zh_TW.UTF-8" && export LC_TIME="zh_TW.UTF-8" && export LC_COLLATE="zh_TW.UTF-8" && export LC_MONETARY="zh_TW.UTF-8" && export LC_MESSAGES="zh_TW.UTF-8" && export LC_ALL="zh_TW.UTF-8" ;}
EncodingToGBK() { export LANG="zh_CN.GBK" && export LC_CTYPE="zh_CN.GBK" && export LC_NUMERIC="zh_CN.GBK" && export LC_TIME="zh_CN.GBK" && export LC_COLLATE="zh_CN.GBK" && export LC_MONETARY="zh_CN.GBK" && export LC_MESSAGES="zh_CN.GBK" && export LC_ALL="zh_CN.GBK" ;}
EncodingToChUtf8() { export LANG="zh_CN.UTF-8" && export LC_CTYPE="zh_CN.UTF-8" && export LC_NUMERIC="zh_CN.UTF-8" && export LC_TIME="zh_CN.UTF-8" && export LC_COLLATE="zh_CN.UTF-8" && export LC_MONETARY="zh_CN.UTF-8" && export LC_MESSAGES="zh_CN.UTF-8" && export LC_ALL="zh_CN.UTF-8" ;}
killallproc() { $SUDO kill -9 $(pgrep $@) ;}
killallStopped() { $SUDO kill -9 $(jobs -ps | cut -d' ' -f4) ;}
7zExtractToFolder() { 7z -o* x "$@" ;}
upgradePip() { pip install --upgrade pip && pip install --upgrade $(pip freeze -l | sed "s/==.*//") && pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
upgradeDotfile() {
  cd ~/dotfile
  git pull origin master
  git pull --recurse-submodules --depth 1
  git submodule update --init --recursive --remote --merge
  git submodule foreach git pull
  cd - ;

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
  rm -rf ~/.minttyrc
  rm -rf ~/.vimrc
  rm -rf ~/.pythonrc
  rm -rf ~/.pip/pip.conf
  rm -rf ~/pip/pip.ini
  rm -rf ~/.condarc
  rm -rf ~/.npmrc
  rm -rf ~/.yarnrc
  rm -rf ~/.config/nvim/init.vim
  rm -rf ~/AppData/Local/nvim/init.vim
  rm -rf ~/Documents/WindowsPowerShell/profile.ps1
  rm -rf ~/.grc

  mkdir -p ~/.grc
  ln -sf ~/dotfile/grc/grc.conf ~/.grc/grc.conf
  ln -sf ~/dotfile/grc/colourfiles/* ~/.grc/

  if [[ "$OSTYPE" == "cygwin" ]]; then
    mkdir -p ~/AppData/Local/nvim/
    mkdir -p ~/Documents/WindowsPowerShell
    mkdir -p ~/.pip/
    mkdir -p ~/pip/
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.minttyrc" "%USERPROFILE%\dotfile\Windows\.minttyrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.pythonrc" "%USERPROFILE%\dotfile\.pythonrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\pip\pip.ini" "%USERPROFILE%\dotfile\.pip.ini"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.pip\pip.conf" "%USERPROFILE%\dotfile\.pip.ini"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.condarc" "%USERPROFILE%\dotfile\.condarc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.npmrc" "%USERPROFILE%\dotfile\.npmrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.yarnrc" "%USERPROFILE%\dotfile\.yarnrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tigrc" "%USERPROFILE%\dotfile\.tigrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfile\.gitconfig"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitmessage" "%USERPROFILE%\dotfile\.gitmessage"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.Xresources" "%USERPROFILE%\dotfile\.Xresources"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1" "%USERPROFILE%\dotfile\powershell\profile.ps1"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\vimrc\.vimrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\AppData\Local\nvim\init.vim" "%USERPROFILE%\dotfile\vimrc\.vimrc"
  else
    mkdir -p ~/.config/nvim/
    mkdir -p ~/.pip/
    ln -sf $HOME/dotfile/.bashrc ~/.bashrc
    ln -sf $HOME/dotfile/.bashrc ~/.bash_profile
    ln -sf $HOME/dotfile/.tmux.conf ~/.tmux.conf
    ln -sf $HOME/dotfile/.bashrc ~/.zshrc
    ln -sf $HOME/dotfile/.pythonrc ~/.pythonrc
    ln -sf $HOME/dotfile/.pip.ini ~/.pip/pip.conf
    ln -sf $HOME/dotfile/.condarc ~/.condarc
    ln -sf $HOME/dotfile/.npmrc ~/.npmrc
    ln -sf $HOME/dotfile/.yarnrc ~/.yarnrc
    ln -sf $HOME/dotfile/.tigrc ~/.tigrc
    ln -sf $HOME/dotfile/.gitconfig ~/.gitconfig
    ln -sf $HOME/dotfile/.gitmessage ~/.gitmessage
    ln -sf $HOME/dotfile/.fbtermrc ~/.fbtermrc
    ln -sf $HOME/dotfile/.xprofile ~/.xprofile
    ln -sf $HOME/dotfile/.Xresources ~/.Xresources
    ln -sf $HOME/dotfile/.minttyrc ~/.minttyrc
    ln -sf $HOME/dotfile/vimrc/.vimrc ~/.vimrc
    ln -sf $HOME/dotfile/vimrc/.vimrc ~/.config/nvim/init.vim
  fi;
}

stty -ixon -ixoff # In order to use Ctrl Q and ctrl S
stty lnext '^-' stop undef start undef -ixon # Unbind Ctrl V, replace with Ctrl _

if [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; then
  gvim()
  {
    gv=$( [ -f $(cygpath $ProgramData/chocolatey/bin/gvim.exe) ] && cygpath $ProgramData/chocolatey/bin/gvim.exe || cygpath $USERPROFILE/scoop/shims/gvim.exe )
    if [ "$#" == 0 ]; then
      $gv &!
    else
      $gv -p --remote-tab-silent "$@" &!
    fi;
  }
elif [ $(command -v gvim) ]; then
  gvim()
  {
    if [ "$#" == 0 ]; then
      command gvim > /dev/null 2>&1
    else
      command gvim -p --remote-tab-silent "$@" > /dev/null 2>&1
    fi;
  }
fi
if [ $(command -v nvim) ]; then
  nvim()
  {
    if [ "$#" == 0 ]; then
      command nvim -u ~/.vimrc
    else
      command nvim -u ~/.vimrc -p "$@"
    fi;
  }
fi
if [ $(command -v mvim) ]; then # MacVim
  mvim()
  {
    if [ "$#" == 0 ]; then
      command mvim > /dev/null 2>&1
    else
      command mvim -p --remote-tab-silent "$@" > /dev/null 2>&1
    fi;
  }
fi

git_branch_info() {
  if git rev-parse --git-dir 1>/dev/null 2>&1; then
    echo "* $(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  fi;
}

if [[ -n "$ZSH_VERSION" ]]; then # Zsh
  export ZSH=$HOME/dotfile/oh-my-zsh
  ZSH_THEME=""
#   plugins=($(find $ZSH/plugins -maxdepth 1 -printf "%f "))
  plugins=(git docker docker-compose adb)
  DISABLE_AUTO_UPDATE="true"
  if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
    compdef vman=man # Complete vman as man command
    compdef Forever=sudo # Complete Forever as sudo command
    [ $(command -v pacman) ] && compdef powerpill=pacman # Complete powerpill as pacman command
    [ $(command -v pacman) ] && compdef yaourt=pacman # Complete yaourt as pacman command
    [ $(command -v apt) ] && compdef apt-fast=apt # Complete apt-fast as apt command
    compdef CompleteAptCyg apt-cyg # Complete apt-cyg
    unset -f upgrade_oh_my_zsh # Remove this function

  else # Oh-my-zsh is not available
    alias -g ...='../..'
    alias -g ....='../../..'
    export HISTSIZE=10000
    export SAVEHIST=10000
    WORDCHARS='' # More completion
    bindkey -e # emacs keys
    unsetopt flowcontrol # Unbind Ctrl-S
    unsetopt menu_complete # Don't autoselect the first completion entry
    autoload -U +X compinit && compinit
    autoload -U +X colors && colors
    zmodload -i zsh/complist
    zstyle ':completion:*:*:*:*:*' menu select# selected entry highlighting
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*' # Case insensitive
    zstyle '*' single-ignored show # Don't show menu when there is only one match
    zstyle ':completion:*' list-colors '' # Popup colors
#     PROMPT="%B%F{red}%n%B%F{yellow}@%B%F{green}%M %{$reset_color%}\n➜ %B%F{blue}%~"${NEWLINE_NO_OMZ}"%{$reset_color%}$ "
  fi
  autoload bashcompinit && bashcompinit
  autoload -U add-zsh-hook
  if (( $EUID != 0 )); then
    export MAIN_THEME='green'
  else
    export MAIN_THEME='red'
  fi
  update_prompt() {
    NEWLINE_NO_OMZ=$'\n'
    # %B=light_color %F=color %K=background
    PROMPT="╭─%B%F{$MAIN_THEME}%n@%M%F{blue} %~%F{yellow}%K{default} $(git_branch_info) "${NEWLINE_NO_OMZ}"%K{default}%F{default}╰─> "
  }
  update_prompt
  add-zsh-hook chpwd update_prompt
  add-zsh-hook preexec update_prompt
  add-zsh-hook precmd update_prompt
  zle_highlight=(none)
  if [ -f $HOME/dotfile/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source $HOME/dotfile/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    typeset -A ZSH_HIGHLIGHT_STYLES
    zle_highlight=(default:bold)
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root line)
    #################
    #      None     #
    #################
    ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
    #################
    #      Blue     #
    #################
    ZSH_HIGHLIGHT_STYLES[default]='fg=39'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=39'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=39'
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=39'
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=39'
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=39'
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=39'
    #################
    #    LightBlue  #
    #################
    ZSH_HIGHLIGHT_STYLES[path]='fg=81'
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=81'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=81'
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=81'
    #################
    #      Red      #
    #################
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=161'
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=161'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=161'
    #################
    #     Green     #
    #################
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=118'
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=118'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=118'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=118'
    ZSH_HIGHLIGHT_STYLES[command]='fg=118'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=118'
    ZSH_HIGHLIGHT_STYLES[function]='fg=118'
    ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=118'
    ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=118'
    #################
    #     Orange    #
    #################
    ZSH_HIGHLIGHT_STYLES[assign]='fg=208'
    ZSH_HIGHLIGHT_STYLES[arg0]='fg=208'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=208'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=208'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=208'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=208'
    #################
    #      Gray     #
    #################
    ZSH_HIGHLIGHT_STYLES[comment]='fg=59'
  fi
  export KEYTIMEOUT=1 # Make ESC faster
  setopt NO_NOMATCH # disable zsh match filename
  setopt complete_in_word # Move cursor to the end when completion
  setopt always_to_end # Move cursor to the end when completion
  setopt nonomatch # Disable warning when completion not found
  _comp_options+=(globdots) # Show hidden files when using completion
  zstyle ':completion:*' special-dirs false # Don't complete ./ and ../
  zle -N PasteFromClipboard # Bind function to command
  zle -N CutToClipboard # Bind function to command
  zle -N Forever # Bind function to command
  zle -N OpenFileExplorer # Bind function to command
  HISTFILE=$HOME/.bash_history
  alias history='fc -ln 1' # bash-like history
  unsetopt EXTENDED_HISTORY # Use bash-like history
  unsetopt SHARE_HISTORY # Use bash-like history
  unsetopt INC_APPEND_HISTORY_TIME # Use bash-like history
  unsetopt AUTOCD # Don't cd to the directory by just typing its name
  setopt INC_APPEND_HISTORY # Use bash-like history
  [ $(command -v pip) ] && eval "`pip completion --zsh --disable-pip-version-check`"

  # alt + arrow key to move
  bindkey "^[[1;3C" forward-word
  bindkey "^[[1;3D" backward-word
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
  bindkey "\e\eOC" forward-word
  bindkey "\e\eOD" backward-word
  bindkey "\e\e[C" forward-word
  bindkey "\e\e[D" backward-word

  # Up/Down keys for searching history
  autoload -U up-line-or-beginning-search
  autoload -U down-line-or-beginning-search
  zle -N up-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "\e\eA" up-line-or-beginning-search
  bindkey "\e\eB" down-line-or-beginning-search
  bindkey "^[[A" up-line-or-beginning-search
  bindkey "^[[B" down-line-or-beginning-search
  bindkey "^[OA" up-line-or-beginning-search
  bindkey "^[OB" down-line-or-beginning-search

  bindkey "^N" forward-word
  bindkey "^P" backward-word
  bindkey "^B" backward-kill-word
  bindkey '^A' beginning-of-line
  bindkey '^E' end-of-line
  bindkey '^R' history-incremental-search-backward
  bindkey "\e\e^H" backward-kill-word # Alt + Backspace
  bindkey "^[^?" backward-kill-word # Alt + Backspace
  bindkey "\e\C-?" backward-kill-word # Alt + Backspace
  bindkey "^Z" undo
  bindkey "^Y" redo
  bindkey "^V" PasteFromClipboard # Ctrl V to paste from Clipboard.txt
  bindkey "^X" CutToClipboard # Ctrl X to cut to Clipboard.txt
  bindkey "^F" Forever # Ctrl F to run a command Forever
  bindkey "^O" OpenFileExplorer # Ctrl F to run a command Forever
elif [[ -n "$BASH_VERSION" ]]; then # Bash
  complete -cf sudo # complete sudo command
  complete -cf man # complete man command
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  elif [ -f /usr/local/share/bash-completion/bash_completion.sh ]; then
    source /usr/local/share/bash-completion/bash_completion.sh
  elif [ -f /usr/local/share/bash-completion/bash_completion ]; then
    source /usr/local/share/bash-completion/bash_completion
  elif [ -d "/usr/local/etc/bash_completion.d" ]; then # FreeBSD
    for f in /usr/local/etc/bash_completion.d/*; do
      source $f
    done
  fi
  [ $(command -v pip) ] && eval "`pip completion --bash --disable-pip-version-check`"
  export HISTCONTROL=ignoredups:erasedups # Ignore duplicate entries in .bash_history
  export HISTFILESIZE=
  export HISTSIZE=
  shopt -s histappend # Append history
  shopt -s checkwinsize # Checks the window size after each command
  PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND" # Write history immediately
  if [[ $- =~ i ]]; then
    bind 'set bell-style none' # Disable beep sound
    bind 'set completion-ignore-case on' # Ignore case
    bind '"\e[A": history-search-backward' # Up key is searching backward
    bind '"\e[B": history-search-forward'  # Down key is searching forward
    bind '\C-B:backward-kill-word'
    bind '\C-Z:undo'
    bind '\C-Y:redo'
    bind '\C-K:kill-whole-line'
    # alt + arrow key to move
    bind '"^[[1;3C": forward-word'
    bind '"^[[1;3D": backward-word'
    bind '"^[[1;5C": forward-word'
    bind '"^[[1;5D": backward-word'
    bind '"\e\eOC": forward-word'
    bind '"\e\eOD": backward-word'
    bind '"\e\e[C": forward-word'
    bind '"\e\e[D": backward-word'
    bind '"\e[1;3C": forward-word'
    bind '"\e[1;3D": backward-word'
    bind 'set show-all-if-ambiguous on'
    bind -x '"\C-X": CutToClipboard'  # Ctrl V to paste from Clipboard.txt
    bind -x '"\C-V": PasteFromClipboard'  # Ctrl V to paste from Clipboard.txt
    bind -x '"\C-F": Forever'  # Ctrl F to run a command Forever
    bind -x '"\C-O": OpenFileExplorer'  # Ctrl O to open file explorer here
  fi
  if [ $(command -v tput) ]; then
    export COLOR_RESET="\[$(tput sgr0)\]" # No Color
    export COLOR_RED="\[$(tput setaf 1)\]"
    export COLOR_GREEN="\[$(tput setaf 2)\]"
    export COLOR_YELLOW="\[$(tput setaf 3)\]"
    export COLOR_BLUE="\[$(tput setaf 4)\]"
    export COLOR_PURPLE="\[$(tput setaf 5)\]"
    export COLOR_CYAN="\[$(tput setaf 6)\]"
    export COLOR_GRAY="\[$(tput setaf 7)\]"
    export COLOR_LIGHT_RED="\[$(tput setaf 1; tput bold)\]"
    export COLOR_LIGHT_GREEN="\[$(tput setaf 2; tput bold)\]"
    export COLOR_LIGHT_YELLOW="\[$(tput setaf 3; tput bold)\]"
    export COLOR_LIGHT_BLUE="\[$(tput setaf 4; tput bold)\]"
    export COLOR_LIGHT_PURPLE="\[$(tput setaf 5; tput bold)\]"
    export COLOR_LIGHT_CYAN="\[$(tput setaf 6; tput bold)\]"
    export COLOR_LIGHT_GRAY="\[$(tput setaf 7; tput bold)\]"

    export COLOR_BG_RESET="\[$(tput sgr0)\]" # No Color
    export COLOR_BG_RED="\[$(tput setab 1)\]"
    export COLOR_BG_GREEN="\[$(tput setab 2)\]"
    export COLOR_BG_YELLOW="\[$(tput setab 3)\]"
    export COLOR_BG_BLUE="\[$(tput setab 4)\]"
    export COLOR_BG_PURPLE="\[$(tput setab 5)\]"
    export COLOR_BG_CYAN="\[$(tput setab 6)\]"
    export COLOR_BG_GRAY="\[$(tput setab 7)\]"
    export COLOR_BG_LIGHT_RED="\[$(tput setab 1; tput bold)\]"
    export COLOR_BG_LIGHT_GREEN="\[$(tput setab 2; tput bold)\]"
    export COLOR_BG_LIGHT_YELLOW="\[$(tput setab 3; tput bold)\]"
    export COLOR_BG_LIGHT_BLUE="\[$(tput setab 4; tput bold)\]"
    export COLOR_BG_LIGHT_PURPLE="\[$(tput setab 5; tput bold)\]"
    export COLOR_BG_LIGHT_CYAN="\[$(tput setab 6; tput bold)\]"
    export COLOR_BG_LIGHT_GRAY="\[$(tput setab 7; tput bold)\]"
    if (( $EUID != 0 )); then
      export MAIN_THEME=$COLOR_LIGHT_GREEN
      export MATIN_DOLOR="$"
    else
      export MAIN_THEME=$COLOR_LIGHT_RED
      export MATIN_DOLOR="#"
    fi
    # USER@DOMAIN directory
    bashprompt(){
      export PS1="╭─${MAIN_THEME}\u@\h ${COLOR_LIGHT_BLUE}\w ${COLOR_LIGHT_YELLOW}\[$(git_branch_info)\]${COLOR_RESET}\n╰─${MATIN_DOLOR} "
    }
    PROMPT_COMMAND=bashprompt
  fi
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then # Ubuntu
  RestartNetworking() {
    $SUDO systemctl restart networking.service
    $SUDO systemctl restart dnsmasq.service
    $SUDO systemctl restart systemd-hostnamed.service
    $SUDO ip -s -s neigh flush all
    $SUDO ifdown --exclude=lo -a && sudo ifup --exclude=lo -a
    $SUDO systemctl restart teamviewerd.service;
    $SUDO systemctl restart NetworkManager.service
  }
elif [[ "$OSTYPE" == "linux-android" ]]; then # Android Termux
  alias ls='ls -F --color=auto'
  export SUDO=""
elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
  if [ $(command -v gls) ]; then
    alias ls='gls -F --color=auto --show-control-chars'
  fi
  alias grep='grep --color=auto'
elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
  export DISPLAY=:0.0
  export SUDO=""
  export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
  alias apt-cyg-Manage='setup-x86_64.exe --package-manager --wait'
  alias apt-cyg-Upgrade="aria2c 'https://cygwin.com/setup-x86_64.exe' && install setup-x86_64.exe /bin && rm setup-x86_64.exe && setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --upgrade-also --delete-orphans"
  alias sudo='cygstart --action=runas "$@"'
  alias mtuForWifiGaming='cygstart --action=runas netsh interface ipv4 set subinterface Wi-Fi mtu=296  store=persistent'
  alias mtuForWifiNormal='cygstart --action=runas netsh interface ipv4 set subinterface Wi-Fi mtu=1500 store=persistent'
elif [[ "$OSTYPE" == "msys" ]]; then # Msys
  cd ~
  export SUDO=""
elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
  alias ls='ls -G'
  alias grep='grep --color=auto'
else # Unknown OS
  true
fi

# Faster navigating, overwrite oh-my-zsh settings
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

if [ $(command -v grc) ] ; then
  cmds=(  ant \
          as \
          blkid \
          cvs \
          df \
          diff \
          dig \
          dnf \
          docker \
          docker-compose \
          docker-machine \
          du \
          env \
          esperanto \
          fdisk \
          findmnt \
          free \
          gcc \
          getfacl \
          getsebool \
          gmake \
          id \
          ifconfig \
          iostat \
          ip \
          iproute \
          iptables \
          irclog \
          iwconfig \
          journalctl \
          last \
          lastb \
          lastlog \
          ld \
          ldap \
          log \
          lolcat \
          lsattr \
          lsblk \
          lsmod \
          lsof \
          lspci \
          make \
          mount \
          mtr \
          mvn \
          netstat \
          nmap \
          ntpdate \
          php \
          ping \
          ping2 \
          ping3 \
          ping6 \
          proftpd \
          ps \
          pv \
          sar \
          semanage \
          sensors \
          showmount \
          sql \
          ss \
          stat \
          sysctl \
          systemctl \
          tcpdump \
          traceroute \
          traceroute6 \
          tune2fs \
          uptime \
          vmstat \
          w \
          wdiff \
          who \
          whois
  );

  # Set alias for available commands.
  for cmd in "${cmds[@]}" ; do
    if [[ -n "$ZSH_VERSION" ]] && [ $(command -v $cmd) ] && [[ $(type compdef &>/dev/null) -eq 0 ]] && type _$cmd &>/dev/null ; then
      eval "function $cmd { grc -es --colour=auto $(command -v $cmd) \"\$@\" }"
      eval "compdef _$cmd $cmd"
    else
      [ $(command -v $cmd) ] && alias $cmd="grc -es --colour=auto $(command -v $cmd)"
    fi
  done

  alias configure='grc -es --colour=auto ./configure'
  alias jobs='grc -es --colour=auto bash -c "jobs $@"'
  alias limit='grc -es --colour=auto bash -c "limit $@"'
  alias ulimit='grc -es --colour=auto bash -c "ulimit $@"'

  # Clean up variables
  unset cmds cmd
fi

if ! [ $(command -v tree) ]; then
  tree()
  {
python3 <<END
import os

for root, dirs, files in os.walk("."):
  level = root.replace(".", '').count(os.sep)
  indent = ' ' * 4 * (level)
  print('{}{}/'.format(indent, os.path.basename(root)))
  subindent = ' ' * 4 * (level + 1)
  for f in files:
    print('{}{}'.format(subindent, f))

END
  }
fi

vman() {
  # for FreeBSD/MacOS, col -b removes backspaces, col -x replace tabs with spaces
  man $@ | col -bx | vim +"setlocal buftype=nofile" +"set filetype=man" - # buftype=nofile Make it read only and quit easily
}

curlToAria2()
{
  PARAMS=""

  for PARAM in "$@"
  do
    PARAMS="${PARAMS} '${PARAM}'"
  done

  # Need to be updated
  PARAMS=$( echo $PARAMS | sed s/"Range: bytes.\+\-"/A:b/g | sed "s/'-H'/--header/g" | sed "s/ '--compressed'//g" )

  echo "aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
  eval "aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
  while [ $? -ne 0 ]; do
    echo "Retrying curlToAria2 ..."
    echo "aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
    eval "aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
  done;
}

unzipToBig5py3()
{
  export zipfilename="$@"
  export zipfilepwd=""

  echo -n "Input zip password:"
  read zipfilepwd
  python3 <<END
import zipfile, sys, os

zipfilepwd = os.environ['zipfilepwd'] or ""

with zipfile.ZipFile(os.environ['zipfilename']) as file:
  for name in file.namelist():
    utf8name = name.encode('cp437').decode('Big5')
    pathname = os.path.dirname(utf8name)
    if not os.path.exists(pathname) and pathname!= "":
      os.makedirs(pathname)
    else:
      data = file.read(name, pwd=zipfilepwd.encode())
      if not os.path.exists(utf8name):
        fo = open(utf8name, "wb")
        fo.write(data)
        fo.close
file.close()

END
  unset zipfilename;
}

unzipToGBKpy3()
{
  export zipfilename="$@"
  export zipfilepwd=""

  echo -n "Input zip password:"
  read zipfilepwd
  python3 <<END
import zipfile, sys, os

zipfilepwd = os.environ['zipfilepwd'] or ""

with zipfile.ZipFile(os.environ['zipfilename']) as file:
  for name in file.namelist():
    utf8name = name.encode('cp437').decode('GBK')
    pathname = os.path.dirname(utf8name)
    if not os.path.exists(pathname) and pathname!= "":
      os.makedirs(pathname)
    else:
      data = file.read(name, pwd=zipfilepwd.encode())
      if not os.path.exists(utf8name):
        fo = open(utf8name, "wb")
        fo.write(data)
        fo.close
file.close()

END
  unset zipfilename;
}

unzipToBig5py2()
{
  export zipfilename="$@"
  export zipfilepwd=""

  echo -n "Input zip password:"
  read zipfilepwd

  python2 <<END
import os, sys, zipfile
zipfilepwd = os.environ['zipfilepwd'] or ""
file = zipfile.ZipFile(os.environ['zipfilename'],"r");
for name in file.namelist():
  utf8name = name.decode('big5')
  pathname = os.path.dirname(utf8name)
  if not os.path.exists(pathname) and pathname!= "":
    os.makedirs(pathname)
  data = file.read(name, zipfilepwd)
  if not os.path.exists(utf8name):
    fo = open(utf8name, "w")
    fo.write(data)
    fo.close
file.close()
END
  unset zipfilename;
}

unzipToGBKpy2()
{
  export zipfilename="$@"
  export zipfilepwd=""

  echo -n "Input zip password:"
  read zipfilepwd

  python2 <<END
import os, sys, zipfile
zipfilepwd = os.environ['zipfilepwd'] or ""
file = zipfile.ZipFile(os.environ['zipfilename'],"r");
for name in file.namelist():
  utf8name = name.decode('gbk')
  pathname = os.path.dirname(utf8name)
  if not os.path.exists(pathname) and pathname!= "":
    os.makedirs(pathname)
  data = file.read(name, zipfilepwd)
  if not os.path.exists(utf8name):
    fo = open(utf8name, "w")
    fo.write(data)
    fo.close
file.close()
END
  unset zipfilename;
}

CutToClipboard()
{
  if [[ -n "$ZSH_VERSION" ]]; then
    echo "$LBUFFER" > $HOME/.vim/clipboard.txt
    LBUFFER="" ;

  elif [[ -n "$BASH_VERSION" ]]; then
    # Currently, bash can not bind C-x but I'll leave this here
    echo "$READLINE_LINE" > $HOME/.vim/clipboard.txt
    READLINE_LINE="" ;
  fi
  chmod 777 $HOME/.vim/clipboard.txt;
}

PasteFromClipboard()
{
  if [[ -f $HOME/.vim/clipboard.txt ]]; then
    if [[ -n "$ZSH_VERSION" ]]; then
      CLIP=$(cat $HOME/.vim/clipboard.txt)
      LBUFFER="$LBUFFER$CLIP"
    elif [[ -n "$BASH_VERSION" ]]; then
      CLIP=$(cat $HOME/.vim/clipboard.txt)
      COUNT=$(echo -n "$CLIP" | wc -c)
      READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${CLIP}${READLINE_LINE:$READLINE_POINT}"
      READLINE_POINT=$(($READLINE_POINT + $COUNT))
    fi
  fi;
}

CompleteAptCyg()
{
  local -a options
  local -a cmd
  cmd=(
    "install:to install packages"
    "resume-install: to resume interrupted installing"
    "remove:to remove packages"
    "update:to update setup.ini"
    "show:to show installed packages"
    "find:to find packages matching patterns"
    "search:to search packages on cygwin.com"
    "describe:to describe packages matching patterns"
    "packageof:to locate parent packages"
  )
  options=(
    {-j,--jobs}:"number of projects to check simultaneously"
    {-h,--help}:"number 1 to check simultaneously"
    --charch:"change archetecture"
    --use-setuprc:"set cache and mirror with /etc/setup/setup.rc"
    --force:"force install/remove/fetch trustedkeys"
    --max-connections:"maximum number of connections"
    {--ignore-case,-i}:"ignore case distinctions for patterns"
    {--no-file-alloc,-n}:"doesn't allocate file space before downloading"
    {--mirror,-m}:"set mirror"
    {--cache,-c}:"set cache folder"
    {--file,-f}:"read package names from file"
    {--yes-to-all,-y}:"force yes on ask prompts"
    "--version"
  )
  _describe 'values' options;
  _describe 'commands' cmd;
}

Forever()
{
  # Hit Ctrl-F to complete Forever function
  # Forever loop until the job is done
  # while true; do $* ; if [ $? -eq 0 ]; then break; fi; done ;
  if [[ -n "$ZSH_VERSION" ]]; then
    BUFFER='while true; do '$BUFFER' ; if [ $? -eq 0 ]; then break; fi; done ;'
  elif [[ -n "$BASH_VERSION" ]]; then
    READLINE_LINE='while true; do '$READLINE_LINE' ; if [ $? -eq 0 ]; then break; fi; done ;'
  fi;
}

OpenFileExplorer()
{
  if [[ "$OSTYPE" == "linux-gnu" || "$OSTYPE" == "freebsd"* ]]; then # Linux + FreeBSD
    xdg-open . > /dev/null 2>&1 &!;
  elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then # Windows
    explorer.exe .
  elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
    open .
  else # Unknown OS
    true
  fi;
}

ChrootHome()
{
  unset LD_PRELOAD

  newhome=$1

  echo 'export CHARSET=UTF-8
export PAGER=less
umask 022
for script in /etc/profile.d/*.sh ; do
if [ -r \$script ] ; then
  . \$script
fi
done
alias ls="ls --color=auto"
alias ll="ls --color=auto -alh"
alias l="ls --color=auto -alh"
export Blk="\e[0;30m"
export Red="\e[0;31m"
export Gre="\e[0;32m"
export Yel="\e[0;33m"
export Blu="\e[0;34m"
export Pur="\e[0;35m"
export Cya="\e[0;36m"
export Whi="\e[0;37m"
export BBla="\e[1;30m"
export BRed="\e[1;31m"
export BGre="\e[1;32m"
export BYel="\e[1;33m"
export BBlu="\e[1;34m"
export BPur="\e[1;35m"
export BCya="\e[1;36m"
export BWhi="\e[1;37m"
export PS1="╭─${BRed}\\\\u@\h ${BGre}\w${BWhi} \n╰─# "
export HOME=/root
export PATH=/bin:/usr/bin:/sbin:/usr/sbin
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"' > $newhome/etc/profile

  [ -f /etc/resolv.conf ] && cat /etc/resolv.conf > $newhome/etc/resolv.conf
  [ -f /system/etc/resolv.conf ] && cat /system/etc/resolv.conf > $newhome/etc/resolv.conf
  [ $(command -v getprop) ] && getprop | sed -n -e 's/^\[net\.dns.\]: \[\(.*\)\]/\1/p' | sed '/^\s*$/d' | sed 's/^/nameserver /' > $newhome/etc/resolv.conf

  export SUDO=''
  if (( $EUID != 0 )); then
    export SUDO='sudo'
  fi

  export CHROOT_SHELL=/bin/sh
  [ -f $newhome/bin/bash ] && CHROOT_SHELL=/bin/bash
  [ -f $newhome/bin/zsh ] && CHROOT_SHELL=/bin/zsh

  cd $newhome # This isn't necessary
  if [ $(command -v proot) ]; then
    proot --link2symlink -0 -r $newhome -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /usr/bin/env -i HOME=/root TERM="$TERM" LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin $CHROOT_SHELL --login
  elif [ $(command -v fakechroot) ] && [ $(command -v fakeroot) ]; then
    fakechroot fakeroot chroot $PWD $CHROOT_SHELL -l
  else
    $SUDO chroot $PWD $CHROOT_SHELL -l
  fi;
}

StartAlpine()
{
  export newhome=$HOME/Alpine
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/main/"       > $newhome/etc/apk/repositories; \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community/" >> $newhome/etc/apk/repositories; \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/"   >> $newhome/etc/apk/repositories

  ChrootHome $newhome
}

StartArch()
{
  export newhome=$HOME/Arch
  ChrootHome $newhome
}

dict() {
  if [ $# -eq 0 ]; then
    echo "Usage: dict <word>"
  else
    grep $GREP_OPTIONS --color=auto -RiIn -C 5 $1 $HOME/dict
  fi;
}

finish() {
  if [[ "$TERM" = "screen" ]] && [[ -n "$TMUX" ]]; then
    true
#     TODO
#     Do somethihng when bash is closing
  fi;
}
trap finish EXIT

