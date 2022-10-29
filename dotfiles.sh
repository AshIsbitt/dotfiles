#!/bin/bash
set -euo pipefail

SSH_DIR="$HOME/.ssh"

# apt update && upgrade
echo -e "\n-----UPDATE && UPGRADE-----"
sudo apt-get update 
sudo apt-get -y upgrade 

# Remove old installs/files
echo -e "\n-----REMOVE UNNEEDED FILES-----"
sudo rm -rf $HOME/Workspace \
    $HOME/.opt \
    /usr/local/go \
    /usr/local/bin/nvim \
    /usr/bin/btm \
    /usr/bin/virtualenv \
    $HOME/.local/share/fonts/DroidSansMono_NerdFont /

# gnome settings
echo -e "\n-----GNOME SETTINGS-----"
gsettings set org.gnome.desktop.interface show-battery-percentage true
xdotool key super+y # Enable pop tiling

# File structure setup
echo -e "\n-----SET UP FILE STRUCTURE-----"
rm -rf $HOME/Desktop \
    $HOME/Documents \
    $HOME/Music \
    $HOME/Pictures \
    $HOME/Public \
    $HOME/Templates \
    $HOME/Videos \

mkdir $HOME/Workspace \
    $HOME/.opt \
    $HOME/.opt/lua-language-server \
    $HOME/.local/share/fonts/ \

# apt install everything
echo -e "\n-----INSTALL PACKAGES-----"
sudo apt-get install \
autoconf \
automake \
blueman \
build-essential \
cheese \
cmake \
cowsay \
curl \
doxygen \
flameshot \
gcc \
gettext \
git \
g++ \
libreoffice \
libtool \
libtool-bin \
neofetch \
ninja-build \
pkg-config \
powertop \
python3 \
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
curl -Lo $HOME/Downloads/btm.deb https://github.com/ClementTsang/bottom/releases/download/0.6.8/bottom_0.6.8_amd64.deb
sudo dpkg -i $HOME/Downloads/btm.deb
flatpak install -y --noninteractive flathub com.discordapp.Discord

# Python environment - anthony explains 79
echo -e "\n-----CONFIGURE PYTHON ENVIRONMENT-----"
curl -Lo $HOME/Downloads/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz
python3 $HOME/Downloads/virtualenv.pyz $HOME/.opt/venv
$HOME/.opt/venv/bin/pip install virtualenv
sudo ln -s $HOME/.opt/venv/bin/virtualenv /usr/bin/virtualenv
$HOME/.opt/venv/bin/python3 -m pip install --upgrade pip


echo -e "\n-----MANUAL INSTALLATIONS-----"
# manual install - go, fonts, neovim, OMZ
curl -Lo $HOME/Downloads/go1.19.2.linux-amd64.tar.gz https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf $HOME/Downloads/go1.19.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.bashrc
mv $HOME/go $HOME/.go

curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf > DroidSansMono_NerdFont
mv $PWD/DroidSansMono_NerdFont $HOME/.local/share/fonts/DroidSansMono_NerdFont

git clone https://github.com/neovim/neovim.git $HOME/Downloads/neovim
cd $HOME/Downloads/neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ..
rm -rf neovim

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm $HOME/.zshrc

# set up symlinks
echo -e "\n-----SET UP CONFIG SYMLINKS-----"
sudo rm /usr/lib/firefox/distribution/policies.json 
rm -rf $HOME/.oh-my-zsh/custom
git clone https://github.com/Ttibsi/dotfiles.git $HOME/Workspace/dotfiles
git -C $HOME/Workspace/dotfiles checkout shell-script

sudo ln -s $HOME/Workspace/dotfiles/configs/firefox/policies.json /usr/lib/firefox/distribution/policies.json
ln -s $HOME/Workspace/dotfiles/configs/git-config/gitconfig $HOME/.gitconfig
sudo ln -s $HOME/Workspace/dotfiles/configs/internal-configs/90-touchpad.conf /etc/X11/xorg.conf.d/90-touchpad.conf
ln -sd $HOME/Workspace/dotfiles/configs/nvim $HOME/.config
ln -sd $HOME/Workspace/dotfiles/configs/tmux $HOME/.config
ln -s $HOME/Workspace/dotfiles/configs/zsh-shell/zshrc $HOME/.zshrc
ln -sd $HOME/Workspace/dotfiles/configs/zsh-shell/.oh-my-zsh/custom $HOME/.oh-my-zsh
ln -s $HOME/Workspace/dotfiles/configs/zsh-shell/p10k.zsh $HOME/.p10k.zsh

# Nvim config install
echo -e "\n-----SET UP NEOVIM REQUIREMENTS-----"
$HOME/.opt/venv/bin/pip install python-lsp-server

curl -Lo  $HOME/Downloads/lls.tar.gz https://github.com/sumneko/lua-language-server/releases/download/3.5.6/lua-language-server-3.5.6-linux-x64.tar.gz
sudo tar -C $HOME/.opt/lua-language-server -xzf $HOME/Downloads/lls.tar.gz

/usr/local/go/bin/go install golang.org/x/tools/gopls@latest

sleep 1
git clone --depth=1 https://github.com/savq/paq-nvim.git "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
nvim --headless -c 'PaqInstall' +q
@echo "PaqInstall will show an error here, but still succeeds"

# Tidy up
echo -e "\n-----CLEAN UP-----"
rm -rf $HOME/Downloads/*
sudo apt autoclean -y
sudo apt autoremove -y

# Generate SSH key
echo -e "\n-----GENERATE SSH KEY-----"
if ! [[ -f "$SSH_DIR/authorized_keys" ]]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "$USER@$HOSTNAME"
    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"
fi

cat "$SSH_DIR/id_rsa.pub" | xclip -selection c
echo "Add to account here: https://github.com/settings/keys"

echo -e "Configuration complete"
