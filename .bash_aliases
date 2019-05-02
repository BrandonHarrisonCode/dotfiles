#!/usr/bin/bash

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Lock the computer
alias lock='~/Programming/Bash/lock'

# Run the last command with sudo
alias please='echo -e "Fine."; eval "sudo $(fc -ln -1)"'

# Access cli weather
alias weather='curl wttr.in/Austin'

# Calc function to evaluate simple math expressions on the
# command line
calc () {
    python -c "print($@)"
}

# Look inside a running docker container
dockerview() {
    docker exec -it "$1" bash
}

# Look inside a docker image
alias dockerimage='docker run --rm -it --entrypoint=/bin/bash $1'

# Show most used commands
freq() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a; }' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='mplayer -loop 0 ~/tones/alert_tone.mp3 &> /dev/null'

# Dictionary definitions: usage "def <myword>"
alias def='sdcv'

# Remap emacs to use the daemon
alias emacs='emacsclient -nc $1'
