#!/bin/sh

# profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
tmp1=$(find ~/.local/bin -type d -printf %p:)
tmp2=$(find ~/.local/bin/dwmblocks -type d -printf %p:)
export PATH="$PATH:${tmp1%%:}"
export PATH="$PATH:${tmp2%%:}"

# Setup themes
export GTK_THEME="retrowave-glow:dark"
export GTK2_RC_FILES="/usr/share/themes/retrowave-glow/gtk-2.0/gtkrc"
export QT_STYLE_OVERRIDE="retrowave-glow:dark"

## mimeapps
export XDG_UTILS_DEBUG_LEVEL=2

## Default programs:
export EDITOR="nvim"
export TERMINAL="st"

#export BROWSER="librewolf"
export OPENER="xdg-open"

## Setup Java
export JAVA_HOME=/usr/lib/jvm/bellsoft-java8-full-amd64

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
