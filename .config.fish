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
set -U fish_user_paths $HOME/dotfile/inxi $fish_user_paths
set -U fish_user_paths $HOME/dotfile/diff-highlight $fish_user_paths
set -U fish_user_paths $HOME/scoop/shims $fish_user_paths

# For command line highlighting
set fish_color_command green --bold
set fish_color_comment black --bold

# For prompt
set fish_color_cwd green --bold
set fish_color_user red --bold
set fish_color_host cyan --bold
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

  set color_status green
  set print_status "✓"
  if [ "$last_pipestatus" != "0" ]
  set color_status red
  set print_status "$last_pipestatus"
  end

  # Color the prompt differently when we're root
  set -l color_cwd $fish_color_cwd
  set -l suffix \n'> '
  if functions -q fish_is_root_user; and fish_is_root_user
  if set -q fish_color_cwd_root
    set color_cwd $fish_color_cwd_root
  end
  set suffix \n'# '
  end

  echo -n -s (set_color $fish_color_user) "$USER" $normal @ (set_color $fish_color_host) (prompt_hostname) $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal (set_color $color_status) " $print_status" $normal $suffix
end

status is-interactive
or exit 0

set -g __async_prompt_tmpdir (command mktemp -d)
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

set DL_ARGUMENTS "-o '%(title)s.%(ext)s' --write-sub --all-subs --embed-subs --hls-prefer-native --no-check-certificate --ignore-errors"
set PLAYER_ARGUMENTS "--cache=yes --cache-dir=/tmp --cache-on-disk=yes --ytdl-raw-options=no-check-certificate=,yes-playlist=,ignore-errors="
set DOWNLOADER_ARGUMENTS "--continue=true --timeout=12 --connect-timeout=12 --content-disposition-default-utf8=true --check-certificate=false --max-tries=2 --max-concurrent-downloads=150 --max-connection-per-server=16 --split=16 --min-split-size=1M --parameterized-uri=false" # aria2 & bypy
set TORRENT_ARGUMENTS "--enable-dht=true --bt-enable-lpd=true --bt-max-peers=0 --bt-request-peer-speed-limit=100M --seed-ratio=0 --bt-detach-seed-only=true --seed-time=0 --enable-peer-exchange=true --bt-tracker-connect-timeout=10 --bt-tracker-timeout=5"
set VCS_FOLDERS ".bzr,CVS,.git,.hg,.svn"
set VCS_FOLDERS_MORE "$VCS_FOLDERS,vendor,node_modules,ohmyzsh,dist,bin"

# Faster navigating, overwrite oh-my-zsh settings
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias aria2c="aria2c $DOWNLOADER_ARGUMENTS"
alias aria2c-bt-qBittorrent="aria2c $DOWNLOADER_ARGUMENTS $TORRENT_ARGUMENTS --user-agent='qBittorrent/4.1.1' --peer-id-prefix='-qB4110-' --bt-tracker=(curl -s https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt | tr -s '\n' | tr '\n' ',')"
alias youtube-dl="youtube-dl $DL_ARGUMENTS --external-downloader aria2c --external-downloader-args '$DOWNLOADER_ARGUMENTS'"
alias youtube-dl-720="youtube-dl -f 'bestvideo[height<=720][fps<=30][ext=mp4]+bestaudio/best'"
alias youtube-dl-1080="youtube-dl -f 'bestvideo[height<=1080][fps<=30][ext=mp4]+bestaudio/best'"
alias upgradeYoutubedl='pip install --upgrade https://github.com/ytdl-org/youtube-dl/archive/master.zip'
alias python3-simple-server='python3 -m http.server'
alias termux-ssh-server-start='pkill sshd; echo "listening :8022"; sshd -D -p 8022'
alias curl='curl --retry 0 --connect-timeout 10 --max-time 10 --retry-delay 0 --retry-max-time 20 --compressed -H "Accept-Encoding: gzip,compress,deflate,br" --user-agent "(youtube-dl --dump-user-agent)" -LC - '
alias rg="rg --hidden --glob '!{$VCS_FOLDERS_MORE}'"
alias fd="fd --hidden --glob --exclude={$VCS_FOLDERS_MORE}"

function upgradeDotfile
  if not test -d ~/dotfile; git clone --depth 1 https://github.com/joeky888/dotfile.git ~/dotfile; end
  git -C ~/dotfile pull
  git -C ~/dotfile submodule update --init --remote
end

function vman
  MANPAGER=cat man $argv | col -bx | vim +"setlocal buftype=nofile" +"set filetype=man" -
end
