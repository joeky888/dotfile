export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bira"

plugins=(python pip)

export PATH=$HOME/bin:/usr/local/bin:$PATH

source $ZSH/oh-my-zsh.sh

# alt + arrow key to move
bindkey "OC" forward-word
bindkey "OD" backward-word
bindkey "[3~" kill-word

if [[ $OSTYPE == cygwin ]] ; then
    export DISPLAY=:0.0
fi

alias upgradeDotfile="cd ~/dotfile && git pull origin master && cd -"

# For cygwin
alias upgradeCygwin="setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --upgrade-also --delete-orphans"
