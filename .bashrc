alias ll='ls -lh'
alias ls='ls -F --color=auto --show-control-chars'
alias fbterm='fbterm --cursor-shape=1 --cursor-interval=500'

whichTTY=$(tty | sed -e "s:/dev/::")

if [[ $TERM != screen ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* ]] ; then
    exec tmux
fi

