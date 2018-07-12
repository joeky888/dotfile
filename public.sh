#! /bin/bash

# Transfer all personal settings to public
# Usefull when I don't own this machine

perl -C -Mutf8 -pie '/template/d' ~/dotfile/.gitconfig
perl -C -Mutf8 -pie '/name/d'     ~/dotfile/.gitconfig
perl -C -Mutf8 -pie '/email/d'    ~/dotfile/.gitconfig

# sed -i $backup '/template/d'   ~/dotfile/.gitconfig
# sed -i $backup '/name/d'       ~/dotfile/.gitconfig
# sed -i $backup '/email/d'      ~/dotfile/.gitconfig
# sed -i $backup "/pageup/Id"    ~/.vimrc
# sed -i $backup "/pagedown/Id"  ~/.vimrc
perl -C -Mutf8 -pie "/pageup/id"    ~/.vimrc
perl -C -Mutf8 -pie "/pagedown/id"  ~/.vimrc
# sed -i '/zsh-hook/d'                        ~/dotfile/.bashrc
# sed -i '/^\s*update_prompt\s*$/d'               ~/dotfile/.bashrc
# sed -i 's/ZSH_THEME.*$/ZSH_THEME="bira"/'   ~/dotfile/.bashrc

if [ -z $(command -v fcitx) ]; then
  echo -n "" > ~/dotfile/.xprofile
fi
