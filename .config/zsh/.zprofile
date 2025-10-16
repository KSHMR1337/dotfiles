#!/bin/sh

# profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
tmp1=$(find ~/.local/bin -type d -printf %p:)
tmp2=$(find ~/.local/bin/dwmblocks -type d -printf %p:)
export PATH="$PATH:${tmp1%%:}"
export PATH="$PATH:${tmp2%%:}"
export PATH="$PATH:/home/kshmr/.cargo/bin"

## mimeapps
export XDG_UTILS_DEBUG_LEVEL=2

## Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="librewolf"

## Setup Java
export _JAVA_AWT_WM_NONREPARENTING=1

# Setup Foundry
export PATH="$PATH:/home/kshmr/.foundry/bin"

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

# Setup nvim as manpager
export MANPAGER='nvim +Man!'

# Safe Dark Theme Configuration
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE="kvantum-dark"

