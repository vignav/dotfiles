if ! [  -f /etc/debian_version ]  ; then
  echo "This is not Debian. Installation Aborted"
  exit 1
fi

cd "$(dirname "${BASH_SOURCE[0]}")"
BASE=$(pwd)

#sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y

if ! command -v fzf ; then
  echo "fzf not found. Installing fzf now."
  sudo apt install fzf -y
else
  echo "fzf found."
fi

ln -sfv $BASE/.bashrc ~/.bashrc
ln -sTfv $BASE/vim ~/.vim
ln -sfv $BASE/.bash_aliases ~/.bash_aliases

echo "Sourcing .bashrc"
source ~/.bashrc

vim +PlugInstall +qall
WSL=$(uname -a | grep 'WSL')
if [ -n WSL ] ; then
  sudo echo -e "[network]\ngenerateResolvConf = false" > /etc/wsl.conf
  sudo echo "nameserver 1.1.1.1" > /etc/resolv.conf
fi
