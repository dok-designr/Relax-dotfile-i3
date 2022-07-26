#!/bin/bash

#########################################
# SHAMELESS RIPOFF FROM ANOTHER GUY LUL #
#########################################

pkill dunst

dunst -config ~/.config/dunst/dunstrc &


notify-send -i ~/.config/dunst/icons/desktop.svg "hello, have nice day $USER 🌟" 

mpv ~/Music/hello.mp3 --no-video




