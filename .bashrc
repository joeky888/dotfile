alias ll='ls -lh'
alias ls='ls -F --color=auto --show-control-chars'

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"

if [ "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi

whichTTY=$(tty | sed -e "s:/dev/::")
has_fbterm=$(command -v fbterm)

if [[ $TERM != screen ]] && [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* || $whichTTY == ttyv0 ]] ; then
    # Check if fbterm installed
    if [[ $has_fbterm ]] ; then
        SHELL=tmux fbterm
    elif [[ $whichTTY == pts* || $whichTTY == tty1 || $whichTTY == pty* || $whichTTY == ttyv0 ]] ; then
        cd ~
        exec tmux
    fi
fi

