Get avalible video and audio stream code
=====
```sh
youtube-dl -F $URL
```

Merge video and audio
=====
* If video stream code is 100 and audio is 200
```sh
youtube-dl -f 100+200 $URL
```

Remove youtube auto subs extra timing
=====
```vim
:%s/<\/c><[0-9:\.]*><c>
:%s/<[0-9:\.]*><c>
:%s/<c\.color\w\w\w\w\w\w>
:%s/<\/c>
```
