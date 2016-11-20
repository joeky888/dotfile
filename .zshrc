. ~/.bashrc # source ~/.bashrc

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

if [[ "$OSTYPE" == "linux-gnu" ]]; then # Ubuntu
    alias upgradeYoutubedl='sudo pip3 install youtube-dl -U'
    alias upgradeYou-get='sudo pip3 install --upgrade git+https://github.com/soimort/you-get@develop'
    alias gvim='gvim --remote-tab-silent "$@" || gvim'
elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX

elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
    export DISPLAY=:0.0
    alias apt-Cygwin-Search='setup-x86_64.exe --package-manager --wait'
    alias apt-Cygwin-Install='setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --packages'
    alias apt-Cygwin-Uninstall='setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --remove-packages'
    alias apt-Cygwin-Upgrade="setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --upgrade-also --delete-orphans"
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
    alias upgradeYoutubedl='pip3 install youtube-dl -U'
    alias upgradeYou-get='pip3 install --upgrade git+https://github.com/soimort/you-get@develop'
    alias sudo='cygstart --action=runas "$@"'
elif [[ "$OSTYPE" == "msys" ]]; then # Msys

elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
    alias ls='ls -G'
else
    # Unknown.
fi

alias proxyNtust='export http_proxy="140.118.31.62:3128" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy"'
alias proxyYouku='export http_proxy="proxy.uku.im:443" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy"'
alias proxyUnset='unset http_proxy && unset https_proxy && unset ftp_proxy'
alias xterm="xterm -bg black -fg white -fa 'Ubuntu Mono' -fs 14"
alias upgrade_oh_my_zsh="cd ~/.oh-my-zsh && git pull origin master && cd -"
alias upgradeDotfile="cd ~/dotfile && git pull origin master && source ~/.zshrc && cd -"

forever()
{
    if [ "$#" == 0 ]; then
        echo "Usage: forever \"[commands]\""
        echo "Run commands forever!"
    else
        while true; do eval $* ; done
    fi
}
