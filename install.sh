#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"
BASE=$(pwd)

git config --global core.editor vim

# For MacOS installation
if [ "$(uname)" == "Darwin" ]; then
	if [ -z $(which brew) ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
	fi

	if [ -z $(which wget) ]; then
		brew install wget
	fi

	ln -shF $BASE/vim ~/.vim

	# ZSH installation and config
	if [ -z $ZSH] ]; then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		ln -shF $BASE/common.zsh-theme $ZSH/custom/themes
		ln -shF $BASE/.zshrc ~/ 
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	fi

# For Linux installation
else 
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
fi

vim +PlugInstall +qall
