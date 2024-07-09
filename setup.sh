#!/bin/sh

## setup script for dwm with my dotfiles

sudo pacman --needed --noconfirm -Syu \
archlinux-keyring base-devel fzf \
git htop libxft maim man-db man-pages mpv neofetch neovim npm openssh \
picom plymouth pulseaudio sddm xclip xorg-server xorg-xinit xwallpaper zsh || exit

# Configure zsh
echo "Configuring zsh"
sudo cp ./.config/zsh/.* ~

# Configure nvim
echo "Configuring neovim"
if [ ! -d "~/.config"]; then
	mkdir ~/.config
fi
cd ./.config/nvim || exit
git checkout purple
cp -r ../nvim ~/.config




# My git repos
echo "Cloning github repositories"
cd || exit
mkdir -p forsetup
cd forsetup || exit

#Installing yay
echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si
cd ..

#Installing GRUB theme
echo "Installing GRUB theme"
git clone https://aur.archlinux.org/grub-theme-cyberre.git
cd grub-theme-cyberre || exit
makepkg -si
cd ..

#Installing dwm
echo "Installing dwm"
git clone https://github.com/KSHMR1337/dwm
cd dwm || exit
git checkout purple
sudo make clean install
cd ..

#Installing dmenu
echo "Installing dmenu"
git clone https://github.com/KSHMR1337/dmenu
cd dmenu || exit
sudo make clean install
cd ..

#Installing st
echo "Installing st"
git clone https://github.com/KSHMR1337/st
cd st || exit
git checkout purple
sudo make clean install
cd ..

#Installing dwmblocks
echo "Installing dwmblocks"
git clone https://github.com/KSHMR1337/dwmblocks
cd dwmblocks || exit
sudo make clean install
cd ..

#Installing slock
echo "Installing slock"
git clone https://github.com/KSHMR1337/slock
cd slock || exit
sudo make clean install
cd ..

#Installing tabbed
echo "Installing tabbed"
git clone https://github.com/KSHMR1337/tabbed
cd tabbed || exit
sudo make clean install
cd ..

#Installing xwinwrap
echo "Installing xwinwrap"
git clone https://github.com/ujjwal96/xwinwrap
cd xwinwrap || exit
sudo make
sudo make install
make clean
cd ../../

# Configure plymouth
echo "Configuring plymouth"
if [ ! -d "/etc/plymouth"]; then
	sudo mkdir /etc/plymouth
fi
sudo cp ./.config/plymouth/plymouthd.conf /etc/plymouth/
if [ ! -d "/usr/share/plymouth"]; then
	sudo mkdir /usr/share/plymouth
fi
sudo cp -r ./.config/plymouth/themes /usr/share/plymouth/

# Configure sddm
echo "Configuring sddm"
if [ ! -d "/usr/share/sddm"]; then
	sudo mkdir /usr/share/sddm
fi
sudo cp ./.config/sddm/sddm.conf /etc/
sudo cp -r ./.config/sddm/scripts /usr/share/sddm/
sudo cp -r ./.config/sddm/themes /usr/share/sddm/
sudo systemctl enable sddm.service

# Configure dwm session for sddm
echo "Configuring dwm startup"
if [ ! -d "/usr/share/xsessions"]; then
	exit 1
fi
sudo cp ./.config/x11/dwm.desktop /usr/share/xsessions
sudo cp ./.config/x11/start_dwm.sh /usr/local/bin
echo "Configured dwm"



# Reboot
#sudo reboot
