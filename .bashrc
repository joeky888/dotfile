alias ll='ls -lh'
alias ls='ls -F --color=auto --show-control-chars'

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export VISUAL="vim" # Set vim as default editor
export EDITOR="$VISUAL"
alias proxyNtust='export http_proxy="140.118.31.62:3128" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy"'
alias proxyYouku='export http_proxy="proxy.uku.im:443" && export https_proxy="$http_proxy" && export ftp_proxy="$http_proxy"'
alias proxyUnset='unset http_proxy && unset https_proxy && unset ftp_proxy'
alias upgradeYoutubedl='pip install youtube-dl -U'
alias upgradeYou-get='pip install --upgrade git+https://github.com/soimort/you-get@develop'
alias xterm="xterm -bg black -fg white -fa 'Ubuntu Mono' -fs 14"
alias upgrade_oh_my_zsh="cd ~/.oh-my-zsh && git pull origin master && cd -"
alias upgradeDotfile="cd ~/dotfile && git pull origin master && source ~/.zshrc && cd -"
alias sudo="sudo -E "
killallproc() { eval 'kill -9 $(pgrep $@)' ;}
killallprocSudo() { eval 'sudo kill -9 $(pgrep $@)' ;}

if [[ $(command -v gvim) ]]; then
    gv=$(which gvim)
    gvim()
    {
        if [ "$#" == 0 ]; then
            eval $gv
        else
            eval "$gv -p --remote-tab-silent $@"
        fi;
    }
fi

if [[ "$TERM" == "xterm"* ]]; then
  export TERM=xterm-256color
fi

stty -ixon -ixoff # In order to use Ctrl Q and ctrl S
stty lnext '^-' stop undef start undef -ixon # Unbind Ctrl V, replace with Ctrl _

if [[ -n "$ZSH_VERSION" ]]; then # Zsh
    export ZSH=$HOME/.oh-my-zsh
    ZSH_THEME="bira"
    plugins=(git docker)
    DISABLE_AUTO_UPDATE="true"
    export PATH=$HOME/bin:/usr/local/bin:$PATH
    source $ZSH/oh-my-zsh.sh
    export KEYTIMEOUT=1 # Make ESC faster
    setopt NO_NOMATCH # disable zsh match filename
    _comp_options+=(globdots) # Show hidden files when using completion
    zle -N ZshPasteFromClipboard # Bind function to command
    zle -N ZshCutToClipboard # Bind function to command
    # alt + arrow key to move
    bindkey "OC" forward-word
    bindkey "OD" backward-word
    bindkey "^[[1;3C" forward-word
    bindkey "^[[1;3D" backward-word
    bindkey "[C" forward-word
    bindkey "[D" backward-word
    bindkey "[3~" kill-word
    bindkey "^Z" undo
    bindkey "^Y" redo
    bindkey "^V" ZshPasteFromClipboard # Ctrl V to paste from Clipboard.txt
    bindkey "^X" ZshCutToClipboard # Ctrl X to cut to Clipboard.txt
elif [[ -n "$BASH_VERSION" ]]; then # Bash
    complete -cf sudo # complete sudo command
    complete -cf man # complete man command
    bind 'set completion-ignore-case on' # Ignore case
    bind '"\e[A": history-search-backward' # Up key is searching backward
    bind '"\e[B": history-search-forward'  # Down key is searching forward
    bind -x '"\C-v": BashPasteFromClipboard'  # Ctrl V to paste from Clipboard.txt
fi


if [[ "$OSTYPE" == "linux-gnu" ]]; then # Ubuntu
    export PATH=~/Miniconda3/bin:$PATH
elif [[ "$OSTYPE" == "darwin"* ]]; then # Mac OSX
    true
elif [[ "$OSTYPE" == "cygwin" ]]; then # Cygwin
    export PATH=~/Miniconda3/Script:$PATH
    export DISPLAY=:0.0
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
    alias apt-Cygwin-Search='setup-x86_64.exe --package-manager --wait'
    alias apt-Cygwin-Install='setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --packages'
    alias apt-Cygwin-Uninstall='setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --remove-packages'
    alias apt-Cygwin-Upgrade="setup-x86_64.exe --no-desktop --no-shortcuts --no-startmenu --quiet-mode --wait --upgrade-also --delete-orphans"
    alias sudo='cygstart --action=runas "$@"'
elif [[ "$OSTYPE" == "msys" ]]; then # Msys
    true
elif [[ "$OSTYPE" == "freebsd"* ]]; then # FreeBSD or TrueOS
    alias ls='ls -G'
else # Unknown OS
    true
fi

vman() {
    export MANPAGER="col -bx" # for FreeBSD/MacOS, col -b removes backspaces, col -x replace tabs with spaces
    eval 'man $@ | vim -MR +"set filetype=man" -' # Make it read only and quit easily
    unset MANPAGER;
}

ZshPasteFromClipboard()
{
    LBUFFER="$LBUFFER$(cat /tmp/clipboard.txt)" ; # Zsh only, C-v to paste from clipboard.txt
}

ZshCutToClipboard()
{
    echo "$LBUFFER" > /tmp/clipboard.txt
    LBUFFER="" ; # Zsh only, C-x to cut to clipboard.txt
}

BashPasteFromClipboard()
{
    READLINE_LINE="$READLINE_LINE$(cat /tmp/clipboard.txt)" ; # Bash only, C-v to paste from clipboard.txt
}

forever()
{
    if [ "$#" == 0 ]; then
        echo "Usage: forever \"[commands]\""
        echo "ex: forever \"ls -a\""
        echo "Run commands forever!"
    else
        while true; do eval $* ; done
    fi;
}

whichTTY=$(tty | sed -e "s:/dev/::")
if [[ $(command -v tmux) ]] ; then
    if [[ $TERM != screen ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* || $whichTTY == ttyv0 ]] ; then
        cd ~
        # Check if fbterm installed
        if [[ $(command -v fbterm) ]] ; then
            SHELL=tmux exec fbterm
        elif [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* || $whichTTY == ttyv0 ]] ; then
            exec tmux
        fi
    fi
fi
