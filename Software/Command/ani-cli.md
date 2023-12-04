Patch
=====
* In the function `play_episode()`
```diff
 play_episode() {
     [ -z "$episode" ] && get_episode_url
-    case "$player_function" in
-        debug)
-            [ -z "$ANI_CLI_NON_INTERACTIVE" ] && printf "All links:\n%s\nSelected link:\n" "$links"
-            printf "%s\n" "$episode"
-            ;;
-        mpv*) nohup "$player_function" --force-media-title="${allanime_title}Episode ${ep_no}" "$episode" >/dev/null 2>&1
-        android_mpv) nohup am start --user 0 -a android.intent.action.VIEW -d "$episode" -n is.xyz.mpv/.MPVActivity >/dev
-        android_vlc) nohup am start --user 0 -a android.intent.action.VIEW -d "$episode" -n org.videolan.vlc/org.videolan
-        iina) nohup "$player_function" --no-stdin --keep-running --mpv-force-media-title="${allanime_title}Episode ${ep_n
-        flatpak_mpv) flatpak run io.mpv.Mpv --force-media-title="${allanime_title}Episode ${ep_no}" "$episode" >/dev/null
-        vlc*) nohup "$player_function" --play-and-exit --meta-title="${allanime_title}Episode ${ep_no}" "$episode" >/dev/
-        *yncpla*) nohup "$player_function" "$episode" -- --force-media-title="${allanime_title}Episode ${ep_no}" >/dev/nu
-        download) "$player_function" "$episode" "${allanime_title}Episode ${ep_no}" ;;
-        catt) nohup catt cast "$episode" >/dev/null 2>&1 & ;;
-        iSH)
-            printf "\e]8;;vlc://%s\a~~~~~~~~~~~~~~~~~~~~\n~ Tap to open VLC ~\n~~~~~~~~~~~~~~~~~~~~\e]8;;\a\n" "$episode"
-            sleep 5
-            ;;
-        *) nohup "$player_function" "$episode" >/dev/null 2>&1 & ;;
-    esac
+    YTDLP_ARGS="--concurrent-fragments 16 --no-check-certificate --ignore-errors --downloader aria2c --no-cache-dir"
+    STREAMLINK_ARGUMENTS="--loglevel debug --verbose-player --player-no-close --stream-segment-threads 10 --twitch-low-latency --http-no-ssl-verify --title '{title}' --stream-segment-attempts 1000 --stream-segment-timeout 10 --stream-segment-attempts 1000 --stream-segment-timeout 10 --retry-open 10 --retry-max 10 --retry-streams 1"
+
+    if [[ "$(uname -a)" == *ndroid* ]]; then # Termux: yt-dlp + vlc
+        nohup am start --user 0 -a android.intent.action.VIEW -d $(yt-dlp $DL_ARGUMENTS -f 'b' --get-url "$episode") -n org.videolan.vlc/org.videolan.vlc.gui.video.VideoPlayerActivity -e "title" "${allanime_title}Episode ${ep_no}" >/dev/null 2>&1 &
+    elif [[ "$episode" == *m3u8 ]]; then # Desktop m3u8: streamlink + mpv
+        nohup sh -c "streamlink $STREAMLINK_ARGUMENTS --player 'mpv' --player-arg '--cache=yes' --title '${allanime_title}Episode ${ep_no}' --default-stream best '$episode'" >/dev/null 2>&1 &
+    else # yt-dlp + mpv
+        nohup sh -c "yt-dlp ${YTDLP_ARGS} -o - '$episode' | mpv --cache=yes --force-media-title='${allanime_title}Episode ${ep_no}' -" >/dev/null 2>&1 &
+    fi
```
* $ `ANI_CLI_PLAYER=yt-dlp ./ani-cli --dub one punch`
* $ `ANI_CLI_PLAYER=android_vlc bash ./ani-cli --dub one punch` # Termux
