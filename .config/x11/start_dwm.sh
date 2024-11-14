#!/bin/sh

monitor_count=$(xrandr | grep -c " connected ")

case "$monitor_count" in 
	2)
		paperview --compositor /home/kshmr/.local/share/background/ultraviolenceII 5 0 0 1920 1080 &
		;;

	3)
		paperview --compositor /home/kshmr/.local/share/background/ultraviolenceI 3 0 0 1920 1080 /home/kshmr/.local/share/background/ultraviolenceII 3 1920 0 1920 1080 /home/kshmr/.local/share/background/ultraviolenceIII 3 3840 0 1920 1080 &
		;;

	4)
		paperview --compositor /home/kshmr/.local/share/background/ultraviolenceI 3 0 0 1920 1080 /home/kshmr/.local/share/background/ultraviolenceII 3 1920 0 2560 1440 /home/kshmr/.local/share/background/ultraviolenceIII 3 4480 0 1920 1080 &
		;;

	*)
		paperview --compositor /home/kshmr/.local/share/background/ultraviolenceII 5 0 0 1920 1080 &
		;;
esac

mpd &
picom --no-frame-pacing &
dwmblocks & 
exec dwm


