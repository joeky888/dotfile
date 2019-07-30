Install openbox
=====
* Install openbox
* Add "exec openbox-session" to ~/.xinitrc
* $ DISPLAY=:0.0
* $ startx

Or install a desktop environment
=====
* $ apt-cyg install xorg-server xinit lxqt-common
* $ XWin :0 -clipboard -multiwindow
* $ DISPLAY=:0.0 xterm
* $ startlxqt
* OR
* $ DISPLAY=:0.0 startlxqt
* OR
* $ echo "exec startlxqt" > ~/.xinitrc
* $ startx

# Start GUI program without desktop environment
$ XWin :0 -clipboard -multiwindow
$ DISPLAY=:0.0 krita
