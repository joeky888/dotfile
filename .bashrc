alias ll='ls -lh'
alias ls='ls -F --color=auto --show-control-chars'

whichTTY=$(tty | sed -e "s:/dev/::")
has_fbterm=$(command -v fbterm)

if [[ $TERM != screen ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* ]] ; then
    # Check if fbterm installed
    if [[ $has_fbterm ]] ; then
        SHELL=tmux fbterm
    else
        exec tmux
    fi
fi

