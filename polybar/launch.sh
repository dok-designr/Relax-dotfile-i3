#!/usr/bin/env bash
pkill  polybar

# Top side
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar  mybar 
