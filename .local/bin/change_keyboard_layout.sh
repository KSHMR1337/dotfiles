#!/bin/sh

current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')
if [ "$current_layout" == "rs" ]; then
    setxkbmap us
else
    setxkbmap rs latin
fi
