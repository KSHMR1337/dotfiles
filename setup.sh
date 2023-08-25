#!/bin/sh

## setup script for dwm with my dotfiles

sudo pacman --noconfirm -Syu \
archlinux-keyring archlinux-mirrorlist \
git htop libxft maim man-db man-pages mpv neofetch neovim npm openssh \
pulseaudio xclip xorg-server xorg-xinit xwallpaper zsh picom || exit

# My git repos
cd || exit
mkdir -p forsetup
cd forsetup || exit

git clone https://github.com/KSHMR1337/dwm
cd dwm || exit
sudo make clean install
cd ..
git clone https://github.com/KSHMR1337/dmenu
cd dmenu || exit
sudo make clean install
cd ..
git clone https://github.com/KSHMR1337/st
cd st || exit
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
./sync.sh

git clone https://github.com/ujjwal96/xwinwrap
cd xwinwrap || exit
sudo make
sudo make install
make clean

# Reboot
sudo reboot
