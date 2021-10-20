if [ -f /etc/debian_version ]; then
    alias update='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y '
fi

alias sshpi='ssh pi@raspberrypi.local'
