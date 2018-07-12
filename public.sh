#! /bin/bash

# Transfer all personal settings to public
# Usefull when I don't own this machine

# perl -C -Mutf8 -pi -e '/template/d' ~/dotfile/.gitconfig
# perl -C -Mutf8 -pi -e '/name/d'     ~/dotfile/.gitconfig
# perl -C -Mutf8 -pi -e '/email/d'    ~/dotfile/.gitconfig

perl -C -Mutf8 -ni -e 'print if !/template/' ~/dotfile/.gitconfig
perl -C -Mutf8 -ni -e 'print if !/name/'     ~/dotfile/.gitconfig
perl -C -Mutf8 -ni -e 'print if !/email/'    ~/dotfile/.gitconfig

# sed -i $backup '/template/d'   ~/dotfile/.gitconfig
# sed -i $backup '/name/d'       ~/dotfile/.gitconfig
# sed -i $backup '/email/d'      ~/dotfile/.gitconfig
# sed -i $backup "/pageup/Id"    ~/.vimrc
# sed -i $backup "/pagedown/Id"  ~/.vimrc
perl -C -Mutf8 -ni -e 'print if !/pageup/i'    ~/dotfile/vimrc/.vimrc
perl -C -Mutf8 -ni -e 'print if !/pagedown/i'  ~/dotfile/vimrc/.vimrc
# perl -C -Mutf8 -pi -e "/pageup/id"    ~/.vimrc
# perl -C -Mutf8 -pi -e "/pagedown/id"  ~/.vimrc
# sed -i '/zsh-hook/d'                        ~/dotfile/.bashrc
# sed -i '/^\s*update_prompt\s*$/d'               ~/dotfile/.bashrc
# sed -i 's/ZSH_THEME.*$/ZSH_THEME="bira"/'   ~/dotfile/.bashrc

if [ -z $(command -v fcitx) ]; then
  echo -n "" > ~/dotfile/.xprofile
fi
