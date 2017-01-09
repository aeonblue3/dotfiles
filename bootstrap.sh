#!/bin/bash

cp aliases ~/.aliases
cp curlrc ~/.curlrc
cp exports ~/.exports
cp functions ~/.functions
cp gitconfig ~/.gitconfig
cp inputrc ~/.inputrc
cp jshintrc ~/.jshintrc
cp nvimrc ~/.nvimrc
#cp sublimeconfig ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
cp tmux ~/tmux.conf
cp vimrc ~/.vimrc
cp wgetrc ~/.wgetrc
cp -i bashrc ~/.bashrc

if [[ $OSTYPE == darwin* ]]; then
	OS_STRING = "MacOS"

	bash init/mac_setup.sh
else
	OS_STRING = "Linux"

	if [ -n "$(type -t dnf)" ]; then
		bash init/fedora_postinstall.sh
	elif [ -n "$(type -t yum)" ];
		bash init/fedora_postinstall.sh
	fi
fi

cp dotfiles/aliases ~/.aliases
cp dotfiles/curlrc ~/.curlrc
cp dotfiles/exports ~/.exports
cp dotfiles/functions ~/.functions
cp dotfiles/gitconfig ~/.gitconfig
cp dotfiles/inputrc ~/.inputrc
cp dotfiles/jshintrc ~/.jshintrc
cp dotfiles/nvimrc ~/.nvimrc
#cp sublimeconfig ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
cp dotfiles/tmux ~/tmux.conf
cp dotfiles/vimrc ~/.vimrc
cp dotfiles/wgetrc ~/.wgetrc
cp -i dotfiles/bashrc ~/.bashrc