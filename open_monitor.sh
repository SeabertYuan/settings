#!/bin/bash

external_monitor=$(xrandr --query | grep 'DP-1-2')
if [[ $external_monitor = *connected* ]]; then
	xrandr --output eDP1 --auto --pos 320x1440 --output DP-1-2 --primary --mode 2560x1440 --pos 0x0
fi
