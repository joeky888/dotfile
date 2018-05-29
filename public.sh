#! /bin/bash

# Transfer all personal settings to public
# Usefull when I don't own this machine

sed -i '/template/d'   ~/.gitconfig
sed -i '/name/d'       ~/.gitconfig
sed -i '/email/d'      ~/.gitconfig

sed -i '/update_prompt/d'                   ~/.zshrc
sed -i 's/ZSH_THEME.*$/ZSH_THEME="bira"/'    ~/.zshrc

echo -n "" > ~/.xprofile
