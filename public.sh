#! /bin/bash

# Transfer all personal settings to public
# Usefull when I don't own this machine

sed -i '/template/d'   ~/dotfile/.gitconfig
sed -i '/name/d'       ~/dotfile/.gitconfig
sed -i '/email/d'      ~/dotfile/.gitconfig

sed -i '/zsh-hook/d'                        ~/dotfile/.bashrc
sed -i '/^\s*update_prompt/d'               ~/dotfile/.bashrc
sed -i 's/ZSH_THEME.*$/ZSH_THEME="bira"/'   ~/dotfile/.bashrc

echo -n "" > ~/dotfile/.xprofile
