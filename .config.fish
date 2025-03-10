# Disable fish messages on start
set fish_greeting

# Docs: https://fishshell.com/docs/current/cmds/bind.html
bind -k up history-prefix-search-backward
bind -k down history-prefix-search-forward
bind \eOA history-prefix-search-backward
bind \eOB history-prefix-search-forward
bind \e\[A history-prefix-search-backward
bind \e\[B history-prefix-search-forward
bind \e\[1\;2A history-prefix-search-backward
bind \e\[1\;2B history-prefix-search-forward
bind \e\[1\;3A history-prefix-search-backward
bind \e\[1\;3B history-prefix-search-forward
bind \e\[1\;5A history-prefix-search-backward
bind \e\[1\;5B history-prefix-search-forward
bind \e\[1\;9A history-prefix-search-backward
bind \e\[1\;9B history-prefix-search-forward
bind \cr history-token-search-backward
# bind \cZ undo # Available in fish >= 3.2.0
# bind \cY redo # Available in fish >= 3.2.0

set -U fish_user_paths ""
set -U fish_user_paths $HOME/dotfile/app-fast $fish_user_paths
set -U fish_user_paths $HOME/dotfile/diff-highlight $fish_user_paths
set -U fish_user_paths $HOME/bin $fish_user_paths
set -U fish_user_paths $HOME/go/bin $fish_user_paths

if test -f /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end

if type -q fnm
  fnm env --use-on-cd | source
end

if type -q starship
  starship init fish | source
else
  set fish_prompt_pwd_dir_length 0 # Show full path on the prompt

  # For command line highlighting
  set fish_color_command green --bold
  set fish_color_comment black --bold

  # For prompt
  set fish_color_cwd cyan --bold
  set fish_color_cwd_root red --bold
  set fish_color_user red --bold
  set fish_color_host green --bold
  set fish_color_quote bryellow
  set fish_color_comment brblack
  set -g __fish_git_prompt_showdirtystate 1 # This takes too much time
  set -g __fish_git_prompt_showuntrackedfiles 1
  set -g __fish_git_prompt_color_branch yellow --bold
  set -g __fish_git_prompt_color_dirtystate red # This takes too much time
  set -g __fish_git_prompt_color_stagedstate red
  set -g __fish_git_prompt_color_invalidstate red
  set -g __fish_git_prompt_color_untrackedfiles red
  set -g __fish_git_prompt_color_cleanstate yellow --bold


  # Aync git promt
  # Ref: https://github.com/pure-fish/pure/wiki/Async-git-Prompt
  # Ref: https://github.com/acomagu/fish-async-prompt

  function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -l red (set_color red --bold)
    set -l yellow (set_color yellow --bold)
    set -l green (set_color green --bold)

    set color_status green
    set print_status "✓"
    if [ "$last_pipestatus" -ne "0" ]
      set color_status red
      set print_status "$last_pipestatus"
    end

    # Color the prompt differently when we're root
    # if functions -q fish_is_root_user; and fish_is_root_user
    if test (id -u) -eq 0
      set color_cwd $fish_color_cwd_root
      set suffix '#'
    else
      set color_cwd $fish_color_cwd
      set suffix '>'
    end

    echo -n -s (set_color $fish_color_user)"$USER" $normal @ (set_color $fish_color_host) (prompt_hostname) $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal (set_color $color_status) " $print_status" $normal\n$red$suffix$yellow$suffix$green$suffix' '
  end

  status is-interactive
  or exit 0

  set -g __async_prompt_tmpdir "$XDG_RUNTIME_DIR"
  test -z "$__async_prompt_tmpdir"
  and set -g __async_prompt_tmpdir "$TMPDIR"

  test -z "$__async_prompt_tmpdir"
  and set -g __async_prompt_tmpdir "$TMP"

  test -z "$__async_prompt_tmpdir"
  and set -g __async_prompt_tmpdir (command mktemp -d)

  mkdir -p $__async_prompt_tmpdir

  # Setup after the user defined prompt functions are loaded.
  function __async_prompt_setup_on_startup --on-event fish_prompt
    functions -e (status current-function)

    for func in (__async_prompt_config_functions)
      function $func -V func
        test -e $__async_prompt_tmpdir'/'$fish_pid'_'$func
        and cat $__async_prompt_tmpdir'/'$fish_pid'_'$func
      end
    end
  end

  function __async_prompt_fire --on-event fish_prompt
    set st $status

    for func in (__async_prompt_config_functions)
      set -l tmpfile $__async_prompt_tmpdir'/'$fish_pid'_'$func

      if functions -q $func'_loading_indicator' && test -e $tmpfile
        read -zl last_prompt <$tmpfile
        eval (string escape -- $func'_loading_indicator' "$last_prompt") >$tmpfile
      end

      __async_prompt_config_inherit_variables | __async_prompt_spawn $st \
        $func' | read -z prompt
        echo -n $prompt >'$tmpfile
    end
  end

  function __async_prompt_spawn
    set -l envs
    begin
      set st $argv[1]
      while read line
        switch "$line"
          case FISH_VERSION PWD _ history 'fish_*' hostname version
          case status
            echo status $st
          case SHLVL
            set envs $envs SHLVL=(math $SHLVL - 1)
          case '*'
            echo $line (string escape -- $$line)
        end
      end
    end | read -lz vars
    echo $vars | env $envs fish -c '
    function __async_prompt_set_status
      return $argv
    end
    function __async_prompt_signal
      kill -s "'(__async_prompt_config_internal_signal)'" '$fish_pid'
    end
    while read -a line
      test -z "$line"
      and continue
      if test "$line[1]" = status
        set st $line[2]
      else
        eval set "$line"
      end
    end
    not set -q st
    and true
    or __async_prompt_set_status $st
    '$argv[2]'
    __async_prompt_signal
    sleep 0.3
    __async_prompt_signal
    sleep 0.3
    __async_prompt_signal' &
    disown
  end

  function __async_prompt_config_inherit_variables
    if set -q async_prompt_inherit_variables
      if test "$async_prompt_inherit_variables" = all
        set -ng
      else
        for item in $async_prompt_inherit_variables
          echo $item
        end
      end
    else
      echo status
      echo SHLVL
      echo CMD_DURATION
    end
  end

  function __async_prompt_config_functions
    set -l funcs (
      if set -q $async_prompt_functions
        string join \n $async_prompt_functions
      else
        echo fish_prompt
        echo fish_right_prompt
      end
    )
    for func in $funcs
      functions -q "$func"
      or continue

      echo $func
    end
  end

  function __async_prompt_config_internal_signal
    if test -z "$async_prompt_signal_number"
      echo SIGUSR1
    else
      echo "$async_prompt_signal_number"
    end
  end

  function __async_prompt_repaint_prompt --on-signal (__async_prompt_config_internal_signal)
    commandline -f repaint >/dev/null 2>/dev/null
  end

  # Enable async prompt
  set async_prompt_functions _pure_prompt_git
end

set DL_ARGUMENTS "-o '%(title)s.%(ext)s' --write-sub --all-subs --embed-subs --embed-metadata --sponsorblock-remove all --hls-prefer-native --no-check-certificate --ignore-errors"
set PLAYER_ARGUMENTS "--cache=yes --demuxer-cache-dir=/tmp --cache-on-disk=yes --ytdl-raw-options=no-check-certificate=,yes-playlist=,hls-prefer-native=,ignore-errors=,write-auto-sub=,write-sub=,sub-lang='(en|zh).*'"
set DOWNLOADER_ARGUMENTS "--file-allocation=prealloc --continue=true --timeout=12 --connect-timeout=12 --content-disposition-default-utf8=true --check-certificate=false --max-tries=10 --max-concurrent-downloads=150 --max-connection-per-server=16 --split=16 --min-split-size=1M --http-accept-gzip=true --parameterized-uri=false" # aria2 & bypy
set TORRENT_ARGUMENTS "--enable-dht=true --enable-dht6=true --bt-enable-lpd=true --bt-max-peers=0 --bt-request-peer-speed-limit=100M --seed-ratio=0 --bt-detach-seed-only=true --seed-time=0 --enable-peer-exchange=true --bt-tracker-connect-timeout=10 --bt-tracker-timeout=5 --max-upload-limit=25K"
set VCS_FOLDERS "**/.bzr/*,**/CVS/*,**/.git/*,**/.hg/*,**/.svn/*"
set VCS_FOLDERS_MORE "$VCS_FOLDERS,**/vendor/*,**/node_modules/*,**/ohmyzsh/*,**/dist/*,**/bin/*"
set NIXPKGS_ALLOW_UNFREE 1
set PIP_USE_FEATURE "fast-deps" # Enable pip parallel downloading
set STREAMLINK_ARGUMENTS "--loglevel debug --verbose-player --player-no-close --stream-segment-threads 10 --twitch-low-latency --http-no-ssl-verify --title '{title}' --stream-segment-attempts 1000 --stream-segment-timeout 10 --retry-open 10 --retry-max 10 --retry-streams 1"

# Faster navigating, overwrite oh-my-zsh settings
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias l='ls -lah'
alias aria2c="aria2c $DOWNLOADER_ARGUMENTS"
alias aria2c-bt-qBittorrent="aria2c $DOWNLOADER_ARGUMENTS $TORRENT_ARGUMENTS --user-agent='qBittorrent/4.1.1' --peer-id-prefix='-qB4110-' --bt-tracker=(curl -s https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | tr -s '\n' | tr '\n' ',')"
alias yt-dlp="yt-dlp $DL_ARGUMENTS"
alias yt-dlp-audio='yt-dlp --extract-audio'
alias yt-dlp-audio-MP3='yt-dlp --extract-audio --audio-format mp3'
alias yt-dlp-aria2c="yt-dlp $DL_ARGUMENTS --external-downloader aria2c --external-downloader-args '$DOWNLOADER_ARGUMENTS'"
alias yt-dlp-480="yt-dlp -f 'bestvideo[height<=480][fps<=30][vcodec!^=av01]+bestaudio/best'"
alias yt-dlp-720="yt-dlp -f 'bestvideo[height<=720][fps<=30][vcodec!^=av01]+bestaudio/best'"
alias yt-dlp-1080="yt-dlp -f 'bestvideo[height<=1080][fps<=60][vcodec!^=av01]+bestaudio/best'"
alias upgradeYtdlp='pip install --upgrade --force-reinstall --no-cache-dir https://github.com/yt-dlp/yt-dlp/archive/master.zip'
alias upgradeStreamlink='pip3 install --upgrade --force-reinstall --no-cache-dir https://github.com/streamlink/streamlink/archive/master.zip'
alias upgradeGopeed='go install github.com/GopeedLab/gopeed/cmd/gopeed@main'
alias python3-simple-server='python3 -m http.server'
alias termux-ssh-server-start='pkill sshd; echo "listening :8022"; sshd -D -p 8022'
alias curl='curl --retry 0 --connect-timeout 10 --max-time 10 --retry-delay 0 --retry-max-time 20 --compressed -H "Accept-Encoding: gzip,br,deflate,zstd" --user-agent "(yt-dlp --dump-user-agent)" -LC - '
alias curl-status='curl -o /dev/null --fail -L -s -w "HTTP%{http_version}\nContent Type: %{content_type}\nStatus Code: %{response_code}\nNumber of Redirects: %{num_redirects}\nSize: %{size_download}Bytes\nSpeed of Download: %{speed_download}Bytes/s\nServer IP: %{remote_ip}:%{remote_port}\nServer Final URL: %{url_effective}\n\nDNS Resolve: %{time_namelookup}s\nClient -> Server: %{time_connect}s\nServer Response: %{time_starttransfer}s\nTotal time: %{time_total}s\n"'
alias rg="rg --hidden --ignore-case --glob '!{$VCS_FOLDERS_MORE}'"
alias fd="fd --hidden --ignore-case --glob --exclude={$VCS_FOLDERS_MORE}"
alias upgradeBashrc="curl -L https://raw.githubusercontent.com/joeky888/dotfile/master/.bashrc > ~/.bashrc"
alias upgradeFishrc="mkdir -p ~/.config/fish; curl -L https://raw.githubusercontent.com/joeky888/dotfile/master/.config.fish > ~/.config/fish/config.fish"
alias upgradeHelixConf="mkdir -p ~/.config/helix; curl -L https://raw.githubusercontent.com/joeky888/dotfile/master/.helix.config.toml > ~/.config/helix/config.toml"
alias upgradeTmuxrc="curl -L https://raw.githubusercontent.com/joeky888/dotfile/master/.tmux.conf > ~/.tmux.conf"
alias streamlink-mpv-termux="streamlink --loglevel debug --verbose-player --player 'am start -n is.xyz.mpv/.MPVActivity -a android.intent.action.VIEW -d' --player-http --stream-segment-threads 10 --title '{title}' --default-stream best"
alias streamlink-vlc-termux="streamlink --loglevel debug --verbose-player --player 'am start -n org.videolan.vlc/org.videolan.vlc.gui.video.VideoPlayerActivity -a android.intent.action.VIEW -d' --player-http --stream-segment-threads 10 --title '{title}' --default-stream best"

function upgradeDotfile
  if not test -d ~/dotfile; git clone --depth 1 git@github.com:joeky888/dotfile.git ~/dotfile; end
  git -C ~/dotfile pull
  git -C ~/dotfile submodule update --init --remote
end

function vman
  MANPAGER=cat man $argv | col -bx | vim +"setlocal buftype=nofile" +"set filetype=man" -
end

function upgradePip
  pip3 install --upgrade pip setuptools
  pip3 install --upgrade (pip freeze -l | sed "s/==.*//")
  pip3 install --upgrade https://github.com/pyca/pyopenssl/archive/main.zip
  pip3 install --upgrade https://github.com/requests/requests/archive/main.zip
end

function mpv-termux-ytdlp
  am start -a android.intent.action.VIEW -n is.xyz.mpv/.MPVActivity -d (yt-dlp $DL_ARGUMENTS -f 'best' --get-url $argv)
end

function mpv-termux-ytdlp-audio
  am start -a android.intent.action.VIEW -n is.xyz.mpv/.MPVActivity -d (yt-dlp $DL_ARGUMENTS -f 'bestaudio/best' --no-video --get-url $argv)
end

function vlc-termux-ytdlp
  # Ref: https://wiki.videolan.org/Android_Player_Intents/
  am start -a android.intent.action.VIEW -n org.videolan.vlc/.StartActivity -e "title" (yt-dlp --get-title $argv) -d (yt-dlp $DL_ARGUMENTS -f 'best' --get-url $argv)
end

function vlc-termux-ytdlp-audio
  am start -a android.intent.action.VIEW -n org.videolan.vlc/.StartActivity -e "title" (yt-dlp --get-title $argv) -d (yt-dlp $DL_ARGUMENTS -f 'bestaudio/best' --no-video --get-url $argv)
end

# VLC is unable to auto-launch on android 13+, so just manully open vlc and play http://127.0.0.1:4567
# alias vlc-termux-streamlink-best="streamlink $STREAMLINK_ARGUMENTS --player 'am' --player-http --player-arg 'start --user 0 -a android.intent.action.VIEW -n org.videolan.vlc/.StartActivity -d vlc://{playerinput}' --default-stream best"
function vlc-termux-streamlink-best-httpstream
  killall -9 streamlink || true
  bash -c "streamlink $STREAMLINK_ARGUMENTS --player-external-http --player-external-http-port 34567 --default-stream best '$argv'" &
  sleep 20s
  nohup am start --user 0 -a android.intent.action.VIEW -d "http://127.0.0.1:34567" -n org.videolan.vlc/org.videolan.vlc.gui.video.VideoPlayerActivity >/dev/null 2>&1 &
end

function getCondaPath
  set -l Possible_Prefix "$HOME" \
                           "/usr/local" \
                           "/usr/local/homebrew"
  set -l Possible_Path "Miniconda$argv[1]" \
                         "miniconda$argv[1]" \
                         "Miniforge$argv[1]" \
                         "miniforge$argv[1]"

  for pre in $Possible_Prefix
    for pth in $Possible_Path
      if test -d "$pre/$pth"
        echo "$pre/$pth"
        return
      end
    end
  end
  echo ""
end

set CONDA_3 (getCondaPath 3)
if test -n "$CONDA_3"
  set -x PATH "$CONDA_3/bin" $PATH
  alias conda3="$CONDA_3/bin/conda"
  alias pip3="$CONDA_3/bin/pip"

  function upgradeConda3
    "$CONDA_3/bin/conda" update --no-channel-priority --all --yes
    "$CONDA_3/bin/conda" clean --yes --all
  end

  function upgradePip3
    "$CONDA_3/bin/pip" install --upgrade pip setuptools
    "$CONDA_3/bin/pip" install --upgrade (pip freeze -l | sed "s/==.*//")
    "$CONDA_3/bin/pip" install --upgrade https://github.com/pyca/pyopenssl/archive/main.zip
    "$CONDA_3/bin/pip" install --upgrade https://github.com/requests/requests/archive/main.zip
  end
end


# Load Nix config
# Set up the per-user profile.
# This part should be kept in sync with nixpkgs:nixos/modules/programs/shell.nix

set -l NIX_LINK $HOME/.nix-profile

# Set up environment.
# This part should be kept in sync with nixpkgs:nixos/modules/programs/environment.nix
set -g -x NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"

# Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.
if test -e /etc/ssl/certs/ca-certificates.crt
  set -g -x NIX_SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
else if test -e /etc/ssl/ca-bundle.pem # openSUSE Tumbleweed
  set -g -x NIX_SSL_CERT_FILE /etc/ssl/ca-bundle.pem
else if test -e /etc/ssl/certs/ca-bundle.crt # Old NixOS
  set -g -x NIX_SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt
else if test -e /etc/pki/tls/certs/ca-bundle.crt # Fedora, CentOS
  set -g -x NIX_SSL_CERT_FILE /etc/pki/tls/certs/ca-bundle.crt
else if test -e "$NIX_LINK/etc/ssl/certs/ca-bundle.crt" # fall back to cacert in Nix profile
  set -g -x NIX_SSL_CERT_FILE "$NIX_LINK/etc/ssl/certs/ca-bundle.crt"
else if test -e "$NIX_LINK/etc/ca-bundle.crt" # old cacert in Nix profile
  set -g -x NIX_SSL_CERT_FILE "$NIX_LINK/etc/ca-bundle.crt"
end

# Only use MANPATH if it is already set. In general `man` will just simply
# pick up `.nix-profile/share/man` because is it close to `.nix-profile/bin`
# which is in the $PATH. For more info, run `manpath -d`.
set -g -x MANPATH "$NIX_LINK/share/man:$MANPATH"
set -U fish_user_paths $NIX_LINK/bin $fish_user_paths

# NIX CHANNELS
if not test -e $HOME/.nix-channels
  echo 'http://nixos.org/channels/nixpkgs-unstable nixpkgs' > $HOME/.nix-channels
end

# Load grc and completions
type -q helm; and helm completion fish 2>/dev/null | source
type -q kubectl; and kubectl completion fish | source

set -U grc_plugin_execs cat cvs df diff dig gcc g++ ifconfig \
       make mount mtr netstat ping ps tail traceroute \
       wdiff blkid du dnf docker docker-compose docker-machine id ip iostat journalctl kubectl \
       last lsattr lsblk lspci lsmod lsof getfacl getsebool ulimit uptime nmap \
       fdisk findmnt free semanage sar ss sysctl systemctl stat showmount \
       tcpdump tune2fs vmstat w who sockstat

if type -q grc
  for executable in $grc_plugin_execs
    if type -q $executable
      function $executable --inherit-variable executable --wraps=$executable
        if isatty 1
          grc $executable $argv
        else
          eval command $executable $argv
        end
      end
    end
  end
end

# Load arkade
set -U fish_user_paths $HOME/.arkade/bin $fish_user_paths

