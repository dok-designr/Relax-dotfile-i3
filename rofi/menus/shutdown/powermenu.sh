#!/usr/bin/env bash


# A fork from Benjamin Chrétien menu
# Use rofi to change system runstate thanks to systemd.
#
# Inspired from i3pystatus wiki:
# https://github.com/enkore/i3pystatus/wiki/Shutdown-Menu
#


# Get updtime
uptime=$(uptime -p | sed -e 's/up //g')

#  Change rofi theme here
rofi_theme="rofi -theme ~/.config/rofi/menus/shutdown/powermenu.rasi"
rofi_theme_2="rofi -theme ~/.config/rofi/menus/shutdown/powermenu.rasi"

# Whether to ask for user's confirmation
enable_confirmation=true

# This script depends on:
#   - systemd,
#   - i3,
#   - rofi
usage="$(basename "$0") [-h] [-c] -- display a menu for shutdown, reboot, lock etc.

where:
    -h  show this help text
    -c  ask for user confirmation

This script depends on:
  	-systemd,
  	-i3,
  	-rofi
"

# Generate Menu Map
typeset -A menu
function generate_map() {
	
	menu[ Shutdown]="systemctl poweroff"
	menu[ Restart]="systemctl reboot"
  	menu[ Sleep]="systemctl suspend"
  	menu[ Lock]="zsh ~/.config/i3/scripts/lock.sh"
  	menu[  Logout]="i3-msg exit"
	
}
# Call the generator thingy
generate_map

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "You Sure? : "\
		-theme ~/.config/i3/material_rofi.rasi
}

# Check whether a command exists#####
function command_exists() {
  command -v "$1" &> /dev/null 2>&1
}

# systemctl required
if ! command_exists systemctl ; then
  exit 1
fi

# Store selection
selection="$(printf '%s\n' "${!menu[@]}" | sort )"

# Variable passed to rofi
chosen="$(echo -e "$selection" | $rofi_theme -p " Uptime: $uptime" -dmenu -selected-row 0)"

# Ask user for confirmation (so user can enable or disable the confirmation)
function ask_confirmation() {
	confirmed=$(echo -e "Yes\nNo" | rofi -dmenu -i -lines 2 -p "${chosen}?" ${rofi_theme_2} )
    [ "${confirmed}" == "Yes" ] && confirmed=0

	if [ "${confirmed}" == 0 ]; then
		i3-msg -q "exec ${menu[${chosen}]}"
	fi
}

# Run this piece of garbage
if [[ $? -eq 0 && ! -z ${chosen} ]]; then
  if [[ "${enable_confirmation}" = true ]]; then
    ask_confirmation
  else
    i3-msg -q "exec ${menu[${chosen}]}"
  fi
fi
