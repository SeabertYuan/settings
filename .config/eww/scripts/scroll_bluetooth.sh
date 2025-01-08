#!/bin/bash

# see man zscroll for documentation of the following parameters
#zscroll -l 5 -b "  " "$(~/.config/eww/scripts/music.sh title)" &

zscroll -l 15 \
        --delay 0.27 \
        --scroll-padding " " \
        --update-check true "`dirname $0`/bluetooth.sh device"


