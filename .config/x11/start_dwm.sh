#!/bin/zsh

monitor_count=$(xrandr | grep -c " connected ")

case "$monitor_count" in
        2)
                paperview --compositor /home/zare/.local/share/background/bladerunner 5 0 0 1920 1080 &
                ;;

        3)
                paperview --compositor /home/zare/.local/share/background/bladerunner 20 0 0 1920 1080 /home/zare/.local/share/background/synthwavecity 10 1920 0 1920 1080 /home/zare/.local/share/background/rainycity 20 4480 0 1920 1080 &
                ;;

        4)
                paperview --compositor /home/zare/.local/share/background/bladerunner 20 0 0 1920 1080 /home/zare/.local/share/background/synthwavecity 10 1920 0 2560 1440 /home/zare/.local/share/background/rainycity 20 4480 0 1920 1080 &
                ;;

        *)
                paperview --compositor /home/zare/.local/share/background/bladerunner 5 0 0 1920 1080 &
                ;;
esac

mpd &
picom --no-frame-pacing &
dwmblocks &
dunst &
exec dwm

