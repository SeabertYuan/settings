#!/bin/bash

zscroll -l 14 \
        --delay 0.27 \
        --scroll-padding " " \
        --match-command "playerctl --player=spotify status 2>/dev/null" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "playerctl --player=spotify metadata --format '{{ album }}'"


