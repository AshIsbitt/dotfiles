#!/bin/bash

SSH_DIR="$HOME/.ssh"

# apt update && upgrade
echo -e "-----UPDATE && UPGRADE-----"
sudo apt update && sudo apt upgrade -y

# Remove old installs/files
echo -e "-----REMOVE UNNEEDED FILES-----"
rm -rf $HOME/.go
# remove fonts

# gnome settings
echo -e "-----GNOME SETTINGS-----"
gsettings set org.gnome.desktop.interface show-battery-percentage true
xdotool key super+y # Enable pop tiling

# File structure setup
echo -e "-----SET UP FILE STRUCTURE-----"
rm -rf $(HOME)/Desktop \
    $(HOME)/Documents \
    $(HOME)/Music \
    $(HOME)/Pictures \
    $(HOME)/Public \
    $(HOME)/Templates \
    $(HOME)/Videos \

mkdir $(HOME)/Workspace

# apt install everything
echo -e "-----APT INSTALL-----"
sudo apt-get install \
blueman \
build-essential \
cheese \
cowsay \
curl \
flameshot \
gcc \
git \
libreoffice \
neofetch \
pipes \
powertop \
rpi-imager \
tlp \
tmux \
tree \
unzip \
vlc \
xclip \
zsh \
-y

# Other installs
flatpak install flathub com.discordapp.Discord
curl -LO https://github.com/ClementTsang/bottom/releases/download/0.6.8/bottom_0.6.8_amd64.deb
sudo dpkg -i bottom_0.6.8_amd64.deb

# manual install - neovim, fonts, go

# set up symlinks
echo -e "-----SET UP CONFIG SYMLINKS-----"
git clone git@github.com:Ttibsi/dotfiles.git $(HOME)/Workspace/dotfiles

# Tidy up 
rm -rf $(HOME)/Downloads/*

# Generate SSH key
echo -e "-----GENERATE SSH KEY-----"
if ! [[ -f "$SSH_DIR/authorized_keys" ]]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "$USER@$HOSTNAME"
    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"
fi

cat "$SSH_DIR/id_rsa.pub" | xclip -selection c
echo Add to account here: https://github.com/settings/keys

echo -e "Configuration complete"
