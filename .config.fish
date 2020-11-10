set fish_greeting # Disable fish messages on start

bind -k up history-prefix-search-backward
bind -k down history-prefix-search-forward
bind \eOA history-prefix-search-backward
bind \eOB history-prefix-search-forward
bind \e\[A history-prefix-search-backward
bind \e\[B history-prefix-search-forward

function fish_prompt --description 'Write out the prompt'
#     set -l last_pipestatus $pipestatus
#     set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set fish_color_user red --bold
    set fish_color_host cyan --bold
    set fish_color_cwd green --bold

    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_color_branch yellow --bold
    set -g __fish_git_prompt_color_dirtystate red
    set -g __fish_git_prompt_color_stagedstate red
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_untrackedfiles red
    set -g __fish_git_prompt_color_cleanstate yellow --bold

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix \n'>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix \n'#'
    end



    echo -n -s (set_color $fish_color_user) "$USER" $normal @ (set_color $fish_color_host) (prompt_hostname) $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end

set -U fish_user_paths ~/dotfile/app-fast $fish_user_paths
set -U fish_user_paths ~/dotfile/inxi $fish_user_paths
set -U fish_user_paths ~/dotfile/diff-highlight $fish_user_paths

set DL_ARGUMENTS "-o '%(title)s.%(ext)s' --write-sub --all-subs --embed-subs --hls-prefer-native --no-check-certificate --ignore-errors"
set PLAYER_ARGUMENTS "--cache=yes --cache-dir=/tmp --cache-on-disk=yes --ytdl-raw-options=no-check-certificate=,yes-playlist=,ignore-errors="
set DOWNLOADER_ARGUMENTS "--continue=true --timeout=12 --connect-timeout=12 --content-disposition-default-utf8=true --check-certificate=false --max-tries=2 --max-concurrent-downloads=150 --max-connection-per-server=16 --split=16 --min-split-size=1M --parameterized-uri=false" # aria2 & bypy
set TORRENT_ARGUMENTS "--enable-dht=true --bt-enable-lpd=true --bt-max-peers=0 --bt-request-peer-speed-limit=100M --seed-ratio=0 --bt-detach-seed-only=true --seed-time=0 --enable-peer-exchange=true --bt-tracker-connect-timeout=10 --bt-tracker-timeout=5"

alias aria2c="aria2c $DOWNLOADER_ARGUMENTS"
alias aria2c-bt-qBittorrent="aria2c $DOWNLOADER_ARGUMENTS $TORRENT_ARGUMENTS --user-agent='qBittorrent/4.1.1' --peer-id-prefix='-qB4110-' --bt-tracker=(curl -s https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt | tr -s '\n' | tr '\n' ',')"
alias youtube-dl="youtube-dl $DL_ARGUMENTS --external-downloader aria2c --external-downloader-args '$DOWNLOADER_ARGUMENTS'"
alias youtube-dl-720="youtube-dl -f 'bestvideo[height<=720][fps<=30][ext=mp4]+bestaudio/best'"
alias youtube-dl-1080="youtube-dl -f 'bestvideo[height<=1080][fps<=30][ext=mp4]+bestaudio/best'"
alias upgradeYoutubedl='pip install --upgrade https://github.com/l1ving/youtube-dl/archive/master.zip'

