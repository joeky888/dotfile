export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bira"

plugins=(git docker)
DISABLE_AUTO_UPDATE="true"
export PATH=$HOME/bin:/usr/local/bin:$PATH
source $ZSH/oh-my-zsh.sh

export KEYTIMEOUT=1 # Make ESC faster

setopt NO_NOMATCH # disable zsh match filename

# alt + arrow key to move
bindkey "OC" forward-word
bindkey "OD" backward-word
bindkey "[3~" kill-word

stty -ixon -ixoff # In order to use Ctrl Q and ctrl S

if [[ $OSTYPE == cygwin ]] ; then
    export DISPLAY=:0.0
    alias apt-Cygwin-Search='setup-x86_64.exe --package-manager --wait'
    alias apt-Cygwin-Install='setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --packages'
    alias apt-Cygwin-Uninstall='setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --remove-packages'
    alias apt-Cygwin-Upgrade="setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --upgrade-also --delete-orphans"
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
    alias upgradeYoutubedl='pip3 install youtube-dl -U'
    alias upgradeYou-get='pip3 install --upgrade git+https://github.com/soimort/you-get@develop'
    alias sudo='cygstart --action=runas "$@"'
else
    alias upgradeYoutubedl='sudo pip3 install youtube-dl -U'
    alias upgradeYou-get='sudo pip3 install --upgrade git+https://github.com/soimort/you-get@develop'
    # gvim () { if [ "$#" -gt 0 ] then command gvim --remote-tab-silent "$@" else command gvim "$@" fi }
    # gvim () { command gvim --servername VIM --remote-tab-silent "$@" || command gvim "$@"; }
    gvim() {
        if [[ `gvim --serverlist` == 'VIM' ]]; then
            command gvim --remote-tab-silent "$@"
        else
            command gvim "$@"
        fi
    }
    # gvim () { 
        # if [ "$#" -gt 0 && $(pgrep "gvim") ]
        # then
          # gvim --remote-tab-silent "$@"
        # else
          # gvim "$@"
        # fi
    # }
fi

alias proxyNtust='export http_proxy="140.118.31.62:3128" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy"'
alias proxyYouku='export http_proxy="proxy.uku.im:443" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy"'
alias proxyUnset='unset http_proxy && unset https_proxy && unset ftp_proxy'
alias xterm="xterm -bg black -fg white -fa 'Ubuntu Mono' -fs 14"
alias upgrade_oh_my_zsh="cd ~/.oh-my-zsh && git pull origin master && cd -"
alias upgradeDotfile="cd ~/dotfile && git pull origin master && cd -"

