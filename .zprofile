#!/bin/sh

# profile file. Runs on login. Environmental variables are set here.

# Language
#export LANG=sr_RS.UTF-8@latin

# Adds `~/.local/bin` to $PATH
tmp1=$(find ~/.local/bin -type d -printf %p:)
tmp2=$(find ~/.local/bin/dwmblocks -type d -printf %p:)
export PATH="$PATH:${tmp1%%:}"
export PATH="$PATH:${tmp2%%:}"

## GPU
#export LIBVA_DRIVER_NAME=i965
#
## mimeapps
#export XDG_UTILS_DEBUG_LEVEL=2
#
#unsetopt PROMPT_SP
#
## Default programs:
#export EDITOR="nvim"
#export TERMINAL="st"
#export BROWSER="librewolf"
#export OPENER="xdg-open"
#
## ~/ Clean-up:
#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_CACHE_HOME="$HOME/.cache"
#export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
#export LESSHISTFILE="-"
#export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
##export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
#export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
##export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
##export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
##export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
##export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
#export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
##export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
#export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
#export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/cache"
#export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
#export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
#export SSB_HOME="$XDG_DATA_HOME/zoom"
#export ANDROID_HOME="$XDG_DATA_HOME"/android
#
#[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && shortcuts >/dev/null 2>&1 &

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
