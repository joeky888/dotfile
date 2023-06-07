Patch
=====
* In the function `play_episode()`
```sh
# Add These lines
YTDLP_ARGS="--concurrent-fragments 16 --no-check-certificate --ignore-errors --downloader aria2c"
case "$player_function" in
# ....
    yt-dlp) nohup sh -c "yt-dlp ${YTDLP_ARGS} -o - '$episode' | mpv --cache=yes --force-media-title='${allanime_title}episode-${ep_no}-${mode}' -" >/dev/null 2>&1 & ;;
    download) yt-dlp ${YTDLP_ARGS} "$episode" -o "${allanime_title}episode-${ep_no}-${mode}.mp4" ;;
# ....
esac
```
* $ `ANI_CLI_PLAYER=yt-dlp ./ani-cli --dub one punch`
