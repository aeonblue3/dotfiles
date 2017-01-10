#!/bin/bash

cp dotfiles/curlrc ~/.curlrc
cp dotfiles/exports ~/.exports
cp dotfiles/functions ~/.functions
cp dotfiles/gitconfig ~/.gitconfig
cp dotfiles/inputrc ~/.inputrc
cp dotfiles/jshintrc ~/.jshintrc
cp dotfiles/nvimrc ~/.nvimrc
cp dotfiles/tmux.conf ~/tmux.conf
cp dotfiles/vimrc ~/.vimrc
cp dotfiles/wgetrc ~/.wgetrc
cp -i dotfiles/bashrc ~/.bashrc

echo "Dotfiles copied!"
echo ""

if [[ $OSTYPE == darwin* ]]; then
	OS_STRING = "MacOS"

	echo "Setting up MacOS..."
	echo ""
	cp dotfiles/mac_aliases ~/.aliases
	bash init/mac_setup.sh
	cp sublime-text/sublimeconfig ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
else
	OS_STRING = "Linux"

	echo "Setting up Linux..."
	echo ""
	cp dotfiles/linux_aliases ~/.aliases
	if [ -n "$(type -t dnf)" ]; then
		bash init/fedora_postinstall.sh
	elif [ -n "$(type -t yum)" ];
		bash init/fedora_postinstall.sh
	fi
fi