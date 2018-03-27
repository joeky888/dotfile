if [[ "$TERM" == "xterm"* ]]; then
  export TERM=xterm-256color
elif [[ "$TERM" == "screen"* ]]; then
  export TERM=screen-256color
fi

whichTTY=$(tty | sed -e "s:/dev/::")
if [ $(command -v tmux) ] ; then
  if [[ $TERM != screen* ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == tty2 || $whichTTY == pty* || $whichTTY == ttyv0 || $whichTTY == ttys00* ]] ; then
    cd ~
    # Check if fbterm installed and x server isn't running
    if [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == tty2 || $whichTTY == pty* || $whichTTY == ttyv0 || $whichTTY == ttys00* ]] ; then
      if [ $(command -v fbterm) ] && [[ $whichTTY == tty1 || $whichTTY == tty2 ]] ; then
        if [ $(command -v byobu) ] ; then
          exec fbterm -- bash -c 'TERM=fbterm exec byobu'
        else
          exec fbterm -- bash -c 'TERM=fbterm exec tmux'
        fi
      else
        if [ $(command -v byobu) ] ; then
          exec byobu
        else
          exec tmux
        fi
      fi
    fi
  fi
elif [ $(command -v zsh) ] && ! [[ -n "$ZSH_VERSION" ]] ; then
  exec zsh
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
export VISUAL="vim"
export EDITOR="$VISUAL"
export PYTHONIOENCODING="UTF-8"
export PYTHONHTTPSVERIFY=0
export JAVA_TOOL_OPTIONS=" -Dfile.encoding=UTF8 "
export DOWNLOADER_ARGUMENTS="--continue=true --file-allocation=none --check-certificate=false --content-disposition-default-utf8=true --max-tries=0 --max-concurrent-downloads=150 --max-connection-per-server=16 --split=16 --min-split-size=1M --bt-max-peers=0 --bt-request-peer-speed-limit=100M --seed-ratio=0 --bt-detach-seed-only=true --parameterized-uri=true" # aria2 & bypy
if [[ $(command -v aria2c) ]]; then
  if [[ $(aria2c --version | grep "Async DNS") ]]; then
    export DOWNLOADER_ARGUMENTS="$DOWNLOADER_ARGUMENTS --async-dns-server=8.8.8.8,180.76.76.76" # aria2 & bypy
  fi
fi

[[ $(command -v xterm) ]] && alias xterm="xterm -bg black -fg white -fa 'Ubuntu Mono' -fs 24"
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
if [[ $(command -v youtube-dl) ]]; then
  alias wget='wget -c -e robots=off --tries=10 --read-timeout=30 --verbose --user-agent="$(youtube-dl --dump-user-agent)"'
  alias curl='curl --retry 999 --retry-max-time 0 --user-agent "$(youtube-dl --dump-user-agent)" -LC - '
else
  alias wget='wget -c -e robots=off --tries=10 --read-timeout=30 --verbose'
  alias curl='curl --retry 999 --retry-max-time 0 -LC - '
fi
if [[ $(command -v aria2c) ]]; then
  alias youtube-dl='youtube-dl -o "%(title)s.%(ext)s" --write-sub --sub-lang zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --ignore-errors --external-downloader aria2c --external-downloader-args $DOWNLOADER_ARGUMENTS'
else
  alias youtube-dl='youtube-dl -o "%(title)s.%(ext)s" --write-sub --sub-lang zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --ignore-errors'
fi
alias curl-asus='curl -x 10.78.20.186:3128 -U kungfu:howkungfu'
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
alias youtube-dl-asus-proxy='youtube-dl --no-check-certificate --external-downloader-args "-c -s16 -k1M -x16 --enable-rpc=false --all-proxy=kungfu:howkungfu@10.78.20.186:3128 --all-proxy-user=kungfu --all-proxy-passwd=howkungfu"'
alias youtube-dl-asus-crt='command youtube-dl --no-check-certificate --external-downloader aria2c --external-downloader-args "--check-certificate=true --ca-certificate=$HOME/Documents/asus.com.crt -c -s16 -k1M -x16" -o "%(title)s.%(ext)s" --write-sub --sub-lang zh-TW,zh-HK,zh-Hant,zh-CN,zh-Hans,en,enUS,English --ignore-errors'
alias aria2c='aria2c $(echo $DOWNLOADER_ARGUMENTS) --user-agent="$(youtube-dl --dump-user-agent)"'
alias aria2c-asus-proxy='aria2c --all-proxy=kungfu:howkungfu@10.78.20.186:3128 --all-proxy-user=kungfu --all-proxy-passwd=howkungfu'
alias aria2c-asus-crt='command aria2c --check-certificate=true --ca-certificate=$HOME/Documents/asus.com.crt -c -s16 -k1M -x16'
alias aria2c-bt-qBittorrent='aria2c $(echo $DOWNLOADER_ARGUMENTS)  --user-agent="qBittorrent/3.3.16" --peer-id-prefix="-qB33G0-" --enable-dht=false --bt-enable-lpd=false --enable-peer-exchange=false'
alias aria2c-bt-uTorrent='aria2c $(echo $DOWNLOADER_ARGUMENTS) --user-agent="uTorrent/341(109279400)(30888)" --peer-id-prefix="-UT341-" --enable-dht=false --bt-enable-lpd=false --enable-peer-exchange=false'
alias aria2c-bt-Transmission='aria2c $(echo $DOWNLOADER_ARGUMENTS) --user-agent="Transmission/2.77" --peer-id-prefix="-TR2770-" --enable-dht=false --bt-enable-lpd=false --enable-peer-exchange=false'
alias bypy='bypy -d --retry 1 --downloader aria2'
alias bypy-processes-4='bypy --processes 4'
alias scp='scp -v'
alias UrlDecode='python2 -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias UrlEncode='python2 -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias ffmpeg='ffmpeg -err_detect ignore_err'
alias l='ls -lah'
alias ll='ls -lh'
alias ls='ls -F --color=auto --show-control-chars'
alias termux-ssh-server-start='pkill sshd ; sshd && logcat -s "syslog:*"'
alias termux-scp='rsync --archive --new-compress --verbose --partial --partial-dir=.rsync-partial --progress --rsh="ssh -p8022"' # termux-scp root@192.168.78.100:~/storage/external-1/j.mp4 ~/Desktop

alias chrome-ignoreCrt='google-chrome --ignore-certificate-errors'
alias google-chrome-ignoreCrt='google-chrome --ignore-certificate-errors'
alias opera-ignoreCrt='opera --ignore-certificate-errors'
alias opera-developer-ignoreCrt='opera-developer --ignore-certificate-errors'

export SUDO=''
if (( $EUID != 0 )); then
  export SUDO='sudo'
fi

GREP_OPTIONS=""
if $(echo | grep --color=auto "" > /dev/null 2>&1); then
  GREP_OPTIONS="$GREP_OPTIONS --color=auto"
fi
VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"
if $(echo | grep --exclude-dir=.cvs "" > /dev/null 2>&1); then
  GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$VCS_FOLDERS"
elif $(echo | grep --exclude=.cvs "" > /dev/null 2>&1); then
  GREP_OPTIONS="$GREP_OPTIONS --exclude=$VCS_FOLDERS"
fi
alias grep="grep $GREP_OPTIONS"

proxyNtust() { export http_proxy="140.118.31.62:3128" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyYouku() { export http_proxy="proxy.uku.im:443" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyAsusInToOut() { export http_proxy="kungfu:howkungfu@10.78.20.186.3128" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyAsusOutToIn() { export http_proxy="kungfu:howkungfu@ceasar.dlinkdns.com:5566" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyUnset() { unset http_proxy && unset https_proxy && unset ftp_proxy ;}
EncodingToEN() { export LANG="en_US.UTF-8" && export LC_CTYPE="en_US.UTF-8" && export LC_NUMERIC="en_US.UTF-8" && export LC_TIME="en_US.UTF-8" && export LC_COLLATE="en_US.UTF-8" && export LC_MONETARY="en_US.UTF-8" && export LC_MESSAGES="en_US.UTF-8" && export LC_ALL="en_US.UTF-8" ;}
EncodingToBig5() { export LANG="zh_TW.Big5" && export LC_CTYPE="zh_TW.Big5" && export LC_NUMERIC="zh_TW.Big5" && export LC_TIME="zh_TW.Big5" && export LC_COLLATE="zh_TW.Big5" && export LC_MONETARY="zh_TW.Big5" && export LC_MESSAGES="zh_TW.Big5" && export LC_ALL="zh_TW.Big5" ;}
EncodingToTwUtf8() { export LANG="zh_TW.UTF-8" && export LC_CTYPE="zh_TW.UTF-8" && export LC_NUMERIC="zh_TW.UTF-8" && export LC_TIME="zh_TW.UTF-8" && export LC_COLLATE="zh_TW.UTF-8" && export LC_MONETARY="zh_TW.UTF-8" && export LC_MESSAGES="zh_TW.UTF-8" && export LC_ALL="zh_TW.UTF-8" ;}
EncodingToGBK() { export LANG="zh_CN.GBK" && export LC_CTYPE="zh_CN.GBK" && export LC_NUMERIC="zh_CN.GBK" && export LC_TIME="zh_CN.GBK" && export LC_COLLATE="zh_CN.GBK" && export LC_MONETARY="zh_CN.GBK" && export LC_MESSAGES="zh_CN.GBK" && export LC_ALL="zh_CN.GBK" ;}
EncodingToChUtf8() { export LANG="zh_CN.UTF-8" && export LC_CTYPE="zh_CN.UTF-8" && export LC_NUMERIC="zh_CN.UTF-8" && export LC_TIME="zh_CN.UTF-8" && export LC_COLLATE="zh_CN.UTF-8" && export LC_MONETARY="zh_CN.UTF-8" && export LC_MESSAGES="zh_CN.UTF-8" && export LC_ALL="zh_CN.UTF-8" ;}
killallproc() { $SUDO kill -9 $(pgrep $@) ;}
killallStopped() { $SUDO kill -9 $(jobs -ps | cut -d' ' -f4) ;}
7zExtractToFolder() { 7z -o"$@E" x "$@" ;}
upgradePip() { pip install --upgrade $(pip freeze -l | sed "s/==.*//") && pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
upgradeDotfile() {
  cd ~/dotfile
  git pull origin master
  git submodule update --init --recursive --remote --merge
  git submodule foreach git pull origin master
  cd - ;

  rm -rf ~/.bashrc
  rm -rf ~/.bash_profile
  rm -rf ~/.tmux.conf
  rm -rf ~/.zshrc
  rm -rf ~/.gitconfig
  rm -rf ~/.gitmessage
  rm -rf ~/.fbtermrc
  rm -rf ~/.Xresources
  rm -rf ~/.minttyrc
  rm -rf ~/.vimrc
  rm -rf ~/.pythonrc
  rm -rf ~/AppData/Local/nvim/init.vim

  if [[ "$OSTYPE" == "cygwin" ]]; then
    cygstart --action=runas cmd.exe /c del "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.minttyrc" "%USERPROFILE%\dotfile\Windows\.minttyrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.pythonrc" "%USERPROFILE%\dotfile\.pythonrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfile\.gitconfig"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.gitmessage" "%USERPROFILE%\dotfile\.gitmessage"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.Xresources" "%USERPROFILE%\dotfile\.Xresources"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1" "%USERPROFILE%\dotfile\powershell\profile.ps1"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\vimrc\.vimrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\AppData\Local\nvim\init.vim" "%USERPROFILE%\dotfile\vimrc\.vimrc"
  else
    ln -sf $HOME/dotfile/.bashrc ~/.bashrc
    ln -sf $HOME/dotfile/.bashrc ~/.bash_profile
    ln -sf $HOME/dotfile/.tmux.conf ~/.tmux.conf
    ln -sf $HOME/dotfile/.bashrc ~/.zshrc
    ln -sf $HOME/dotfile/.pythonrc ~/.pythonrc
    ln -sf $HOME/dotfile/.gitconfig ~/.gitconfig
    ln -sf $HOME/dotfile/.gitmessage ~/.gitmessage
    ln -sf $HOME/dotfile/.fbtermrc ~/.fbtermrc
    ln -sf $HOME/dotfile/.Xresources ~/.Xresources
    ln -sf $HOME/dotfile/.minttyrc ~/.minttyrc
    ln -sf $HOME/dotfile/vimrc/.vimrc ~/.vimrc
  fi;
}

if [ $(command -v grc) ] ; then
  GRC="$(which grc)"
  alias colourify="$GRC -es --colour=auto"
  alias configure='colourify ./configure'
  alias nmap='colourify nmap'
  [[ $(command -v ant) ]]                  && alias ant='colourify ant'
  [[ $(command -v blkid) ]]                && alias blkid='colourify blkid'
  [[ $(command -v cvs) ]]                  && alias cvs='colourify cvs'
  [[ $(command -v df) ]]                   && alias df='colourify df'
  [[ $(command -v diff) ]]                 && alias diff='colourify diff'
  [[ $(command -v dig) ]]                  && alias dig='colourify dig'
  [[ $(command -v dnf) ]]                  && alias dnf='colourify dnf'
  [[ $(command -v dockerimages) ]]         && alias dockerimages='colourify dockerimages'
  [[ $(command -v dockerinfo) ]]           && alias dockerinfo='colourify dockerinfo'
  [[ $(command -v docker-machinels) ]]     && alias docker-machinels='colourify docker-machinels'
  [[ $(command -v dockernetwork) ]]        && alias dockernetwork='colourify dockernetwork'
  [[ $(command -v dockerps) ]]             && alias dockerps='colourify dockerps'
  [[ $(command -v dockerpull) ]]           && alias dockerpull='colourify dockerpull'
  [[ $(command -v dockersearch) ]]         && alias dockersearch='colourify dockersearch'
  [[ $(command -v dockerversion) ]]        && alias dockerversion='colourify dockerversion'
  [[ $(command -v du) ]]                   && alias du='colourify du'
  [[ $(command -v env) ]]                  && alias env='colourify env'
  [[ $(command -v esperanto) ]]            && alias esperanto='colourify esperanto'
  [[ $(command -v fdisk) ]]                && alias fdisk='colourify fdisk'
  [[ $(command -v findmnt) ]]              && alias findmnt='colourify findmnt'
  [[ $(command -v free) ]]                 && alias free='colourify free'
  [[ $(command -v gcc) ]]                  && alias gcc='colourify gcc'
  [[ $(command -v g++) ]]                  && alias g++='colourify g++'
  [[ $(command -v getfacl) ]]              && alias getfacl='colourify getfacl'
  [[ $(command -v getsebool) ]]            && alias getsebool='colourify getsebool'
  [[ $(command -v head) ]]                 && alias head='colourify head'
  [[ $(command -v id) ]]                   && alias id='colourify id'
  [[ $(command -v ifconfig) ]]             && alias ifconfig='colourify ifconfig'
  [[ $(command -v iostat_sar) ]]           && alias iostat_sar='colourify iostat_sar'
  [[ $(command -v ip) ]]                   && alias ip='colourify ip'
  [[ $(command -v ipaddr) ]]               && alias ipaddr='colourify ipaddr'
  [[ $(command -v ipneighbor) ]]           && alias ipneighbor='colourify ipneighbor'
  [[ $(command -v iproute) ]]              && alias iproute='colourify iproute'
  [[ $(command -v iptables) ]]             && alias iptables='colourify iptables'
  [[ $(command -v irclog) ]]               && alias irclog='colourify irclog'
  [[ $(command -v last) ]]                 && alias last='colourify last'
  [[ $(command -v ldap) ]]                 && alias ldap='colourify ldap'
  [[ $(command -v log) ]]                  && alias log='colourify log'
  [[ $(command -v lsattr) ]]               && alias lsattr='colourify lsattr'
  [[ $(command -v lsblk) ]]                && alias lsblk='colourify lsblk'
  [[ $(command -v lsmod) ]]                && alias lsmod='colourify lsmod'
  [[ $(command -v lsof) ]]                 && alias lsof='colourify lsof'
  [[ $(command -v lspci) ]]                && alias lspci='colourify lspci'
  [[ $(command -v make) ]]                 && alias make='colourify make'
  [[ $(command -v mount) ]]                && alias mount='colourify mount'
  [[ $(command -v mtr) ]]                  && alias mtr='colourify mtr'
  [[ $(command -v mvn) ]]                  && alias mvn='colourify mvn'
  [[ $(command -v netstat) ]]              && alias netstat='colourify netstat'
  [[ $(command -v php) ]]                  && alias php='colourify php'
  [[ $(command -v ping) ]]                 && alias ping='colourify ping'
  [[ $(command -v ping2) ]]                && alias ping2='colourify ping2'
  [[ $(command -v proftpd) ]]              && alias proftpd='colourify proftpd'
  [[ $(command -v ps) ]]                   && alias ps='colourify ps'
  [[ $(command -v pv) ]]                   && alias pv='colourify pv'
  [[ $(command -v semanageboolean) ]]      && alias semanageboolean='colourify semanageboolean'
  [[ $(command -v semanagefcontext) ]]     && alias semanagefcontext='colourify semanagefcontext'
  [[ $(command -v semanageuser) ]]         && alias semanageuser='colourify semanageuser'
  [[ $(command -v showmount) ]]            && alias showmount='colourify showmount'
  [[ $(command -v sql) ]]                  && alias sql='colourify sql'
  [[ $(command -v ss) ]]                   && alias ss='colourify ss'
  [[ $(command -v stat) ]]                 && alias stat='colourify stat'
  [[ $(command -v sysctl) ]]               && alias sysctl='colourify sysctl'
  [[ $(command -v systemctl) ]]            && alias systemctl='colourify systemctl'
  [[ $(command -v tail) ]]                 && alias tail='colourify tail'
  [[ $(command -v tcpdump) ]]              && alias tcpdump='colourify tcpdump'
  [[ $(command -v traceroute) ]]           && alias traceroute='colourify traceroute'
  [[ $(command -v tune2fs) ]]              && alias tune2fs='colourify tune2fs'
  [[ $(command -v ulimit) ]]               && alias ulimit='colourify ulimit'
  [[ $(command -v uptime) ]]               && alias uptime='colourify uptime'
  [[ $(command -v vmstat) ]]               && alias vmstat='colourify vmstat'
  [[ $(command -v wdiff) ]]                && alias wdiff='colourify wdiff'
fi

stty -ixon -ixoff # In order to use Ctrl Q and ctrl S
stty lnext '^-' stop undef start undef -ixon # Unbind Ctrl V, replace with Ctrl _

if [[ "$OSTYPE" == "cygwin" ]]; then
  gvim()
  {
    if [ "$#" == 0 ]; then
      /cygdrive/c/ProgramData/chocolatey/bin/gvim.exe &!
    else
      /cygdrive/c/ProgramData/chocolatey/bin/gvim.exe -p --remote-tab-silent "$@" &!
    fi;
  }
elif [[ "$OSTYPE" == "msys" ]]; then
  gvim()
  {
    if [ "$#" == 0 ]; then
      /c/ProgramData/chocolatey/bin/gvim.exe &!
    else
      /c/ProgramData/chocolatey/bin/gvim.exe -p --remote-tab-silent "$@" &!
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


if [[ -n "$ZSH_VERSION" ]]; then # Zsh
  export ZSH=$HOME/dotfile/oh-my-zsh
  ZSH_THEME="bira"
  plugins=(git docker)
  DISABLE_AUTO_UPDATE="true"
  if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
    compdef vman=man # Complete vman as man command
    compdef Forever=sudo # Complete Forever as sudo command
    [ $(command -v apt-get) ] && compdef apt-fast=apt # Complete apt-fast as apt command
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
    NEWLINE_NO_OMZ=$'\n'
    # %B=light_color %F=color
    PROMPT="%B%F{red}%n%B%F{yellow}@%B%F{green}%M %{$reset_color%}➜ %B%F{blue}%~"${NEWLINE_NO_OMZ}"%{$reset_color%}$ "
  fi
  [ -f $HOME/dotfile/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $HOME/dotfile/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root line)
  export KEYTIMEOUT=1 # Make ESC faster
  setopt NO_NOMATCH # disable zsh match filename
  setopt complete_in_word # Move cursor to the end when completion
  setopt always_to_end # Move cursor to the end when completion
  setopt nonomatch # Disable warning when completion not found
  _comp_options+=(globdots) # Show hidden files when using completion
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
  export HISTCONTROL=ignoredups:erasedups # Ignore duplicate entries in .bash_history
  export HISTFILESIZE=
  export HISTSIZE=
  shopt -s histappend # Append history
  PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND" # Write history immediately
  if [[ $- =~ i ]]; then
    bind 'set completion-ignore-case on' # Ignore case
    bind '"\e[A": history-search-backward' # Up key is searching backward
    bind '"\e[B": history-search-forward'  # Down key is searching forward
    bind '\C-B:backward-kill-word'
    bind '\C-Z:undo'
    bind '\C-Y:redo'
    bind '\C-K:kill-whole-line'
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
    # USER@DOMAIN directory
    export PS1="${COLOR_LIGHT_RED}\u${COLOR_LIGHT_YELLOW}@${COLOR_LIGHT_GREEN}\h${COLOR_RESET}➜ ${COLOR_LIGHT_BLUE}\w${COLOR_RESET}\n\$ "
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
  alias ls='ls -G'
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
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

if [[ -d "$HOME/Miniconda2" ]]; then
  export PATH=~/Miniconda2/bin:$PATH
  alias conda2='~/Miniconda2/bin/conda'
  alias pip2='~/Miniconda2/bin/pip'
  alias upgradeConda2='~/Miniconda2/bin/conda update --all --yes'
  upgradePip2() { ~/Miniconda2/bin/pip install --upgrade $(pip freeze -l | sed "s/==.*//") && ~/Miniconda2/bin/pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && ~/Miniconda2/bin/pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
elif [[ -d "$HOME/miniconda2" ]]; then
  export PATH=~/miniconda2/bin:$PATH
  alias conda2='~/miniconda2/bin/conda'
  alias pip2='~/miniconda2/bin/pip'
  alias upgradeConda2='~/miniconda2/bin/conda update --all --yes'
  upgradePip2() { ~/miniconda2/bin/pip install --upgrade $(pip freeze -l | sed "s/==.*//") && ~/miniconda2/bin/pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && ~/miniconda2/bin/pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
elif [[ -d "$HOME/Anaconda2" ]]; then
  export PATH=~/Anaconda2/bin:$PATH
  alias conda2='~/Anaconda2/bin/conda'
  alias pip2='~/Anaconda2/bin/pip'
  alias upgradeConda2='~/Anaconda2/bin/conda update --all --yes'
  upgradePip2() { ~/Anaconda2/bin/pip install --upgrade $(pip freeze -l | sed "s/==.*//") && ~/Anaconda2/bin/pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && ~/Anaconda2/bin/pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
elif [[ -d "$HOME/anaconda2" ]]; then
  export PATH=~/anaconda2/bin:$PATH
  alias conda2='~/anaconda2/bin/conda'
  alias pip2='~/anaconda2/bin/pip'
  alias upgradeConda2='~/anaconda2/bin/conda update --all --yes'
  upgradePip2() { ~/anaconda2/bin/pip install --upgrade $(pip freeze -l | sed "s/==.*//") && ~/anaconda2/bin/pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && ~/anaconda2/bin/pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
fi

if [[ -d "$HOME/Miniconda3" ]]; then
  export PATH=~/Miniconda3/bin:$PATH
  alias conda3='~/Miniconda3/bin/conda'
  alias pip3='~/Miniconda3/bin/pip'
  alias upgradeConda3='~/Miniconda3/bin/conda update --all --yes'
  upgradePip3() { ~/Miniconda3/bin/pip install --upgrade $(pip freeze -l | sed "s/==.*//") && ~/Miniconda3/bin/pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && ~/Miniconda3/bin/pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
elif [[ -d "$HOME/miniconda3" ]]; then
  export PATH=~/miniconda3/bin:$PATH
  alias conda3='~/miniconda3/bin/conda'
  alias pip3='~/miniconda3/bin/pip'
  alias upgradeConda3='~/miniconda3/bin/conda update --all --yes'
  upgradePip3() { ~/miniconda3/bin/pip install --upgrade $(pip freeze -l | sed "s/==.*//") && ~/miniconda3/bin/pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && ~/miniconda3/bin/pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
elif [[ -d "$HOME/Anaconda3" ]]; then
  export PATH=~/Anaconda3/bin:$PATH
  alias conda3='~/Anaconda3/bin/conda'
  alias pip3='~/Anaconda3/bin/pip'
  alias upgradeConda3='~/Anaconda3/bin/conda update --all --yes'
  upgradePip3() { ~/Anaconda3/bin/pip install --upgrade $(pip freeze -l | sed "s/==.*//") && ~/Anaconda3/bin/pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && ~/Anaconda3/bin/pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
elif [[ -d "$HOME/anaconda3" ]]; then
  export PATH=~/anaconda3/bin:$PATH
  alias conda3='~/anaconda3/bin/conda'
  alias pip3='~/anaconda3/bin/pip'
  alias upgradeConda3='~/anaconda3/bin/conda update --all --yes'
  upgradePip3() { ~/anaconda3/bin/pip install --upgrade $(pip freeze -l | sed "s/==.*//") && ~/anaconda3/bin/pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && ~/anaconda3/bin/pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}
fi

[ -f $HOME/.pythonrc ] && export PYTHONSTARTUP=$HOME/.pythonrc
[ -f $HOME/.pythonrc.py ] && export PYTHONSTARTUP=$HOME/.pythonrc.py

if [[ -d "$HOME/node" ]]; then
  export PATH=~/node/bin:$PATH
  alias upgradeNpm='~/node/bin/npm update -g'
fi

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

if ! [[ $(command -v tree) ]]; then
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
  PARAMS=$( echo $PARAMS | sed "s/'-H'/--header/g" | sed "s/ '--compressed'//g" )

  eval "aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
  while [ $? -ne 0 ]; do
    echo "Retrying curlToAria2 ..."
    eval "aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
  done;
}

unzipToBig5py3()
{
  export zipfilename="$@"
  python3 <<END
import zipfile, sys, os

with zipfile.ZipFile(os.environ['zipfilename']) as file:
  for name in file.namelist():
    utf8name = name.encode('cp437').decode('Big5')
    pathname = os.path.dirname(utf8name)
    if not os.path.exists(pathname) and pathname!= "":
      os.makedirs(pathname)
    else:
      data = file.read(name)
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
  python3 <<END
import zipfile, sys, os

with zipfile.ZipFile(os.environ['zipfilename']) as file:
  for name in file.namelist():
    utf8name = name.encode('cp437').decode('GBK')
    pathname = os.path.dirname(utf8name)
    if not os.path.exists(pathname) and pathname!= "":
      os.makedirs(pathname)
    else:
      data = file.read(name)
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
  python2 <<END
import os, sys, zipfile
file = zipfile.ZipFile(os.environ['zipfilename'],"r");
for name in file.namelist():
  utf8name = name.decode('big5')
#  print "Extracting " + utf8name
  pathname = os.path.dirname(utf8name)
  if not os.path.exists(pathname) and pathname!= "":
    os.makedirs(pathname)
  data = file.read(name)
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
  python2 <<END
import os, sys, zipfile
file = zipfile.ZipFile(os.environ['zipfilename'],"r");
for name in file.namelist():
  utf8name = name.decode('gbk')
#  print "Extracting " + utf8name
  pathname = os.path.dirname(utf8name)
  if not os.path.exists(pathname) and pathname!= "":
    os.makedirs(pathname)
  data = file.read(name)
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
    echo "$LBUFFER" > $HOME/dotfile/clipboard.txt
    LBUFFER="" ;

  elif [[ -n "$BASH_VERSION" ]]; then
    # Currently, bash can not bind C-x but I'll leave this here
    echo "$READLINE_LINE" > $HOME/dotfile/clipboard.txt
    READLINE_LINE="" ;
  fi
  chmod 777 $HOME/dotfile/clipboard.txt;
}

PasteFromClipboard()
{
  if [[ -f $HOME/dotfile/clipboard.txt ]]; then
    if [[ -n "$ZSH_VERSION" ]]; then
      LBUFFER="$LBUFFER$(cat $HOME/dotfile/clipboard.txt)"
    elif [[ -n "$BASH_VERSION" ]]; then
      READLINE_LINE="$READLINE_LINE$(cat $HOME/dotfile/clipboard.txt)" ;
    fi
  fi;
}

CompleteAptCyg()
{
  local -a options
  options=(
    'install:Install package(s).'
    'remove:Remove package(s) from the system.'
    'update:Download a fresh copy of the master package list (setup.ini).'
    'download:Retrieve package(s) from the server, but do not install/upgrade anything.'
    'show:Display information on given package(s).'
    'depends:Produce a dependency tree for a package.'
    'rdepends:Produce a tree of packages that depend on the named package.'
    'category:Display all packages that are members of a named category.'
    'listfiles:List all files owned by a given package.'
    'searchall:Search cygwin.com to retrieve file information about packages'
  )
  _describe 'values' options;
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
    xdg-open . > /dev/null 2>&1;
  elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then # Windows
    explorer.exe .
  elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
    open .
  else # Unknown OS
    true
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

