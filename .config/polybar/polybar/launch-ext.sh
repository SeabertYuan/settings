#!/bin/bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar

polybar mybar &

#my_laptop_external_monitor=$(xrandr --query | grep ' DP-3 ') when on nvidia
#my_laptop_external_monitor=$(xrandr --query | grep 'DP-1-2')
#if [[ $my_laptop_external_monitor = *connected* ]]; then
    #polybar mybar &
    ##~/./hideIt.sh --name 'polybar-mybar_DP-3' -p 3 -d top -H &
    #xdo raise -a 'polybar-mybar_DP-3' &
#else
    #polybar mybar-internal &
#fi

#~/./hideIt.sh --name 'polybar-mybar-internal_eDP1' -p 3 -d top -H &
#xdo raise -a 'polybar-mybar-internal_eDP1' &

#polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown
