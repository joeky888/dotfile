# Install Chinese language using gnome-language-selector
# Install a package "fonts-droid" from Internet
$ sudo fc-cache -fv
$ sudo apt-get install fcitx
$ sudo dpkg -i sogou*.deb
$ im-config -n fcitx

# Install dictionary (must use absolute path)
$ sogou-qimpanel /home/joeky/Desktop/Taiwan.scel
