#!/usr/bin/env zsh

THEME_FILE="$HOME/.config/current_theme"
THEME_BASE_DIR="$HOME/.local/share/themes"
DWM_THEME=$(cat "$THEME_FILE")
MONITOR_LIST=($(xrandr | grep " connected" | awk '{print $1}'))
MONITOR_COUNT=${#MONITOR_LIST[@]}


backgrounds=("${(f)$(shuf -- "$1" | sed -e 's/^"//' -e 's/"$//' | sed -e "s#^\$HOME/#$HOME/#")}")
realpath -- "${backgrounds[1]}"

case "$MONITOR_COUNT" in
2)
    screenweaver --compositor \
        "${backgrounds[1]}" 1 0 0 2560 1440 &!
    ;;
3)
    screenweaver --compositor \
        "${backgrounds[1]}" 1 0    0 2560 1440 \
        "${backgrounds[2]}" 1 2560 0 2560 1440 &!
    ;;
4)
    screenweaver --compositor \
        "${backgrounds[1]}" 1 0    0 2560 1440 \
        "${backgrounds[2]}" 1 2560 0 2560 1440 \
        "${backgrounds[3]}" 1 5120 0 2560 1440 &!
    ;;
*)
    screenweaver --compositor \
        "${backgrounds[1]}" 1 0 0 1920 1080 &!
    ;;
esac
