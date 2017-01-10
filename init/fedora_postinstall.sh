#!/bin/bash

# RPM Fusion
echo "Install RPM Fusion repos"
echo ""
echo -n "Enter Root "
su -c 'dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

# Nodejs
echo "Install NodeJS repos"
echo ""
echo -n "Enter Root "
su -c 'curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -'

# Get Privs
echo "Get elevated user privileges..."
echo ""
sudo -v

# VirtualBox
echo "Install VirtualBox repos"
echo ""
sudo dnf config-manager --add-repo=http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

# Google Chrome
echo "Install Google Chrome"
echo ""
mkdir -p ~/tmp
cat << EOF > ~/tmp/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

sudo mv ~/tmp/google-chrome.repo /etc/yum.repos.d/google-chrome.repo
sudo chown root:root /etc/yum.repos.d/google-chrome.repo


# Spotify
echo "Install Spotify repo"
echo ""
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo

# Yubikey
echo "Add rules for Yubikey"
echo ""
cat << EOF > ~/tmp/70-u2f.rules
# this udev file should be used with udev 188 and newer
ACTION!="add|change", GOTO="u2f_end"

# Yubico YubiKey
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", TAG+="uaccess"

# Happlink (formerly Plug-Up) Security KEY
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="f1d0", TAG+="uaccess"

#  Neowave Keydo and Keydo AES
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1e0d", ATTRS{idProduct}=="f1d0|f1ae", TAG+="uaccess"

# HyperSecu HyperFIDO
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="096e|2ccf", ATTRS{idProduct}=="0880", TAG+="uaccess"

# Feitian ePass FIDO
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="096e", ATTRS{idProduct}=="0850", TAG+="uaccess"

# JaCarta U2F
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="24dc", ATTRS{idProduct}=="0101", TAG+="uaccess"

# HS ePass FIDO
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="096e", ATTRS{idProduct}=="0850", TAG+="uaccess"

LABEL="u2f_end"
EOF

sudo mv ~/tmp/70-u2f.rules /etc/udev/rules.d/70-u2f.rules
sudo chown root:root /etc/udev/rules.d/70-u2f.rules

# Update dnf
echo "Update DNF"
echo ""
sudo dnf update

# Install some things
echo "Install Software"
echo ""
sudo dnf install -y curl google-chrome-stable gparted htop ngrep nodejs screenfetch spotify-client subversion tree tmux tmuxinator vim virtualbox xclip https://prerelease.keybase.io/keybase_amd64.rpm https://github.com/atom/atom/releases/download/v1.11.2/atom.x86_64.rpm

# Sublime Text 3
echo "Install Sublime Text 3"
echo ""
curl -L git.io/sublimetext | sh
cd $HOME/.config/sublime-text-3/Installed\ Packages && wget http://packagecontrol.io/Package%20Control.sublime-package
cd ~

# bash
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --interactive

# Sexy Bash
echo "Install Sexy Bash Prompt"
echo ""
(cd /tmp && git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt && cd sexy-bash-prompt && make install) && source ~/.bashrc

# Vim
echo "Install vim plugins"
echo ""
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
