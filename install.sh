cd "$(dirname "${BASH_SOURCE[0]}")"
BASE=$(pwd)

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

ln -sfv $BASE/.bashrc ~/.bashrc
ln -sTfv $BASE/vim ~/.vim
ln -sfv $BASE/.bash_aliases ~/.bash_aliases
ln -sfv $BASE/.bashrc_ohmybash ~/.bashrc_ohmybash

vim +PlugInstall +qall

#if it is wsl
WSL=$(uname -a | grep 'WSL')
if [ -n "$WSL" ]; then
  sudo bash -c "echo -e '[network]\ngenerateResolvConf = false' > /etc/wsl.conf ; echo 'nameserver 1.1.1.1' > /etc/resolv.conf"
  ln -sfv $BASE/.bash_wsl ~/.bash_wsl
  echo "source ~/.bash_wsl" >> .bashrc
fi

#if it is debian
if [  -f /etc/debian_version ]  ; then
  if ! command -v fzf ; then
    sudo apt install fzf -y
  fi
  sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y
  sudo apt install locales-all
fi

echo "Sourcing .bashrc"
source ~/.bashrc
