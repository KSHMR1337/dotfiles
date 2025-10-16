#!/bin/sh

## setup script for dwm with my dotfiles

sudo pacman --needed --noconfirm -Syu \
	archlinux-keyring alsa-utils base-devel dunst fd ffmpegthumbnailer fzf git github-cli htop imagemagick imlib2 jq \
	mlibxft maim an-db man-pages mpd mpv neofetch neovim npm openssh p7zip pamixer pavucontrol \
	picom plasma-framework5 plymouth poppler pulseaudio pulseaudio-alsa qt5-base qt5-quickcontrols \
	qt5-quickcontrols2 qt5-graphicaleffects qt5-svg ripgrep rsync sddm xorg-apps xclip \
	xorg-server xorg-xinit xorg-xrdb xsettingsd xwallpaper yazi zoxide zsh zsh-autosuggestions zsh-syntax-highlighting >~/install.log 2>&1 || exit

# Configure zsh
echo "Configuring zsh"
cp ./.config/zsh/.* ~

# Copy configurations
echo "Copying configurations and scripts"
if [ ! -d ~/.config ]; then
	mkdir ~/.config
fi

cp -rf ./{.config,.icons,.local,.themes} ~

# My git repos
echo "Cloning github repositories"
cd || exit
mkdir -p forsetup
cd forsetup || exit

#Installing yay
echo "Installing yay"
git clone https://aur.archlinux.org/yay.git >>~/install.log 2>&1
cd yay || exit
makepkg -si --noconfirm >>~/install.log 2>&1
cd ..

#Installing GRUB themes
echo "Installing GRUB themes"
if [ ! -d /usr/share/grub/themes ]; then
	mkdir /usr/share/grub/themes
fi
sudo cp -r ~/.local/share/grub/* /usr/share/grub/themes/
cd ..

#Installing dwm
echo "Installing dwm"
git clone https://github.com/KSHMR1337/dwm >>~/install.log 2>&1
cd dwm || exit
sudo make clean install >>~/install.log 2>&1
cd ..

#Installing dmenu
echo "Installing dmenu"
git clone https://github.com/KSHMR1337/dmenu >>~/install.log 2>&1
cd dmenu || exit
sudo make clean install >>~/install.log 2>&1
cd ..

#Installing st
echo "Installing st"
git clone https://github.com/KSHMR1337/st >>~/install.log 2>&1
cd st || exit
sudo make clean install >>~/install.log 2>&1
cd ..

#Installing dwmblocks
echo "Installing dwmblocks"
git clone https://github.com/KSHMR1337/dwmblocks >>~/install.log 2>&1
cd dwmblocks || exit
sudo make clean install >>~/install.log 2>&1
cd ..

#Installing slock
echo "Installing slock"
git clone https://github.com/KSHMR1337/slock >>~/install.log 2>&1
cd slock || exit
sudo make clean install >>~/install.log 2>&1
cd ..

#Installing tabbed
echo "Installing tabbed"
git clone https://github.com/KSHMR1337/tabbed >>~/install.log 2>&1
cd tabbed || exit
sudo make clean install >>~/install.log 2>&1
cd ..

#Installing xwinwrap
echo "Installing xwinwrap"
git clone https://github.com/ujjwal96/xwinwrap >>~/install.log 2>&1
cd xwinwrap || exit
sudo make >>~/install.log 2>&1
sudo make install >>~/install.log 2>&1
make clean >>~/install.log 2>&1
cd ..

#Installing paperview
echo "Installing screenweawer"
git clone https://github.com/KSHMR1337/screenweawer >>~/install.log 2>&1
cd screenweaver || exit
sudo make >>~/install.log 2>&1
sudo make install >>~/install.log 2>&1
make clean >>~/install.log 2>&1
cd ../../

#Installing paperview
echo "Installing simplesplash"
git clone https://github.com/KSHMR1337/simplesplash >>~/install.log 2>&1
cd simplesplash || exit
sudo make >>~/install.log 2>&1
sudo make install >>~/install.log 2>&1
make clean >>~/install.log 2>&1
cd ../../

# Configure plymouth
echo "Configuring plymouth"
if [ ! -d "/etc/plymouth" ]; then
	sudo mkdir /etc/plymouth
fi
sudo cp ./.config/plymouth/plymouthd.conf /etc/plymouth/
if [ ! -d "/usr/share/plymouth/themes" ]; then
	sudo mkdir -p /usr/share/plymouth/themes
fi
sudo cp -r ./.config/plymouth/themes/* /usr/share/plymouth/themes/

# Configure sddm

echo "Configuring sddm"
if [ ! -d "/etc/sddm.conf.d/" ]; then
	sudo mkdir /etc/sddm.conf.d/
fi
sudo cp ./.config/sddm/10-theme.conf /etc/sddm.conf.d/
sudo cp ./.config/sddm/sddm.conf /etc/

if [ ! -d "/usr/share/sddm" ]; then
	sudo mkdir /usr/share/sddm
fi
sudo cp -r ./.config/sddm/themes/* /usr/share/sddm/themes/
sudo cp -r ./.config/sddm/scripts/* /usr/share/sddm/scripts/
sudo systemctl enable sddm.service >>~/install.log 2>&1

# Configure dwm session for sddm
echo "Configuring dwm startup"
if [ ! -d "/usr/share/xsessions" ]; then
	sudo mkdir /usr/share/xsessions
fi
sudo cp ./.local/bin/change_theme.sh /usr/local/bin
sudo cp ./.local/bin/do_splash.sh /usr/local/bin
sudo cp ./.local/bin/start_dwm.sh /usr/local/bin
sudo cp ./.config/sddm/dwm.desktop /usr/share/xsessions
echo "Configured dwm"

#Configuring picom
echo "Configuring picom"
if [ ! -d "/etc/xdg" ]; then
	sudo mkdir /etc/xdg
fi
sudo cp ./.config/picom/picom.conf /etc/xdg

# Configure GRUB Theme

# Create themes directory if not exists
echo "Checking directory..."
[[ -d /boot/grub/themes/CyberRe ]] && sudo rm -rf /boot/grub/themes/CyberRe
sudo mkdir -p "/boot/grub/themes/CyberRe"

# Copy theme
echo "Installing theme..."

sudo cp -a /usr/share/grub/themes/CyberRe/* /boot/grub/themes/CyberRe

# Set theme
echo "Setting the theme as main..."

# Backup grub config
sudo cp -an /etc/default/grub /etc/default/grub.bak

grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sudo sed -i '/GRUB_THEME=/d' /etc/default/grub

echo 'GRUB_THEME="/boot/grub/themes/CyberRe/theme.txt"' | sudo tee -a /etc/default/grub >/dev/null

# Update grub config
echo "Updating grub..."

sudo grub-mkconfig -o /boot/grub/grub.cfg >>~/install.log 2>&1

echo "Installation finished successfully!"

# Reboot
#sudo reboot
