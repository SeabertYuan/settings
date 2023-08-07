#!/bin/bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar mybar-internal &

my_laptop_external_monitor=$(xrandr --query | grep 'DP-3')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    polybar mybar &
fi

~/./hideIt.sh --name 'polybar-mybar_DP-3' -p 3 -d top -H &
xdo raise -a 'polybar-mybar_DP-3' &

#polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown
