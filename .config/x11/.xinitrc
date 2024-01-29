#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xclock -geometry 50x50-1+1 &



xrandr --setprovideroutputsource "AMD Radeon Graphics @ pci:0000:06:00.0" NVIDIA-0 
xrandr --dpi 75
xrandr --output eDP-1-0 --mode 1920x1080 --primary  
xrandr --output DP-2 --right-of eDP-1-0 --mode 1920x1080
xrandr --output HDMI-0 --left-of eDP-1-0 --mode 1920x1080 
 

setbg & 

mpd &
picom --backend glx &
# picom &
dwmblocks & 
#unclutter

exec dwm



#exec startplasma-x11
