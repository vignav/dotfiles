if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
source /usr/share/doc/fzf/examples/key-bindings.bash

if [ -f  /usr/share/doc/fzf/examples/completion.bash ]; then
    source /usr/share/doc/fzf/examples/completion.bash
fi

if [ -f ~/.bash_wsl ]; then
    source ~/.bash_wsl
fi

if [ -f /etc/debian_version ]; then
    alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y '
fi

alias sshpi='ssh pi@raspberrypi.local'
export EDITOR='vim'
