alias ll='ls -lh'
alias ls='ls -F --color=auto --show-control-chars'

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
export JAVA_TOOL_OPTIONS=" -Dfile.encoding=UTF8 "
if [[ $(command -v aria2c) ]]; then
  if [[ $(aria2c --version | grep "Async DNS") ]]; then
    export DOWNLOADER_ARGUMENTS="--async-dns-server=8.8.8.8,223.5.5.5 --continue=true --check-certificate=false --max-tries=0 --max-concurrent-downloads=16 --max-connection-per-server=16 --split=16 --min-split-size=1M" # aria2 & bypy
  else
    export DOWNLOADER_ARGUMENTS="--continue=true --check-certificate=false --max-tries=0 --max-concurrent-downloads=16 --max-connection-per-server=16 --split=16 --min-split-size=1M" # aria2 & bypy
  fi
fi

alias xterm="xterm -bg black -fg white -fa 'Ubuntu Mono' -fs 14"
alias upgradeConda='conda update --all --yes'
alias upgradeBypy='pip install --upgrade https://github.com/houtianze/bypy/archive/master.zip'
alias upgradeYoutubedl='pip install --upgrade https://github.com/rg3/youtube-dl/archive/master.zip'
alias upgradeYou-get='pip install --upgrade https://github.com/soimort/you-get/archive/develop.zip'
alias upgradeDotfile="cd ~/dotfile && git pull origin master && git submodule init && git submodule update && git submodule foreach git pull origin master && cd -"
alias sudoRoot='sudo -H ' # $HOME = /root
alias sudoUser='sudo -E ' # $HOME = /home/$USER
alias curl='curl --retry 999 --retry-max-time 0 -LC - '
alias you-getNtust='you-get -x 140.118.31.62:3128'
alias you-getYouku='you-get -y proxy.uku.im:443'
alias youtube-dl='youtube-dl --write-sub --ignore-errors --external-downloader aria2c --external-downloader-args $DOWNLOADER_ARGUMENTS'
alias youtube-dl-audio='youtube-dl --extract-audio'
alias youtube-dl-audio-MP3='youtube-dl --extract-audio --audio-format mp3'
alias youtube-dl-audio-Opus='youtube-dl --extract-audio --audio-format opus'
alias youtube-dlNtust='youtube-dl --proxy 140.118.31.62:3128'
alias youtube-dlYouku='youtube-dl --proxy proxy.uku.im:443'
alias wget='wget -c -e robots=off --tries=10 --read-timeout=30'
alias aria2c='aria2c $(echo $DOWNLOADER_ARGUMENTS)'
alias bypy='bypy --downloader aria2'

proxyNtust() { export http_proxy="140.118.31.62:3128" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyYouku() { export http_proxy="proxy.uku.im:443" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyUnset() { unset http_proxy && unset https_proxy && unset ftp_proxy ;}
EncodingToEN() { export LANG="en_US.UTF-8" && export LC_CTYPE="en_US.UTF-8" && export LC_NUMERIC="en_US.UTF-8" && export LC_TIME="en_US.UTF-8" && export LC_COLLATE="en_US.UTF-8" && export LC_MONETARY="en_US.UTF-8" && export LC_MESSAGES="en_US.UTF-8" && export LC_ALL="en_US.UTF-8" ;}
EncodingToBig5() { export LANG="zh_TW.Big5" && export LC_CTYPE="zh_TW.Big5" && export LC_NUMERIC="zh_TW.Big5" && export LC_TIME="zh_TW.Big5" && export LC_COLLATE="zh_TW.Big5" && export LC_MONETARY="zh_TW.Big5" && export LC_MESSAGES="zh_TW.Big5" && export LC_ALL="zh_TW.Big5" ;}
EncodingToGBK() { export LANG="zh_CN.GBK" && export LC_CTYPE="zh_CN.GBK" && export LC_NUMERIC="zh_CN.GBK" && export LC_TIME="zh_CN.GBK" && export LC_COLLATE="zh_CN.GBK" && export LC_MONETARY="zh_CN.GBK" && export LC_MESSAGES="zh_CN.GBK" && export LC_ALL="zh_CN.GBK" ;}
killallproc() { kill -9 $(pgrep $@) ;}
killallprocSudo() { sudo kill -9 $(pgrep $@) ;}
killallStopped() { kill -9 $(jobs -ps | cut -d' ' -f4) ;}
7zExtractToFolder() { 7z -o"$@E" x "$@" ;}
upgradePip() { pip install --upgrade $(pip freeze -l | sed "s/==.*//") && pip install --upgrade https://github.com/pyca/pyopenssl/archive/master.zip && pip install --upgrade https://github.com/requests/requests/archive/master.zip ;}

if [ $(command -v grc) ] ; then
  GRC="$(which grc)"
  alias colourify="$GRC -es --colour=auto"
  alias ant='colourify ant'
  alias blkid='colourify blkid'
  alias configure='colourify configure'
  alias cvs='colourify cvs'
  alias df='colourify df'
  alias diff='colourify diff'
  alias dig='colourify dig'
  alias dnf='colourify dnf'
  alias dockerimages='colourify dockerimages'
  alias dockerinfo='colourify dockerinfo'
  alias docker-machinels='colourify docker-machinels'
  alias dockernetwork='colourify dockernetwork'
  alias dockerps='colourify dockerps'
  alias dockerpull='colourify dockerpull'
  alias dockersearch='colourify dockersearch'
  alias dockerversion='colourify dockerversion'
  alias du='colourify du'
  alias env='colourify env'
  alias esperanto='colourify esperanto'
  alias fdisk='colourify fdisk'
  alias findmnt='colourify findmnt'
  alias free='colourify free'
  alias gcc='colourify gcc'
  alias getfacl='colourify getfacl'
  alias getsebool='colourify getsebool'
  alias id='colourify id'
  alias ifconfig='colourify ifconfig'
  alias iostat_sar='colourify iostat_sar'
  alias ip='colourify ip'
  alias ipaddr='colourify ipaddr'
  alias ipneighbor='colourify ipneighbor'
  alias iproute='colourify iproute'
  alias iptables='colourify iptables'
  alias irclog='colourify irclog'
  alias last='colourify last'
  alias ldap='colourify ldap'
  alias log='colourify log'
  alias lsattr='colourify lsattr'
  alias lsblk='colourify lsblk'
  alias lsmod='colourify lsmod'
  alias lsof='colourify lsof'
  alias lspci='colourify lspci'
  alias mount='colourify mount'
  alias mtr='colourify mtr'
  alias mvn='colourify mvn'
  alias netstat='colourify netstat'
  alias nmap='colourify nmap'
  alias php='colourify php'
  alias ping='colourify ping'
  alias ping2='colourify ping2'
  alias proftpd='colourify proftpd'
  alias ps='colourify ps'
  alias pv='colourify pv'
  alias semanageboolean='colourify semanageboolean'
  alias semanagefcontext='colourify semanagefcontext'
  alias semanageuser='colourify semanageuser'
  alias showmount='colourify showmount'
  alias sql='colourify sql'
  alias ss='colourify ss'
  alias stat='colourify stat'
  alias sysctl='colourify sysctl'
  alias systemctl='colourify systemctl'
  alias tcpdump='colourify tcpdump'
  alias traceroute='colourify traceroute'
  alias tune2fs='colourify tune2fs'
  alias ulimit='colourify ulimit'
  alias uptime='colourify uptime'
  alias vmstat='colourify vmstat'
  alias wdiff='colourify wdiff'
  alias sh='colourify sh'
fi

stty -ixon -ixoff # In order to use Ctrl Q and ctrl S
stty lnext '^-' stop undef start undef -ixon # Unbind Ctrl V, replace with Ctrl _

if [[ -n "$ZSH_VERSION" ]]; then # Zsh
  export ZSH=$HOME/dotfile/oh-my-zsh
  ZSH_THEME="bira"
  plugins=(git docker)
  DISABLE_AUTO_UPDATE="true"
  source $ZSH/oh-my-zsh.sh
  unset -f upgrade_oh_my_zsh # Remove this function
  source $HOME/dotfile/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
  export KEYTIMEOUT=1 # Make ESC faster
  setopt NO_NOMATCH # disable zsh match filename
  _comp_options+=(globdots) # Show hidden files when using completion
  zle -N ZshPasteFromClipboard # Bind function to command
  zle -N ZshCutToClipboard # Bind function to command
  compdef vman=man # Complete vman as man command
  compdef forever=sudo # Complete forever as sudo command

  if [ $(command -v apt-get) ] ; then
    compdef apt-fast=apt-get # Complete apt-fast as apt-get command
  fi
  compdef CompleteAptCyg apt-cyg # Complete apt-cyg

  # alt + arrow key to move
  bindkey "^[[1;3C" forward-word
  bindkey "^[[1;3D" backward-word
  bindkey "\e\eOC" forward-word
  bindkey "\e\eOD" backward-word
  bindkey "\e\e[C" forward-word
  bindkey "\e\e[D" backward-word
  bindkey "^N" forward-word
  bindkey "^P" backward-word
  bindkey "^B" backward-kill-word
  bindkey "\e\e[3~" backward-kill-word
  bindkey "^Z" undo
  bindkey "^Y" redo
  bindkey "^V" ZshPasteFromClipboard # Ctrl V to paste from Clipboard.txt
  bindkey "^X" ZshCutToClipboard # Ctrl X to cut to Clipboard.txt
elif [[ -n "$BASH_VERSION" ]]; then # Bash
  complete -cf sudo # complete sudo command
  complete -cf man # complete man command
  bind 'set completion-ignore-case on' # Ignore case
  bind '"\e[A": history-search-backward' # Up key is searching backward
  bind '"\e[B": history-search-forward'  # Down key is searching forward
  bind -x '"\C-v": BashPasteFromClipboard'  # Ctrl V to paste from Clipboard.txt
  bind '\C-B:backward-kill-word'
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then # Ubuntu
  true
elif [[ "$OSTYPE" == "linux-android" ]]; then # Android Termux
  alias ls='ls -F --color=auto'
elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
  alias ls='ls -G'
elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
  export DISPLAY=:0.0
  export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
  alias apt-cyg-Manage='setup-x86_64.exe --package-manager --wait'
  alias apt-cyg-Upgrade="setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --upgrade-also --delete-orphans"
  alias sudo='cygstart --action=runas "$@"'
  alias choco='cygstart --action=runas choco'
  alias mtuForGaming='cygstart --action=runas netsh interface ipv4 set subinterface Wi-Fi mtu=296  store=persistent'
  alias mtuForNormal='cygstart --action=runas netsh interface ipv4 set subinterface Wi-Fi mtu=1500 store=persistent'
  upgradeChoco() { cygstart --action=runas cmd.exe /c "choco update all -y & choco upgrade all -y" ;}

elif [[ "$OSTYPE" == "msys" ]]; then # Msys
  true
elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
  alias ls='ls -G'
else # Unknown OS
  true
fi

if [[ -d "$HOME/Miniconda3" ]]; then
  export PATH=~/Miniconda3/bin:$PATH
fi

if [[ -d "/sbin" ]]; then
  export PATH=$PATH:/sbin
fi

if [ $(command -v gvim) ]; then
  gvim()
  {
    if [ "$#" == 0 ]; then
      command gvim
    else
      command gvim -p --remote-tab-silent "$@"
    fi;
  }
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

if [[ "$TERM" == "xterm"* ]]; then
  export TERM=xterm-256color
fi

vman() {
  # for FreeBSD/MacOS, col -b removes backspaces, col -x replace tabs with spaces
  man $@ | col -bx | vim -MR +"set filetype=man" - # -MR Make it read only and quit easily
}

curlToAria2()
{
  PARAMS=""

  for PARAM in "$@"
  do
    PARAMS="${PARAMS} '${PARAM}'"
  done
  PARAMS=$( echo $PARAMS | sed "s/'-H'/--header/g" | sed "s/ '--compressed'//g" )

  bash -c "aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
  while [ $? -ne 0 ]; do
    echo "Retrying curlToAria2 ..."
    bash -c "aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
  done
}

unzipToBig5()
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

unzipToGBK()
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

ZshPasteFromClipboard()
{
  LBUFFER="$LBUFFER$(cat $HOME/dotfile/clipboard.txt)" ; # Zsh only, C-v to paste from clipboard.txt
}

ZshCutToClipboard()
{
  echo "$LBUFFER" > $HOME/dotfile/clipboard.txt
  LBUFFER="" ; # Zsh only, C-x to cut to clipboard.txt
  chmod 777 $HOME/dotfile/clipboard.txt
}

BashPasteFromClipboard()
{
  READLINE_LINE="$READLINE_LINE$(cat $HOME/dotfile/clipboard.txt)" ; # Bash only, C-v to paste from clipboard.txt
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

forever()
{
  if [ "$#" == 0 ]; then
    echo "Usage: forever \"[commands]\""
    echo "ex: forever \"ls -a\""
    echo "Run commands forever!"
  else
    while true; do eval $* ; done
  fi;
}

whichTTY=$(tty | sed -e "s:/dev/::")
if [ $(command -v tmux) ] ; then
  if [[ $TERM != screen ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* || $whichTTY == ttyv0 || $whichTTY == ttys00* ]] ; then
    cd ~
    # Check if fbterm installed
    if [ $(command -v fbterm) ] ; then
      # SHELL=tmux exec fbterm
      exec fbterm -- bash -c 'TERM=fbterm tmux'
    elif [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* || $whichTTY == ttyv0 || $whichTTY == ttys00* ]] ; then
      exec tmux
    fi
  fi
fi
