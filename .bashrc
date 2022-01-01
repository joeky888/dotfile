if [ -z "$PS1" ]; then
   exit 0 # Prevent scp command hangs
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
export LC_ALL=
export CLICOLOR=1 # Colors for FreeBSD and MacOS
export force_color_prompt=yes
export color_prompt=yes
export HISTFILESIZE=50000
export HISTSIZE=50000
export SAVEHIST=50000

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
export TERM_EMU="$(emulator)"

whichTTY=$(tty | sed -e "s:/dev/::")

if [[ "$TERM_EMU" == "xterm" ]] || [[ "$TERM_EMU" == "luit" ]] || [[ "$TERM_EMU" == "code" ]] || [[ "$TERM_EMU" == "codium" ]] || [[ "$TERM_EMU" == "java" ]] || [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  [ $(command -v xrdb) ] && [ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
  echo -e -n "\x1b[\x36 q" # changes to steady bar
  if [ $(command -v fish) ] && [ "$OSTYPE" = "cygwin" ] && [ -z "$FISH_VERSION" ]; then
    exec fish
  fi
  if [ $(command -v zsh) ] && [ -z "$ZSH_IS_RUNNING" ] && [ -f ~/.zshrc ] ; then
    export ZSH_IS_RUNNING=1
    export NO_TMUX=1
    exec zsh
  fi
  # echo -e -n "\x1b[\x30 q" # changes to blinking block
  # echo -e -n "\x1b[\x31 q" # changes to blinking block also
  # echo -e -n "\x1b[\x32 q" # changes to steady block
  # echo -e -n "\x1b[\x33 q" # changes to blinking underline
  # echo -e -n "\x1b[\x34 q" # changes to steady underline
  # echo -e -n "\x1b[\x35 q" # changes to blinking bar
elif [ $(command -v fbterm) ] && [[ $whichTTY == tty3 ]] ; then
  [ $(command -v zsh) ] && exec fbterm -- zsh -c 'TERM=fbterm exec zsh'
  [ $(command -v bash) ] && exec fbterm -- bash -c 'TERM=fbterm exec bash'
elif [ $(command -v tmux) ] && [ -z $NO_TMUX ] && [ -f ~/.tmux.conf ] && [[ $TERM != screen* ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == tty2 || $whichTTY == pty* || $whichTTY == ttyv0 || $whichTTY == ttys00* ]] ; then
  # Check if fbterm installed and x server isn't running
  cd ~
  if [ $(command -v fbterm) ] && [[ $whichTTY == tty1 || $whichTTY == tty2 ]] ; then
    TERM=fbterm exec fbterm -- bash -c '[[ -n $(tmux ls 2>/dev/null) ]] && TERM=fbterm exec tmux attach || TERM=fbterm exec tmux'
  elif [[ $TERM != fbterm ]] ; then
    [[ -n $(tmux ls 2>/dev/null) ]] && exec tmux attach || exec tmux
  fi
elif [ -z $TMUX ] && [ $(command -v fish) ] && { [ "$OSTYPE" = "cygwin" ] || [ "$OSTYPE" = "msys" ] || [ "$OSTYPE" = "linux-android" ]; }; then
  exec fish
elif [ -z $TMUX ] && [ $(command -v zsh) ] && [ -z "$ZSH_VERSION" ] && [ -z "$ZSH_IS_RUNNING" ] && [ -f ~/.zshrc ] ; then
  export ZSH_IS_RUNNING=1
  exec zsh
fi

export VISUAL="vim"
export EDITOR="$VISUAL"
export PYTHONIOENCODING="UTF-8"
export PYTHONHTTPSVERIFY=0
export JAVA_TOOL_OPTIONS=" -Dfile.encoding=UTF8 "
export DL_ARGUMENTS="-o '%(title)s.%(ext)s' --write-sub --all-subs --embed-subs --concurrent-fragments 8 --hls-prefer-native --no-check-certificate --ignore-errors"
export PLAYER_ARGUMENTS="--cache=yes --cache-dir=/tmp --cache-on-disk=yes --ytdl-raw-options=no-check-certificate=,yes-playlist=,hls-prefer-native=,ignore-errors=,write-auto-sub=,write-sub=,sub-lang='(en|zh).*'"
export DOWNLOADER_ARGUMENTS="--continue=true --timeout=12 --connect-timeout=12 --content-disposition-default-utf8=true --check-certificate=false --max-tries=2 --max-concurrent-downloads=150 --max-connection-per-server=16 --split=16 --min-split-size=1M --http-accept-gzip=true --parameterized-uri=false" # aria2 & bypy
export TORRENT_ARGUMENTS="--enable-dht=true --bt-enable-lpd=true --bt-max-peers=0 --bt-request-peer-speed-limit=100M --seed-ratio=0 --bt-detach-seed-only=true --seed-time=0 --enable-peer-exchange=true --bt-tracker-connect-timeout=10 --bt-tracker-timeout=5"
if [ $(command -v aria2c) ]; then
  if aria2c --version | grep -q "Async DNS" && [ -f /etc/resolv.conf ]; then
    export DOWNLOADER_ARGUMENTS="$DOWNLOADER_ARGUMENTS --async-dns-server=$(grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' /etc/resolv.conf | tr '\n' ',' | sed 's/,$//')" # aria2 & bypy
  fi
  if [ "$OSTYPE" = "linux-android" ]; then
    export DOWNLOADER_ARGUMENTS="$DOWNLOADER_ARGUMENTS --file-allocation=prealloc"
  else
    export DOWNLOADER_ARGUMENTS="$DOWNLOADER_ARGUMENTS --file-allocation=none"
  fi
fi

[ -f $HOME/.pythonrc ] && export PYTHONSTARTUP=$HOME/.pythonrc
[ -f $HOME/.pythonrc.py ] && export PYTHONSTARTUP=$HOME/.pythonrc.py
[ -f $HOME/.private.sh ] && source $HOME/.private.sh
[ -d $HOME/.cargo/bin ] && export PATH="$HOME/.cargo/bin:$PATH"

function getModulePath()
{
  for PATH_ARG in "$@"
  do
    local Possible_Path=(   "$HOME/dotfile/$PATH_ARG" \
                      "$HOME/dotfiles/$PATH_ARG" \
                      "$HOME/.$PATH_ARG" \
                      "$HOME/anaconda$PATH_ARG" \
                      "$HOME/$PATH_ARG" \
                      "/usr/share/$PATH_ARG" \
                      "/usr/local/share/$PATH_ARG" \
                      "/usr/local/homebrew/anaconda$PATH_ARG" \
                      "/usr/share/zsh/plugins/$PATH_ARG" \
                      "/usr/bin/$PATH_ARG"
    );

    for pth in "${Possible_Path[@]}" ; do
      if [[ -d "$pth" ]]; then
        echo "$pth"
        return 0
      fi
    done
  done
  echo "";
}

GRC_PATH=$(getModulePath grc)
NEOFETCH_PATH=$(getModulePath neofetch)
INXI_PATH=$(getModulePath inxi)
POWERLEVEL10K_PATH=$(getModulePath powerlevel10k)
ZSH_SYNTAX_PATH=$(getModulePath zsh-syntax-highlighting)
ZSH_AUTOSUGGESTIONS_PATH=$(getModulePath zsh-autosuggestions)
APP_FAST_PATH=$(getModulePath app-fast)
DIFF_HIGHLIGHT_PATH=$(getModulePath diff-highlight)
OHMYZSH_PATH=$(getModulePath oh-my-zsh ohmyzsh)

[ -n "$GRC_PATH" ]            && export PATH=$GRC_PATH:$PATH
[ -n "$NEOFETCH_PATH" ]       && export PATH=$NEOFETCH_PATH:$PATH
[ -n "$INXI_PATH" ]           && export PATH=$INXI_PATH:$PATH
[ -n "$APP_FAST_PATH" ]       && export PATH=$APP_FAST_PATH:$PATH
[ -n "$DIFF_HIGHLIGHT_PATH" ] && export PATH=$DIFF_HIGHLIGHT_PATH:$PATH

function getCondaPath()
{
  local Possible_Prefix=( "$HOME" \
                    "/usr/local" \
                    "/usr/local/homebrew"
  )
  local Possible_Path=(   "Miniconda$1" \
                    "miniconda$1" \
                    "Anaconda$1" \
                    "anaconda$1"
  );

  for pre in "${Possible_Prefix[@]}" ; do
    for pth in "${Possible_Path[@]}" ; do
      if [[ -d "$pre/$pth" ]]; then
        echo "$pre/$pth"
        return
      fi
    done
  done
  echo ""
}

export CONDA_2=$(getCondaPath 2)
if [ -n "$CONDA_2" ]; then
  export PATH=$CONDA_2/bin:$PATH
  alias conda2=$(echo $CONDA_2/bin/conda)
  alias pip2=$(echo $CONDA_2/bin/pip)
  upgradeConda2() { $(echo $CONDA_2/bin/conda) update --no-channel-priority --all --yes; $(echo $CONDA_2/bin/conda) clean --yes --all ;}
  upgradePip2() { $(echo $CONDA_2/bin/pip) install --upgrade pip setuptools && $(echo $CONDA_2/bin/pip) install --upgrade $(pip freeze -l | sed "s/==.*//") && $(echo $CONDA_2/bin/pip) install --upgrade https://github.com/pyca/pyopenssl/archive/main.zip && $(echo $CONDA_2/bin/pip) install --upgrade https://github.com/requests/requests/archive/main.zip ;}
fi

export CONDA_3=$(getCondaPath 3)
if [ -n "$CONDA_3" ]; then
  export PATH=$CONDA_3/bin:$PATH
  alias conda3=$(echo $CONDA_3/bin/conda)
  alias pip3=$(echo $CONDA_3/bin/pip)
  upgradeConda3() { $(echo $CONDA_3/bin/conda) update --no-channel-priority --all --yes; $(echo $CONDA_3/bin/conda) clean --yes --all ;}
  upgradePip3() { $(echo $CONDA_3/bin/pip) install --upgrade pip setuptools && $(echo $CONDA_3/bin/pip) install --upgrade $(pip freeze -l | sed "s/==.*//") && $(echo $CONDA_3/bin/pip) install --upgrade https://github.com/pyca/pyopenssl/archive/main.zip && $(echo $CONDA_3/bin/pip) install --upgrade https://github.com/requests/requests/archive/main.zip ;}
fi

if [[ -d "$HOME/node" ]]; then
  export PATH=$HOME/node/bin:$PATH
  alias upgradeNpm="$HOME/node/bin/npm install -g npm@latest; $HOME/node/bin/npm update -g"
else
  export NPM_PACKAGES="$HOME/.npm-packages"
  export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
  export PATH=$NPM_PACKAGES/bin:$PATH
  alias upgradeNpm='npm install -g npm@latest; npm update -g'
fi


if ! [ "$GOPATH" ]; then
  if [ -f "$HOME/go/bin/go" ]; then
    export GOROOT="$HOME/go"
    export GOPATH="$GOROOT/tool"
    export GOBIN=$GOPATH/bin
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
  elif [ -f "$HOME/golang/bin/go" ]; then
    export GOROOT="$HOME/golang"
    export GOPATH="$HOME/go"
    export GOBIN=$GOPATH/bin
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
  elif [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
  else
    export GOPATH="$HOME/go"
    export GOBIN=$GOPATH/bin
  fi
fi

if [[ -d "$HOME/zulu" ]]; then
  export PATH=$HOME/zulu/bin:$PATH
  export JAVA_HOME=$HOME/zulu
fi

if [[ -d "$HOME/Android/Sdk" ]]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
fi

if [[ -d "$HOME/flutter" ]]; then
  export PATH="$PATH:$HOME/flutter/bin"
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

if [[ -d "$HOME/.arkade/bin/" ]]; then
  # This is for arkade
  export PATH=$PATH:$HOME/.arkade/bin
fi

[ -d "/usr/local/sbin" ] && export PATH="/usr/local/sbin:$PATH" # macOS homebrew

# [ $(command -v xterm) ] && alias xterm="xterm -bg black -fg white -fa 'Monospace' -fs 14 > /dev/null 2>&1 &!"
[ $(command -v xterm) ] && alias xterm="xterm > /dev/null 2>&1 &!"
alias calc="perl -E 'eval \"say (@ARGV)\"'"
alias calc2="python -c 'import sys,math; print(eval(\"\".join(sys.argv[1:])))'"
alias base64-decode='perl -MMIME::Base64 -e "print decode_base64(@ARGV[0])"'
alias base64-encode='perl -MMIME::Base64 -e "print encode_base64(@ARGV[0])"'
alias url-decode='perl -MURI::Escape -e "print uri_unescape(@ARGV[0])"'
alias url-encode='perl -MURI::Escape -e "print uri_escape(@ARGV[0])"'
alias tmuxClearHistory='tmux clear-history'
alias upgradeBashrc='curl -L https://raw.githubusercontent.com/joeky888/dotfile/master/.bashrc -o ~/.bashrc'
alias upgradeYoutubedl='pip3 install --upgrade --force-reinstall --no-cache-dir https://github.com/ytdl-org/youtube-dl/archive/master.zip'
alias upgradeYtdlp='pip3 install --upgrade --force-reinstall --no-cache-dir https://github.com/yt-dlp/yt-dlp/archive/master.zip'
alias upgradeYou-get='pip3 install --upgrade --force-reinstall --no-cache-dir https://github.com/soimort/you-get/archive/develop.zip'
alias upgradeYkdl='pip3 install --upgrade --force-reinstall --no-cache-dir https://github.com/zhangn1985/ykdl/archive/master.zip'
alias upgradeStreamlink='pip3 install --upgrade --force-reinstall --no-cache-dir https://github.com/streamlink/streamlink/archive/master.zip'
alias upgradeAnnie='go get -v github.com/iawia002/annie'
alias upgradeMycli='pip3 install --upgrade --force-reinstall --no-cache-dir https://github.com/dbcli/mycli/archive/master.zip'
alias upgradeLitecli='pip3 install --upgrade --force-reinstall --no-cache-dir https://github.com/dbcli/litecli/archive/master.zip'
alias you-getYouku='you-get -y proxy.uku.im:443'
if hash yt-dlp 2>/dev/null >/dev/null; then
  [ $(command -v wget) ] && alias wget='wget -c -e robots=off --tries=10 --connect-timeout=10 --read-timeout=10 --verbose --user-agent="$(yt-dlp --dump-user-agent)"'
  [ $(command -v curl) ] && alias curl='curl --retry 0 --connect-timeout 10 --max-time 10 --retry-delay 0 --retry-max-time 20 --compressed -H "Accept-Encoding: gzip,deflate" --user-agent "$(yt-dlp --dump-user-agent)" -LC - '
  [ $(command -v curl3) ] && alias curl3='curl3 --http3 --retry 0 --connect-timeout 10 --max-time 10 --retry-delay 0 --retry-max-time 20 --compressed -H "Accept-Encoding: gzip,deflate" --user-agent "$(yt-dlp --dump-user-agent)" -LC - '
  [ $(command -v aria2c) ] && alias aria2c='aria2c $(echo $DOWNLOADER_ARGUMENTS) --user-agent="$(yt-dlp --dump-user-agent)"'
  [ $(command -v axel) ] && alias axel='axel --num-connections=16 --no-clobber --alternate --timeout 10 --user-agent="$(yt-dlp --dump-user-agent)"'
else
  [ $(command -v wget) ] && alias wget='wget -c -e robots=off --tries=10 --connect-timeout=10 --read-timeout=10 --verbose'
  [ $(command -v curl) ] && alias curl='curl --retry 0 --connect-timeout 10 --max-time 10 --retry-delay 0 --retry-max-time 20 --compressed -H "Accept-Encoding: gzip,deflate" -LC - '
  [ $(command -v curl3) ] && alias curl3='curl3 --http3 --retry 0 --connect-timeout 10 --max-time 10 --retry-delay 0 --retry-max-time 20 --compressed -H "Accept-Encoding: gzip,deflate" -LC - '
  [ $(command -v aria2c) ] && alias aria2c='aria2c $(echo $DOWNLOADER_ARGUMENTS)'
  [ $(command -v axel) ] && alias axel='axel --num-connections=16 --no-clobber --alternate --timeout 10'
fi
if hash aria2c 2>/dev/null >/dev/null ; then
  alias yt-dlp="yt-dlp $DL_ARGUMENTS --downloader aria2c --downloader-args 'aria2c:$DOWNLOADER_ARGUMENTS'"
else
  alias yt-dlp="yt-dlp $DL_ARGUMENTS"
fi
alias which='which -a'
alias curl-status='curl -o /dev/null --fail -L -s -w "Content Type: %{content_type}\nStatus Code: %{response_code}\nNumber of Redirects: %{num_redirects}\nSize: %{size_download}Bytes\nSpeed of Download: %{speed_download}Bytes/s\nServer IP: %{remote_ip}:%{remote_port}\nServer Final URL: %{url_effective}\n\nDNS Resolve: %{time_namelookup}s\nClient -> Server: %{time_connect}s\nServer Response: %{time_starttransfer}s\nTotal time: %{time_total}s\n"'
alias curl3-status='curl3 --http3 -o /dev/null --fail -L -s -w "Content Type: %{content_type}\nStatus Code: %{response_code}\nNumber of Redirects: %{num_redirects}\nSize: %{size_download}Bytes\nSpeed of Download: %{speed_download}Bytes/s\nServer IP: %{remote_ip}:%{remote_port}\nServer Final URL: %{url_effective}\n\nDNS Resolve: %{time_namelookup}s\nClient -> Server: %{time_connect}s\nServer Response: %{time_starttransfer}s\nTotal time: %{time_total}s\n"'
alias yt-dlp-240="yt-dlp -f 'bestvideo[height<=240][fps<=30][vcodec^=avc]+bestaudio/best'"
alias yt-dlp-360="yt-dlp -f 'bestvideo[height<=360][fps<=30][vcodec^=avc]+bestaudio/best'"
alias yt-dlp-480="yt-dlp -f 'bestvideo[height<=480][fps<=30][vcodec^=avc]+bestaudio/best'"
alias yt-dlp-720="yt-dlp -f 'bestvideo[height<=720][fps<=30][vcodec^=avc]+bestaudio/best'"
alias yt-dlp-1080="yt-dlp -f 'bestvideo[height<=1080][vcodec^=avc]+bestaudio/best'"
alias yt-dlp-playlist="yt-dlp --yes-playlist -o '%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s'"
alias yt-dlp-thumbnail="yt-dlp --write-thumbnail --write-all-thumbnails --skip-download"
alias yt-dlp-filename-ascii="yt-dlp --restrict-filenames"
alias yt-dlp-auto-sub="yt-dlp --write-auto-sub"
alias yt-dlp-audio='yt-dlp --extract-audio'
alias yt-dlp-audio-MP3='yt-dlp --extract-audio --audio-format mp3'
alias yt-dlp-audio-Opus='yt-dlp --extract-audio --audio-format opus'
alias yt-dlpYouku='yt-dlp --proxy proxy.uku.im:443'
alias streamlink-mpv-best="streamlink --loglevel debug --verbose-player --player 'mpv' --player-arg '$PLAYER_ARGUMENTS' --title '{title}' --default-stream best"
alias streamlink-mpv-1080="streamlink --loglevel debug --verbose-player --player 'mpv' --player-arg '$PLAYER_ARGUMENTS' --title '{title}' --default-stream 1080p"
alias streamlink-mpv-720="streamlink --loglevel debug --verbose-player --player 'mpv' --player-arg '$PLAYER_ARGUMENTS' --title '{title}' --default-stream 720p"
alias streamlink-mpv-480="streamlink --loglevel debug --verbose-player --player 'mpv' --player-arg '$PLAYER_ARGUMENTS' --title '{title}' --default-stream 480p"
alias mpv-1080="mpv --ytdl-format='bestvideo[height<=1080][vcodec^=avc]+bestaudio/best' $PLAYER_ARGUMENTS"
alias mpv-720="mpv --ytdl-format='bestvideo[height<=720][fps<=30][vcodec^=avc]+bestaudio/best' $PLAYER_ARGUMENTS"
alias mpv-480="mpv --ytdl-format='bestvideo[height<=480][fps<=30][vcodec^=avc]+bestaudio/best' $PLAYER_ARGUMENTS"
alias mpv-mute="mpv --mute=yes --ytdl-format='bestvideo[height<=720][fps<=30][vcodec^=avc]+bestaudio/best' $PLAYER_ARGUMENTS"
alias mpv-loop="mpv --loop --ytdl-format='bestvideo[height<=720][fps<=30][vcodec^=avc]+bestaudio/best' $PLAYER_ARGUMENTS"
alias mpv-ass2srt="mpv --sub-ass-override=strip $PLAYER_ARGUMENTS"
alias mpv-3Dto2D="mpv --vf=stereo3d=out=ml $PLAYER_ARGUMENTS"
alias mpv-4by3="mpv --video-aspect-override=4:3 $PLAYER_ARGUMENTS"
alias mpv-16by9="mpv --video-aspect-override=16:9 $PLAYER_ARGUMENTS"
alias mpv-1080-ontop="mpv --ontop --ytdl-format='bestvideo[height<=1080][vcodec^=avc]+bestaudio/best' $PLAYER_ARGUMENTS"
alias aria2c-bt-qBittorrent='aria2c $(echo $DOWNLOADER_ARGUMENTS) $(echo $TORRENT_ARGUMENTS) --user-agent="qBittorrent/4.1.1" --peer-id-prefix="-qB4110-" --bt-tracker=$(curl -s https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | tr -s "\n" | tr "\n" ",")'
alias aria2c-bt-uTorrent='aria2c $(echo $DOWNLOADER_ARGUMENTS) $(echo $TORRENT_ARGUMENTS) --user-agent="uTorrent/341(109279400)(30888)" --peer-id-prefix="-UT341-" --bt-tracker=$(curl -s https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | tr -s "\n" | tr "\n" ",")'
alias aria2c-bt-Transmission='aria2c $(echo $DOWNLOADER_ARGUMENTS) $(echo $TORRENT_ARGUMENTS) --user-agent="Transmission/2.77" --peer-id-prefix="-TR2770-" --bt-tracker=$(curl -s https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | tr -s "\n" | tr "\n" ",")'
alias bypy='DOWNLOADER_ARGUMENTS="-c -s16 -k1M -x16 -j16 -t2 --connect-timeout=2 --file-allocation=none" bypy -d --retry 1 --downloader aria2'
alias annie="annie -C"
alias annie-playlist="annie -p"
alias wine-optimize="WINEDEBUG=-all wine"
alias scp='scp -v'
alias ffmpeg='ffmpeg -err_detect ignore_err -protocol_whitelist file,http,https,tcp,tls,crypto'
if ls --version 2>/dev/null | grep -q GNU ; then
  alias ls='ls -F --color=auto --show-control-chars'
  alias l='ls -lah'
  alias ll='ls -lah'
fi
alias less='less -R'
alias termux-ssh-server-start='pkill sshd; echo "listening :8022"; sshd -D -p 8022'
alias termux-scp='rsync --archive --new-compress --verbose --partial --partial-dir=.rsync-partial --progress --rsh="ssh -p8022"' # termux-scp root@192.168.78.100:~/storage/external-1/j.mp4 ~/Desktop
alias ptt-ssh='ssh bbsu@ptt.cc'
alias ptt-telnet-23='telnet ptt.cc 23'
alias ptt-wss='ws -o https://term.ptt.cc wss://ws.ptt.cc/bbs' # go get -u -v github.com/hashrocket/ws
alias chrome-ignoreCrt='google-chrome --ignore-certificate-errors'
alias google-chrome-ignoreCrt='google-chrome --ignore-certificate-errors'
[ $(command -v google-chrome-stable) ] && export CHROME_BIN="google-chrome-stable"
alias opera-ignoreCrt='opera --ignore-certificate-errors'
alias opera-developer-ignoreCrt='opera-developer --ignore-certificate-errors'
alias 7zExtractToFolder='7z -o* x'
alias watch='watch --color'
alias transmission-daemon-start-here='transmission-daemon -f -T -w $PWD --incomplete-dir $PWD -a "127.0.0.1,192.168.*.*"'
alias python2-simple-http='python2 -m SimpleHTTPServer'
alias python3-simple-http='python3 -m http.server'

proxyYouku() { export http_proxy="proxy.uku.im:443" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy" ;}
proxyUnset() { unset http_proxy && unset https_proxy && unset ftp_proxy ;}
EncodingToEN() { export LANG="en_US.UTF-8" && export LC_CTYPE="en_US.UTF-8" && export LC_NUMERIC="en_US.UTF-8" && export LC_TIME="en_US.UTF-8" && export LC_COLLATE="en_US.UTF-8" && export LC_MONETARY="en_US.UTF-8" && export LC_MESSAGES="en_US.UTF-8" && export LC_ALL="en_US.UTF-8" ;}
EncodingToBig5() { export LANG="zh_TW.Big5" && export LC_CTYPE="zh_TW.Big5" && export LC_NUMERIC="zh_TW.Big5" && export LC_TIME="zh_TW.Big5" && export LC_COLLATE="zh_TW.Big5" && export LC_MONETARY="zh_TW.Big5" && export LC_MESSAGES="zh_TW.Big5" && export LC_ALL="zh_TW.Big5" ;}
EncodingToTwUtf8() { export LANG="zh_TW.UTF-8" && export LC_CTYPE="zh_TW.UTF-8" && export LC_NUMERIC="zh_TW.UTF-8" && export LC_TIME="zh_TW.UTF-8" && export LC_COLLATE="zh_TW.UTF-8" && export LC_MONETARY="zh_TW.UTF-8" && export LC_MESSAGES="zh_TW.UTF-8" && export LC_ALL="zh_TW.UTF-8" ;}
EncodingToGBK() { export LANG="zh_CN.GBK" && export LC_CTYPE="zh_CN.GBK" && export LC_NUMERIC="zh_CN.GBK" && export LC_TIME="zh_CN.GBK" && export LC_COLLATE="zh_CN.GBK" && export LC_MONETARY="zh_CN.GBK" && export LC_MESSAGES="zh_CN.GBK" && export LC_ALL="zh_CN.GBK" ;}
EncodingToChUtf8() { export LANG="zh_CN.UTF-8" && export LC_CTYPE="zh_CN.UTF-8" && export LC_NUMERIC="zh_CN.UTF-8" && export LC_TIME="zh_CN.UTF-8" && export LC_COLLATE="zh_CN.UTF-8" && export LC_MONETARY="zh_CN.UTF-8" && export LC_MESSAGES="zh_CN.UTF-8" && export LC_ALL="zh_CN.UTF-8" ;}
killallStopped() { kill -9 $(jobs -ps | cut -d' ' -f4) ;}
upgradeConda() {
  os="Linux"
  if echo "$OSTYPE" | grep -q "darwin"; then # macOS
    os="MacOSX"
  fi;
  #[ -d ~/Miniconda2 ] || aria2c "https://repo.anaconda.com/miniconda/Miniconda2-latest-$os-x86_64.sh" && chmod 777 Miniconda2-latest-$os-x86_64.sh && bash Miniconda2-latest-$os-x86_64.sh -p ~/Miniconda2 -b -f && rm Miniconda2-latest-$os-x86_64.sh
  [ -d ~/Miniconda3 ] || aria2c "https://repo.anaconda.com/miniconda/Miniconda3-latest-$os-x86_64.sh" && chmod 777 Miniconda3-latest-$os-x86_64.sh && bash Miniconda3-latest-$os-x86_64.sh -p ~/Miniconda3 -b -f && rm Miniconda3-latest-$os-x86_64.sh
  [ $(command -v conda) ] && conda update -n base conda -y && conda update --all --yes && conda clean --yes --all
}
upgradePip() { pip3 install --upgrade pip setuptools && pip3 install --upgrade $(pip freeze -l | sed "s/==.*//") && pip3 install --upgrade https://github.com/pyca/pyopenssl/archive/main.zip && pip3 install --upgrade https://github.com/requests/requests/archive/main.zip ;}
upgradeDotfile() {
  [ -d ~/dotfile ] || git clone --depth 1 git@github.com:joeky888/dotfile.git ~/dotfile
  git -C ~/dotfile pull
  git -C ~/dotfile submodule update --init --remote

  rm -rf ~/.bashrc
  rm -rf ~/.bash_profile
  rm -rf ~/.tmux.conf
  rm -rf ~/.zshrc
  rm -rf ~/.nanorc
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
  rm -rf ~/.config/alacritty/alacritty.yml
  rm -rf ~/.alacritty.yml
  rm -rf ~/.myclirc
  rm -rf ~/.config/fish/config.fish
  rm -rf ~/.config/mpv/mpv.conf
  rm -rf ~/.config/mpv/input.conf
  rm -rf ~/.hammerspoon/init.lua

  mkdir -p ~/.grc
  ln -sf ~/dotfile/grc/grc.conf ~/.grc/grc.conf
  ln -sf ~/dotfile/grc/colourfiles/* ~/.grc/

  case $OSTYPE in
  cygwin)
    mkdir -p ~/AppData/Local/nvim/
    mkdir -p ~/AppData/Roaming/mpv
    mkdir -p ~/AppData/Roaming/alacritty
    mkdir -p ~/AppData/Roaming/Code/User
    mkdir -p ~/AppData/Roaming/VSCodium/User
    mkdir -p ~/Documents/WindowsPowerShell
    mkdir -p ~/.pip/
    mkdir -p ~/pip/
    mkdir -p ~/.config/fish/
    rm -rf ~/AppData/Roaming/Code/User/keybindings.json
    rm -rf ~/AppData/Roaming/Code/User/settings.json
    rm -rf ~/AppData/Roaming/VSCodium/User/keybindings.json
    rm -rf ~/AppData/Roaming/VSCodium/User/settings.json
    rm -rf ~/.config/fish/config.fish
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.bash_profile" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.tmux.conf" "%USERPROFILE%\dotfile\.tmux.conf"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.zshrc" "%USERPROFILE%\dotfile\.bashrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.nanorc" "%USERPROFILE%\dotfile\.nanorc"
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
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.myclirc" "%USERPROFILE%\dotfile\.myclirc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.alacritty.yml" "%USERPROFILE%\dotfile\.alacritty.yml"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1" "%USERPROFILE%\dotfile\powershell\profile.ps1"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfile\vimrc\.vimrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\.config\fish\config.fish" "%USERPROFILE%\dotfile\.config.fish"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\AppData\Local\nvim\init.vim" "%USERPROFILE%\dotfile\vimrc\.vimrc"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv\current\portable_config\mpv.conf" "%USERPROFILE%\dotfile\.mpv.conf"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv\current\portable_config\input.conf" "%USERPROFILE%\dotfile\.mpv.input.conf"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\mpv.conf" "%USERPROFILE%\dotfile\.mpv.conf"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\mpv-git\current\portable_config\input.conf" "%USERPROFILE%\dotfile\.mpv.input.conf"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\scoop\apps\wezterm\current\wezterm.lua" "%USERPROFILE%\dotfile\.wezterm.lua"
    cygstart --action=runas cmd.exe /c mklink "%USERPROFILE%\AppData\Roaming\alacritty\alacritty.yml" "%USERPROFILE%\dotfile\.alacritty.yml"
    cygstart --action=runas cmd.exe /c mklink "%APPDATA%\Code\User\settings.json" "%USERPROFILE%\dotfile\.vscode.settings.js"
    cygstart --action=runas cmd.exe /c mklink "%APPDATA%\VSCodium\User\settings.json" "%USERPROFILE%\dotfile\.vscode.settings.js"
    cygstart --action=runas cmd.exe /c mklink "%APPDATA%\Code\User\keybindings.json" "%USERPROFILE%\dotfile\.vscode.keybindings.js"
    cygstart --action=runas cmd.exe /c mklink "%APPDATA%\VSCodium\User\keybindings.json" "%USERPROFILE%\dotfile\.vscode.keybindings.js"
    ;;
  *)
    mkdir -p ~/.config/fish/
    mkdir -p ~/.config/nvim/
    mkdir -p ~/.config/alacritty/
    mkdir -p ~/.config/mpv/
    mkdir -p ~/.pip/
    ln -sf $HOME/dotfile/.bashrc ~/.bashrc
    ln -sf $HOME/dotfile/.bashrc ~/.bash_profile
    ln -sf $HOME/dotfile/.tmux.conf ~/.tmux.conf
    ln -sf $HOME/dotfile/.bashrc ~/.zshrc
    ln -sf $HOME/dotfile/.nanorc ~/.nanorc
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
    ln -sf $HOME/dotfile/vimrc/.vimrc ~/.vimrc
    ln -sf $HOME/dotfile/vimrc/.vimrc ~/.config/nvim/init.vim
    ln -sf $HOME/dotfile/.alacritty.yml ~/.config/alacritty/alacritty.yml
    ln -sf $HOME/dotfile/.alacritty.yml ~/.alacritty.yml
    ln -sf $HOME/dotfile/.myclirc ~/.myclirc
    ln -sf $HOME/dotfile/.mpv.conf ~/.config/mpv/mpv.conf
    ln -sf $HOME/dotfile/.mpv.input.conf ~/.config/mpv/input.conf
    ln -sf $HOME/dotfile/.config.fish ~/.config/fish/config.fish

    case $OSTYPE in
    linux-gnu)
      mkdir -p ~/.config/Code/User
      mkdir -p ~/.config/VSCodium/User
      ln -sf $HOME/dotfile/.vscode.settings.js ~/.config/Code/User/settings.json
      ln -sf $HOME/dotfile/.vscode.settings.js ~/.config/VSCodium/User/settings.json
      ln -sf $HOME/dotfile/.vscode.keybindings.js ~/.config/Code/User/keybindings.json
      ln -sf $HOME/dotfile/.vscode.keybindings.js ~/.config/VSCodium/User/keybindings.json
      ;;
    darwin)
      mkdir -p ~/.hammerspoon/
      mkdir -p "$HOME/Library/Application Support/Code/User"
      mkdir -p "$HOME/Library/Application Support/VSCodium/User"
      ln -sf $HOME/dotfile/MacOS/hammerspoon.lua ~/.hammerspoon/init.lua
      ln -sf $HOME/dotfile/.vscode.settings.js "$HOME/Library/Application Support/Code/User/settings.json"
      ln -sf $HOME/dotfile/.vscode.settings.js "$HOME/Library/Application Support/VSCodium/User/settings.json"
      ln -sf $HOME/dotfile/.vscode.keybindings.js "$HOME/Library/Application Support/Code/User/keybindings.json"
      ln -sf $HOME/dotfile/.vscode.keybindings.js "$HOME/Library/Application Support/VSCodium/User/keybindings.json"
      ;;
    esac
    ;;
  esac
}

stty -ixon -ixoff # In order to use Ctrl Q and ctrl S
stty lnext '^-' stop undef start undef -ixon # Unbind Ctrl V, replace with Ctrl _

git_branch_info() {
  if git rev-parse --git-dir 1>/dev/null 2>&1; then
    echo "* $(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  fi;
}

if [[ -n "$ZSH_VERSION" ]]; then # Zsh
  ZSH_THEME=""
  plugins=(git docker docker-compose adb golang rust)
  DISABLE_AUTO_UPDATE="true"
  if [ -n "$OHMYZSH_PATH" ]; then
    export ZSH=$OHMYZSH_PATH
    save_aliases=$(alias -L) # Store current aliases before oh-my-zsh
    source $ZSH/oh-my-zsh.sh
    # compdef vman=man # Don't do it, it takes too much time
    compdef Forever=sudo # Complete Forever as sudo command
    [ $(command -v apt) ] && compdef apt-fast=apt && compdef app-fast=apt # Complete apt-fast as apt command
    [ $(command -v pacman) ] && compdef yay=pacman && compdef app-fast=pacman # Complete app-fast as pacman command
    [ $(command -v brew) ] && compdef app-fast=brew # Complete app-fast as pacman command
    compdef CompleteAptCyg apt-cyg # Complete apt-cyg
    unset -f upgrade_oh_my_zsh # Remove this function
    unalias -m '*' # Remove all aliases
    eval $save_aliases; unset save_aliases # Restore all aliases

  else # Oh-my-zsh is not available
    alias -g ...='../..'
    alias -g ....='../../..'
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
  fi
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:';
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  autoload bashcompinit && bashcompinit
  autoload -U add-zsh-hook
  [ $(command -v pip) ] && eval "`pip completion --zsh --disable-pip-version-check` | tr -d '\r'"
  if (( $EUID != 0 )); then
    export MAIN_THEME='green'
  else
    export MAIN_THEME='red'
  fi
  if [ -n "$POWERLEVEL10K_PATH" ]; then # powerlevel10k.zsh-theme is available
    export POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='042'
    export POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'
    export POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND='001' # SSH
    export POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND='black' # SSH
    export POWERLEVEL9K_CONTEXT_REMOTE_TEMPLATE='%F{red}[REMOTE]%F%n@%m' # SSH
    export POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='039'
    export POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='black'
    export POWERLEVEL9K_DIR_HOME_BACKGROUND='039'
    export POWERLEVEL9K_DIR_HOME_FOREGROUND='black'
    export POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='039'
    export POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='black'
    export POWERLEVEL9K_VCS_BACKGROUND='011'
    export POWERLEVEL9K_VCS_FOREGROUND='black'
    export POWERLEVEL9K_VCS_CLEAN_BACKGROUND='011'
    export POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
    export POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='197'
    export POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
    export POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='197'
    export POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
    export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    export POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
    export POWERLEVEL9K_TIME_FOREGROUND='black'
    export POWERLEVEL9K_TIME_BACKGROUND='042' # Green time
    export POWERLEVEL9K_HISTORY_FOREGROUND='black'
    export POWERLEVEL9K_HISTORY_BACKGROUND='039'
#     export POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#     export POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="➜  "

    source $POWERLEVEL10K_PATH/powerlevel10k.zsh-theme
  else
    update_prompt() {
      NEWLINE_NO_OMZ=$'\n'
      # %B=light_color %F=color %K=background
      PROMPT="╭─%B%F{$MAIN_THEME}%n@%M%F{blue} %~%F{yellow}%K{default} $(git_branch_info) "${NEWLINE_NO_OMZ}"%K{default}%F{default}╰─%B%F{red}>%F{yellow}>%F{green}> "
    }
    update_prompt
    add-zsh-hook chpwd update_prompt
    add-zsh-hook preexec update_prompt
    add-zsh-hook precmd update_prompt
  fi
  zle_highlight=(none)
  if [ -n "$ZSH_SYNTAX_PATH" ]; then
    source $ZSH_SYNTAX_PATH/zsh-syntax-highlighting.zsh
    typeset -A ZSH_HIGHLIGHT_STYLES
    zle_highlight=(default:bold)
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line)
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
  if [ -n "$ZSH_AUTOSUGGESTIONS_PATH" ];then
    source $ZSH_AUTOSUGGESTIONS_PATH/zsh-autosuggestions.zsh
    export ZSH_AUTOSUGGEST_USE_ASYNC=1
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
  zle -N FindFilesToExec # Bind function to command
  zle -N Forever # Bind function to command
  zle -N OpenFileExplorer # Bind function to command
  export HISTFILE=$HOME/.bash_history
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
  bindkey "^G" FindFilesToExec # Ctrl G to execute command on multiple files
  bindkey "^F" Forever # Ctrl F to run a command Forever
  bindkey "^O" OpenFileExplorer # Ctrl O to open file explorer here
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
  elif [ -d /usr/share/bash-completion/completions ]; then
    for f in /usr/share/bash-completion/completions/*; do
      source $f
    done
  elif [ -f /usr/local/etc/bash_completion ]; then # macOS/FreeBSD
    source /usr/local/etc/bash_completion
  elif [ -d /usr/local/etc/bash_completion.d ]; then # macOS/FreeBSD
    for f in /usr/local/etc/bash_completion.d/*; do
      source $f
    done
  fi
  [ $(command -v pip) ] && eval "`pip completion --bash --disable-pip-version-check` | tr -d '\r'"
  [ $(command -v kubectl) ] && source <(kubectl completion bash)
  [ $(command -v helm) ] && source <(helm completion bash 2>/dev/null)
  [ $(command -v kubeadm) ] && source <(kubeadm completion bash)
  export HISTCONTROL=ignoredups:erasedups # Ignore duplicate entries in .bash_history
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
    bind -x '"\C-G": FindFilesToExec'  # Ctrl G to execute command on multiple files
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
  true
elif [[ "$OSTYPE" == "linux-android" ]]; then # Android Termux
  alias ls='ls -F --color=auto'
elif echo "$OSTYPE" | grep -q "darwin" ; then # macOS
  if [ $(command -v gls) ]; then
    alias ls='gls -F --color=auto --show-control-chars'
    alias l='ls -lah'
    alias ll='ls -la'
  else
    alias ls='ls -G'
  fi
  alias sudoedit='sudo vim'

  for tool in /usr/local/opt/*/bin; do
    export PATH="$tool:$PATH"
  done
  for tool in /usr/local/opt/*/libexec/gnubin; do
    export PATH="$tool:$PATH"
  done
  for m in /usr/local/opt/*/share/man; do
    export MANPATH="$m:$MANPATH"
  done
  for m in /usr/local/opt/*/libexec/gnuman; do
    export MANPATH="$m:$MANPATH"
  done

  [ -d "/Applications/Wine Staging.app/Contents/Resources/wine/bin" ] && export PATH="$PATH:'/Applications/Wine Staging.app/Contents/Resources/wine/bin'"
  [ -d "/Applications/Docker.app/Contents/Resources/bin" ] && export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
  [ -d "/Applications/calibre.app/Contents/MacOS" ] && export PATH="$PATH:/Applications/calibre.app/Contents/MacOS"
  [ -d "/Applications/VSCodium.app/Contents/Resources/app/bin/" ] && export PATH="$PATH:/Applications/VSCodium.app/Contents/Resources/app/bin"
  [ -d "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin" ] && export PATH="$PATH:'/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin'"
  [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ] && export PATH="$PATH:'/Applications/Visual Studio Code.app/Contents/Resources/app/bin'"

  export HOMEBREW_NO_INSTALL_CLEANUP=1
  [ $(command -v /usr/local/opt/golang/bin/go) ] && export GOROOT="/usr/local/opt/golang/libexec"
elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
  export DISPLAY=:0.0
  export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
#   alias apt-cyg-Manage='setup-x86_64.exe --package-manager --wait'
#   alias apt-cyg-Upgrade="aria2c 'https://cygwin.com/setup-x86_64.exe' && install setup-x86_64.exe /bin && rm setup-x86_64.exe && setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --upgrade-also --delete-orphans"
  alias sudo='cygstart --action=runas "$@"'
elif [[ "$OSTYPE" == "msys" ]]; then # Msys
  cd ~
elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
  true
else # Unknown OS
  true
fi

# Faster navigating, overwrite oh-my-zsh settings
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

export VCS_FOLDERS=".bzr,CVS,.git,.hg,.svn"
export VCS_FOLDERS_MORE="$VCS_FOLDERS,vendor,node_modules,ohmyzsh,dist,bin"
if echo "" | grep --exclude-dir=.cvs "" 2>/dev/null > /dev/null; then
  alias grep="grep --color=auto --exclude-dir={$VCS_FOLDERS}"
  alias grepi="grep --color=auto --exclude-dir={$VCS_FOLDERS_MORE}"
elif echo "" | grep --exclude=.cvs "" 2>/dev/null > /dev/null; then
  alias grepi="grep --color=auto --exclude={$VCS_FOLDERS_MORE}"
fi
alias rg="rg --hidden --glob '!{$(echo $VCS_FOLDERS_MORE)}'"
alias fd="fd --hidden --glob --exclude={$VCS_FOLDERS_MORE}"

hash mycli 2>/dev/null >/dev/null && alias mycli='LESS="-SRXF" mycli' # Disable word wrapping
hash litecli 2>/dev/null >/dev/null && alias litecli='LESS="-SRXF" litecli' # Disable word wrapping


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
          kubectl \
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

  function _kubectl () { true; }

  # Set alias for available commands.
  for cmd in "${cmds[@]}" ; do
    if [[ -n "$ZSH_VERSION" ]] && [ $(command -v $cmd) ] && [[ $(type compdef &>/dev/null) -eq 0 ]] && type _$cmd &>/dev/null ; then
      eval "function $cmd { grc -es $(command -v $cmd) \"\$@\" }"
      eval "compdef _$cmd $cmd"
    else
      [ $(command -v $cmd) ] && alias $cmd="grc -es $(command -v $cmd)"
    fi
  done

  alias configure='grc -es ./configure'
#   alias jobs='grc -es bash -c "jobs $@"' # Comment out because it breaks powerlevel9k theme
  alias limit='grc -es bash -c "limit $@"'
  alias ulimit='grc -es bash -c "ulimit $@"'

  if [ -n "$ZSH_VERSION" ] && hash kubectl 2>/dev/null >/dev/null; then
    source <(kubectl completion zsh)
    # [ $(command -v helm) ] && source <(helm completion zsh)
  fi

  if [ -n "$ZSH_VERSION" ] && hash helm 2>/dev/null >/dev/null; then
    eval "function helm { grc -es -c conf.kubectl $(command -v helm) \"\$@\" }"
    source <(helm completion zsh 2>/dev/null)
  fi

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
  MANPAGER=cat man $@ | col -bx | vim +"setlocal buftype=nofile" +"set filetype=man" - # buftype=nofile Make it read only and quit easily
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

  local DOWNLOADER_ARGUMENTS='-c -s16 -k1M -x16 -j16 -t2 --connect-timeout=2 --file-allocation=none' # 3s timeout for faster retrying
  local count=0
  $(exit 1)
  while [ $? -ne 0 ]; do
    echo "Retrying curlToAria2 ... $((count++))"
    local cmd="aria2c ${DOWNLOADER_ARGUMENTS} ${PARAMS}"
    echo "$cmd"
    eval "$cmd"
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

FindFilesToExec()
{
# find . -iname '*.jpg' -exec sh -c '$BUFFER mv "$0" "$0".backup' {} \;
  if [[ -n "$ZSH_VERSION" ]]; then
    BUFFER="find . -not -iwholename '*.git*' -iname '*.jpg' -exec sh -c '$BUFFER \"\$0\"' {} \;"
  elif [[ -n "$BASH_VERSION" ]]; then
    READLINE_LINE="find . -not -iwholename '*.git*' -iname '*.jpg' -exec sh -c '$READLINE_LINE \"\$0\"' {} \;"
  fi;
}

Forever()
{
  # Hit Ctrl-F to complete Forever function
  # Forever loop until the job is done
  # while true; do $* ; if [ $? -eq 0 ]; then break; fi; done ;
  if [[ -n "$ZSH_VERSION" ]]; then
    BUFFER='count=0; while true; do echo -e "\n$((count++)): $(date "+%m/%d/%Y %I:%M:%S:%p")"; '$BUFFER' && break; done ;'
  elif [[ -n "$BASH_VERSION" ]]; then
    READLINE_LINE='count=0; while true; do echo -e "\n$((count++)): $(date "+%m/%d/%Y %I:%M:%S:%p")"; '$READLINE_LINE' && break; done ;'
  fi;
}

OpenFileExplorer()
{
  background=$([ -n "$ZSH_VERSION" ] && echo '&!' || echo '&')
  if [ "$OSTYPE" = "linux-gnu" ] || echo "$OSTYPE" | grep -q "freebsd"; then # Linux + FreeBSD
    eval "xdg-open . > /dev/null 2>&1 $background"
  elif [ "$OSTYPE" = "msys" ] || [ "$OSTYPE" = "cygwin" ]; then # Windows
    explorer.exe .
  elif echo "$OSTYPE" | grep -q "darwin"; then # macOS
    open .
  else # Unknown OS
    true
  fi;
}

