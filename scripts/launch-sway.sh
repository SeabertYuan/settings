#!/bin/bash

case $1 in
    "-l")
        WLR_DRM_DEVICES=/dev/dri/card2 sway --unsupported-gpu
        ;;
    "-d")
        sway --unsupported-gpu
        ;;
esac
