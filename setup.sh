#!/bin/sh

## setup script for dwm with my dotfiles

sudo pacman --needed --noconfirm -Syu \
archlinux-keyring base-devel fzf \
git htop imlib2 libxft maim man-db man-pages mpd mpv neofetch neovim npm openssh \
picom plasma-framework5 plymouth pulseaudio qt5-base qt5-quickcontrols qt5-quickcontrols2 qt5-graphicaleffects qt5-svg sddm xorg-apps xclip xorg-server xorg-xinit xwallpaper zsh zsh-autosuggestions zsh-syntax-highlighting || exit

# Configure zsh
echo "Configuring zsh"
sudo cp ./.config/zsh/.* ~

# Copy configurations
echo "Copying configurations"
if [ ! -d "~/.config" ]; then
	mkdir ~/.config
fi
cd ./.config/nvim || exit
git checkout purple
cd ../..
cp -r ./.config ~

# Copy scripts
echo "Copying scripts"
cp -r ./.local ~

# My git repos
echo "Cloning github repositories"
cd || exit
mkdir -p forsetup
cd forsetup || exit

#Installing yay
echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si --noconfirm
cd ..

#Installing GRUB theme
echo "Installing GRUB theme"
git clone https://aur.archlinux.org/grub-theme-cyberre.git
cd grub-theme-cyberre || exit
makepkg -si --noconfirm
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
if [ ! -d "/etc/plymouth" ]; then
	sudo mkdir /etc/plymouth
fi
sudo cp ./.config/plymouth/plymouthd.conf /etc/plymouth/
if [ ! -d "/usr/share/plymouth" ]; then
	sudo mkdir /usr/share/plymouth
fi
sudo cp -r ./.config/plymouth/themes /usr/share/plymouth/

# Configure sddm
echo "Configuring sddm"
if [ ! -d "/usr/share/sddm" ]; then
	sudo mkdir /usr/share/sddm
fi
sudo cp ./.config/sddm/sddm.conf /etc/
sudo cp -r ./.config/sddm/themes /usr/share/sddm/
sudo systemctl enable sddm.service

# Configure dwm session for sddm
echo "Configuring dwm startup"
if [ ! -d "/usr/share/xsessions" ]; then
	sudo mkdir /usr/share/xsessions
fi
sudo cp ./.config/x11/dwm.desktop /usr/share/xsessions
sudo cp ./.config/x11/start_dwm.sh /usr/local/bin
echo "Configured dwm"

#Configuring picom
echo "Configuring picom"
if [ ! -d "/etc/xdg" ]; then
	sudo mkdir /etc/xdg
fi
sudo cp ./.config/picom/picom.conf /etc/xdg

# Configure GRUB Theme

# Create themes directory if not exists
prompt -i "\nChecking directory...\n"
[[ -d /boot/grub/themes/CyberRe ]] && rm -rf /boot/grub/themes/CyberRe
mkdir -p "/boot/grub/themes/CyberRe"

# Copy theme
prompt -i "\nInstalling theme...\n"

cp -a /usr/share/grub/themes/CyberRe/* /boot/grub/themes/CyberRe

# Set theme
prompt -i "\nSetting the theme as main...\n"

# Backup grub config
cp -an /etc/default/grub /etc/default/grub.bak

grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub

echo "GRUB_THEME=\"/boot/grub/themes/CyberRe/theme.txt\"" >> /etc/default/grub

# Update grub config
echo -e "Updating grub..."
if has_command update-grub; then
  update-grub
elif has_command grub-mkconfig; then
  grub-mkconfig -o /boot/grub/grub.cfg
elif has_command grub2-mkconfig; then
  if has_command zypper; then
    grub2-mkconfig -o /boot/grub2/grub.cfg
  elif has_command dnf; then
    grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
  fi
fi

# Reboot
#sudo reboot
