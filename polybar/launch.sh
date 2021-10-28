#!/usr/bin/env bash
pkill polybar
pkill i3bar
# Top side

polybar -c ~/.config/polybar/config mybar &
