#!/bin/bash

export RUN_PATH=$(pwd)

# Install git and build tools, then install yay from source
sudo pacman -Syu --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Install some packages
yay -Syu extra/neovim extra/nodejs extra/python-virtualenv extra/python-pynvim catppuccin-cursors-mocha bibata-cursor-theme aur/ulauncher discord gnome-boxes

cd ~/Downloads
wget https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage

# Make the directories
mkdir ~/.local/share/themes
mkdir ~/git
mkdir ~/.local/share/fonts
cd ~/.fonts

# Get Fonts and Icons
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/3270.zip
wget https://github.com/google/material-design-icons/archive/refs/tags/4.0.0.zip
wget https://github.com/Keyamoon/IcoMoon-Free/archive/master.zip
wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.tar.gz
cp $RUN_PATH/scriptina.zip ~/.fonts/

# Expand the Archives
unzip 3270.zip
unzip 4.0.0.zip
unzip master.zip
unzip scriptina.zip
tar -xvf Hack-v3.003-ttf.tar.gz ~/.fonts/

# Remove the zips
rm *{.zip,.gz}

# Setup git
cd ~/git
git config --global user.email "zer0zzy@pm.me"
git config --global user.name "Zer0zzy"

# Install Catppuccin
git clone --recurse-submodules git@github.com:catppuccin/gtk.git
cd gtk
virtualenv -p python3 venv
source venv/bin/activate
python3 -m pip install --upgrade pip
pip install -r requirements.txt
python install.py mocha --tweaks float -a sapphire -d ~/.local/share/themes
deactivate
cd ~/git
git clone https://github.com/catppuccin/Kvantum.git
git clone https://github.com/catppuccin/xfce4-terminal.git
cp xfce4-terminal/src/catppuccin-mocha.theme ~/.local/share/xfce4/terminal/colorschemes/
cp xfce4-terminal/src/* ~/.local/share/xfce4/terminal/colorschemes/
cp $RUN_PATH/spooky_spill.jpg ~/.local/share/backgrounds/

# Set Panel config
#while read -r line; do
#    xfconf-query --channel 'xfce4-panel' --property $(echo $line | awk '{print $1}') --set $(echo $line | awk '{print $2}');
#done < $RUN_PATH/xfconf-panel.txt

# Configure neovim
#curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#cp $RUN_PATH/init.vim ~/.config/nvim/
