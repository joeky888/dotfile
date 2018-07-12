#! /bin/bash

# Transfer all personal settings to public
# Usefull when I don't own this machine

backup=""

if [[ "$OSTYPE" == "darwin"* ]]; then
  backup="''"
fi
sed -i $backup '/template/d'   ~/dotfile/.gitconfig
sed -i $backup '/name/d'       ~/dotfile/.gitconfig
sed -i $backup '/email/d'      ~/dotfile/.gitconfig
sed -i $backup "/pageup/Id"    ~/.vimrc
sed -i $backup "/pagedown/Id"  ~/.vimrc
# sed -i '/zsh-hook/d'                        ~/dotfile/.bashrc
# sed -i '/^\s*update_prompt\s*$/d'               ~/dotfile/.bashrc
# sed -i 's/ZSH_THEME.*$/ZSH_THEME="bira"/'   ~/dotfile/.bashrc

if [ -z $(command -v fcitx) ]; then
  echo -n "" > ~/dotfile/.xprofile
fi
