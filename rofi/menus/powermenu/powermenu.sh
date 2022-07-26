#!/usr/bin/env bash

## Copyright (C) 2020-2021 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

rofi_command="rofi -theme ~/.config/rofi/menus/powermenu/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
_msg="Options  -  yes / y / no / n"

chosen="$(echo -e "$options" | $rofi_command -p "UP: $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		ans=$($HOME/.config/rofi/menus/powermenu/askpass.sh &)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			mpv ~/Music/hello.mp3 --no-video
			systemctl poweroff
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
          else
			rofi -dmenu\
     -i\
     -no-fixed-num-lines\
     -p "Are You Sure? : "\
     -theme ~/.config/rofi/menus/powermenu/askpass.rasi -e "$_msg"
        fi
        ;;
    $reboot)
		ans=$($HOME/.config/rofi/menus/powermenu/askpass.sh &)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			mpv ~/Music/hello.mp3 --no-video
			systemctl reboot
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			rofi -dmenu\
     -i\
     -no-fixed-num-lines\
     -p "Are You Sure? : "\
     -~/.config/rofi/menus/powermenu/askpass.rasi -e "$_msg"
        fi
        ;;
    $lock)
        ~/.config/i3/scripts/lock.sh
        ;;
    $suspend)
		ans=$($HOME/.config/rofi/menus/powermenu/askpass.sh &)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			mpv ~/Music/hello.mp3 --no-video
			mpc -q pause
			amixer set Master mute
			betterlockscreen --suspend
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
            else
			rofi -dmenu\
     -i\
     -no-fixed-num-lines\
     -p "Are You Sure? : "\
     -theme ~/.config/rofi/menus/powermenu/askpass.rasi -e "$_msg"
        fi
        ;;
    $logout)
		ans=$($HOME/.config/rofi/menus/powermenu/askpass.sh &)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			mpv ~/Music/hello.mp3 --no-video
			pkill i3
			pkill bspwm
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			
			exit
        else
			rofi -dmenu\
     -i\
     -no-fixed-num-lines\
     -p "Are You Sure? : "\
     -theme ~/.config/rofi/menus/powermenu/askpass.rasi -e "$_msg"
        fi
        ;;

esac
