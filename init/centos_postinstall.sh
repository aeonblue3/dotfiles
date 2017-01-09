l #!/bin/bash

# RPM Fusion
echo "Install Epel and other things";
echo "";
echo -n "Enter Root ";
su -c 'yum install -y epel-release kernel-devel && yum groupinstall -y "Development Tools"';

# Nodejs
echo "Install NodeJS repos"
echo ""
echo -n "Enter Root ";
su -c 'curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -'

# Get Privs
echo "Getting elevated user privileges..."
echo ""
sudo -v

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
echo "Update Yum"
echo ""
sudo yum update -y

# Install some things
echo "Install Software"
echo ""
sudo yum install -y curl git htop ngrep nodejs screenfetch subversion tree tmux vim

# Copy local dotfiles
current_dir=$(pwd)
cd ..
sh bootstrap.sh
cd current_dir

# Vim
echo "Install vim plugins"
echo ""
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

