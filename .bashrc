alias ll='ls -all'
alias ls='ls -F --color=auto --show-control-chars'

whichTTY=$(tty | sed -e "s:/dev/::")

if [[ $TERM != screen ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* ]] ; then
    exec tmux
fi

