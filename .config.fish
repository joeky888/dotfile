set fish_greeting # Disable fish messages on start

# Docs: https://fishshell.com/docs/current/cmds/bind.html
bind -k up history-prefix-search-backward
bind -k down history-prefix-search-forward
bind \eOA history-prefix-search-backward
bind \eOB history-prefix-search-forward
bind \e\[A history-prefix-search-backward
bind \e\[B history-prefix-search-forward
bind \cr history-token-search-backward
# bind \cZ undo # Available in fish >= 3.2.0
# bind \cY redo # Available in fish >= 3.2.0

set -U fish_user_paths ""
set -U fish_user_paths $HOME/dotfile/app-fast $fish_user_paths
set -U fish_user_paths $HOME/dotfile/inxi $fish_user_paths
set -U fish_user_paths $HOME/dotfile/diff-highlight $fish_user_paths

# For command line highlighting
set fish_color_command green --bold
set fish_color_comment black --bold

# For prompt
set fish_color_cwd green --bold
set fish_color_user red --bold
set fish_color_host cyan --bold
set fish_color_quote bryellow
set fish_color_comment brblack
set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_color_branch yellow --bold
set -g __fish_git_prompt_color_dirtystate red
set -g __fish_git_prompt_color_stagedstate red
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles red
set -g __fish_git_prompt_color_cleanstate yellow --bold

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

set DL_ARGUMENTS "-o '%(title)s.%(ext)s' --write-sub --all-subs --embed-subs --hls-prefer-native --no-check-certificate --ignore-errors"
set PLAYER_ARGUMENTS "--cache=yes --cache-dir=/tmp --cache-on-disk=yes --ytdl-raw-options=no-check-certificate=,yes-playlist=,ignore-errors="
set DOWNLOADER_ARGUMENTS "--continue=true --timeout=12 --connect-timeout=12 --content-disposition-default-utf8=true --check-certificate=false --max-tries=2 --max-concurrent-downloads=150 --max-connection-per-server=16 --split=16 --min-split-size=1M --parameterized-uri=false" # aria2 & bypy
set TORRENT_ARGUMENTS "--enable-dht=true --bt-enable-lpd=true --bt-max-peers=0 --bt-request-peer-speed-limit=100M --seed-ratio=0 --bt-detach-seed-only=true --seed-time=0 --enable-peer-exchange=true --bt-tracker-connect-timeout=10 --bt-tracker-timeout=5"

alias aria2c="aria2c $DOWNLOADER_ARGUMENTS"
alias aria2c-bt-qBittorrent="aria2c $DOWNLOADER_ARGUMENTS $TORRENT_ARGUMENTS --user-agent='qBittorrent/4.1.1' --peer-id-prefix='-qB4110-' --bt-tracker=(curl -s https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt | tr -s '\n' | tr '\n' ',')"
alias youtube-dl="youtube-dl $DL_ARGUMENTS --external-downloader aria2c --external-downloader-args '$DOWNLOADER_ARGUMENTS'"
alias youtube-dl-720="youtube-dl -f 'bestvideo[height<=720][fps<=30][ext=mp4]+bestaudio/best'"
alias youtube-dl-1080="youtube-dl -f 'bestvideo[height<=1080][fps<=30][ext=mp4]+bestaudio/best'"
alias upgradeYoutubedl='pip install --upgrade https://github.com/ytdl-org/youtube-dl/archive/master.zip'

function upgradeDotfile
    if not test -d ~/dotfile; git clone --depth 1 https://github.com/joeky888/dotfile.git ~/dotfile; end
    git -C ~/dotfile pull
    git -C ~/dotfile submodule update --init --remote
end

function vman
    MANPAGER=cat man $argv | col -bx | vim +"setlocal buftype=nofile" +"set filetype=man" -
end
