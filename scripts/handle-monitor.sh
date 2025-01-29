#!/bin/sh

# This didn't work
# if [ $(swaymsg -t get_outputs | grep "DP-3" | wc -l) == 1 ]; then
#     export WLR_DRM_DEVICES=/dev/dri/card1 # NVIDIA card
#     swaymsg output DP-3 enable
# else
#     unset WLR_DRM_DEVICES
#     swaymsg output eDP-1 enable
#     echo "uh oh"
# fi
