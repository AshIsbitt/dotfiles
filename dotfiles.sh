#!/bin/bash

SSH_DIR="$HOME/.ssh"

# apt update && upgrade
sudo apt update && sudo apt upgrade -y

# Remove old installs/files

# gnome settings
echo -e "\nShow Percentage in top bar"
gsettings set org.gnome.desktop.interface show-battery-percentage true


# apt install everything

# manual install - neovim

# File structure setup

# set up symlinks

# Generate SSH key
if ! [[ -f "$SSH_DIR/authorized_keys" ]]; then
    echo -e "\n----- Generating SSH key -----"
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "$USER@$HOSTNAME"
    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"
fi

echo -e "\n----- Copying SHH pub key to clipboard -----"
cat "$SSH_DIR/id_rsa.pub" | xclip -selection c
echo Add to account here: https://github.com/settings/keys
