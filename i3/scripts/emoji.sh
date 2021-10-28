#!/usr/bin/env bash

cat ~/.config/i3/scripts/emoji.txt |rofi -dmenu -i -p "Which emoji? ⭐ " -theme ~/.config/rofi/launcher.rasi -font "twemoji 16" | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
