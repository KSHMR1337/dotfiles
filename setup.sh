#!/bin/sh

## setup script for dwm with my dotfiles

sudo pacman --noconfirm -Syu \
archlinux-keyring archlinux-mirrorlist fzf\
git htop libxft maim man-db man-pages mpv neofetch neovim npm openssh \
picom plymouth pulseaudio xclip xorg-server xorg-xinit xwallpaper zsh || exit

# My git repos
cd || exit
mkdir -p forsetup
cd forsetup || exit

git clone https://github.com/KSHMR1337/dwm
cd dwm || exit
git checkout purple
sudo make clean install
cd ..
git clone https://github.com/KSHMR1337/dmenu
cd dmenu || exit
sudo make clean install
cd ..
git clone https://github.com/KSHMR1337/st
cd st || exit
git checkout purple
sudo make clean install
cd ..
git clone https://github.com/KSHMR1337/dwmblocks
cd dwmblocks || exit
sudo make clean install
cd ..
git clone https://github.com/KSHMR1337/slock
cd slock || exit
sudo make clean install
cd ..
git clone https://github.com/KSHMR1337/tabbed
cd tabbed || exit
sudo make clean install
cd ..

git clone https://github.com/ujjwal96/xwinwrap
cd xwinwrap || exit
sudo make
sudo make install
make clean
cd ../../

# Configure plymouth
sudo cp ./.config/plymouth/plymouthd.conf /etc/plymouth/
sudo cp -r ./.config/plymouth/themes /usr/share/plymouth/

# Configure sddm
sudo cp ./.config/sddm/sddm.conf /etc/
sudo cp -r ./.config/sddm/scripts /usr/share/sddm/
sudo cp -r ./.config/sddm/themes /usr/share/sddm/

# Configure dwm session for sddm
sudo cp ./.config/x11/dwm.desktop /usr/share/xsessions
sudo cp ./.config/x11/start_dwm.sh /usr/local/bin

# Configure zsh
sudo cp ./.config/zsh/.* ~

# Configure nvim
cd ./.config/nvim || exit
git checkout purple


# Reboot
sudo reboot
