#!/bin/sh

rm -f ~/.config/mimeapps.list
stow --no-folding --ignore="laptop|artix|\.sh" -t ~ .
doas cp "artix/fi.w1.wpa_supplicant1.service" /usr/share/dbus-1/system-services/
doas stow --no-folding --ignore="\.rules" -t /etc/X11/xorg.conf.d laptop
doas stow --no-folding --ignore="\.conf" -t /etc/udev/rules.d laptop
