#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"
BASE=$(pwd)

git config --global core.editor vim

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

ln -sTfv $BASE/vim ~/.vim
ln -sfv $BASE/my_bashrc.sh ~/.oh-my-bash/custom/my_bashrc.sh

#if it is wsl
WSL=$(uname -a | grep 'WSL')
if [ -n "$WSL" ]; then
  sudo bash -c "echo -e '[network]\ngenerateResolvConf = false' > /etc/wsl.conf ; echo 'nameserver 1.1.1.1' > /etc/resolv.conf"
fi

#if it is debian
if [  -f /etc/debian_version ]  ; then
  sudo apt install fzf -y
  sudo apt install vim -y
  sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y
  sudo apt install locales-all
fi

vim +PlugInstall +qall
