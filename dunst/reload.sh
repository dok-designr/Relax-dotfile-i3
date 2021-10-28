#!/bin/bash

#########################################
# SHAMELESS RIPOFF FROM ANOTHER GUY LUL #
#########################################
fullname=`getent passwd $USER | cut -d ":" -f 5 | cut -d "," -f 1`
pkill dunst
dunst -config ~/.config/dunst/dunstrc &

 notify-send -i ~/.config/dunst/icons/desktop.svg "hello $fullname , I am habe see you " 



desktop.svg
