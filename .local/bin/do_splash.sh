#!/usr/bin/env zsh

MONITOR_LIST=($(xrandr | grep " connected" | awk '{print $1}'))
MONITOR_COUNT=${#MONITOR_LIST[@]}


backgrounds=("${(f)$(shuf -- "$1" | sed -e 's/^"//' -e 's/"$//' | sed -e "s#^\$HOME/#$HOME/#")}")
realpath -- "${backgrounds[1]}"

case "$MONITOR_COUNT" in
2)
    simplesplash \
        "${backgrounds[1]}" 3 0 0 2560 1440 &!
    ;;
3)
    simplesplash \
        "${backgrounds[1]}" 3 0    0 2560 1440 \
        "${backgrounds[2]}" 3 2560 0 2560 1440 &!
    ;;
4)
    simplesplash \
        "${backgrounds[1]}" 3 0    0 2560 1440 \
        "${backgrounds[2]}" 3 2560 0 2560 1440 \
        "${backgrounds[3]}" 3 5120 0 2560 1440 &!
    ;;
*)
    simplesplash \
        "${backgrounds[1]}" 3 0 0 1920 1080 &!
    ;;
esac
