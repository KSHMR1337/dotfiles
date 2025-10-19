#!/bin/zsh

do_splash.sh $HOME/.splash
set_background.sh $HOME/.backgrounds
xsettingsd &
mpd &
picom --backend glx &
dwmblocks & 
exec dwm


