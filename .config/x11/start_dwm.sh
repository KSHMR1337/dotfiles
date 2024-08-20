#!/bin/zsh

paperview --compositor /home/zare/.local/share/background/bladerunner 20 0 0 1920 1080 /home/zare/.local/share/background/synthwavecity 10 1920 0 2560 1440 /home/zare/.local/share/background/rainycity 20 4480 0 1920 1080&
mpd &
picom --backend glx &
dwmblocks & 
exec dwm


