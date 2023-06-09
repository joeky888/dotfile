Patch
=====
* In the function `play_episode()`
```diff
 play_episode() {
     [ -z "$episode" ] && get_episode_url
+    YTDLP_ARGS="--concurrent-fragments 16 --no-check-certificate --ignore-errors --downloader aria2c"
     case "$player_function" in
+        yt-dlp) nohup sh -c "yt-dlp ${YTDLP_ARGS} -o - '$episode' | mpv --cache=yes --force-media-title='${allanime_title}episode-${ep_no}-${mode}' -" >/dev/null 2>&1 & ;;
         debug) printf "All links:\n%s\nSelected link:\n%s\n" "$links" "$episode" ;;
         mpv*) nohup "$player_function" --force-media-title="${allanime_title}episode-${ep_no}-${mode}" "$episode" >/dev/null 2>&1 & ;;
         android_mpv) nohup am start --user 0 -a android.intent.action.VIEW -d "$episode" -n is.xyz.mpv/.MPVActivity >/dev/null 2>&1 & ;;
@@ -259,7 +261,7 @@ play_episode() {
         flatpak_mpv) flatpak run io.mpv.Mpv --force-media-title="${allanime_title}episode-${ep_no}-${mode}" "$episode" >/dev/null 2>&1 & ;;
         vlc*) nohup "$player_function" --play-and-exit --meta-title="${allanime_title}episode-${ep_no}-${mode}" "$episode" >/dev/null 2>&1 & ;;
         *yncpla*) nohup "$player_function" "$episode" -- --force-media-title="${allanime_title}episode-${ep_no}-${mode}" >/dev/null 2>&1 & ;;
-        download) "$player_function" "$episode" "${allanime_title}episode-${ep_no}-${mode}" ;;
+        download) yt-dlp ${YTDLP_ARGS} "$episode" -o "${allanime_title}episode-${ep_no}-${mode}.mp4" ;;
         catt) nohup catt cast "$episode" >/dev/null 2>&1 & ;;
```
* $ `ANI_CLI_PLAYER=yt-dlp ./ani-cli --dub one punch`
