#! /bin/bash

# Transfer all personal settings to public
# Usefull when I don't own this machine

perl -C -Mutf8 -pe '/template/d' ~/dotfile/.gitconfig
perl -C -Mutf8 -pe '/name/d'     ~/dotfile/.gitconfig
perl -C -Mutf8 -pe '/email/d'    ~/dotfile/.gitconfig

# sed -i $backup '/template/d'   ~/dotfile/.gitconfig
# sed -i $backup '/name/d'       ~/dotfile/.gitconfig
# sed -i $backup '/email/d'      ~/dotfile/.gitconfig
# sed -i $backup "/pageup/Id"    ~/.vimrc
# sed -i $backup "/pagedown/Id"  ~/.vimrc
perl -C -Mutf8 -pe "/pageup/Id"    ~/.vimrc
perl -C -Mutf8 -pe "/pagedown/Id"  ~/.vimrc
# sed -i '/zsh-hook/d'                        ~/dotfile/.bashrc
# sed -i '/^\s*update_prompt\s*$/d'               ~/dotfile/.bashrc
# sed -i 's/ZSH_THEME.*$/ZSH_THEME="bira"/'   ~/dotfile/.bashrc

if [ -z $(command -v fcitx) ]; then
  echo -n "" > ~/dotfile/.xprofile
fi
