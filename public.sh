#! /bin/bash

# Convert all personal settings to public
# Usefull when I don't own this machine

perl -C -Mutf8 -ni -e 'print if !/template/' ~/dotfile/.gitconfig
perl -C -Mutf8 -ni -e 'print if !/name/'     ~/dotfile/.gitconfig
perl -C -Mutf8 -ni -e 'print if !/email/'    ~/dotfile/.gitconfig

if [ -z $(command -v fcitx) ]; then
  echo -n "" > ~/dotfile/.xprofile
fi
