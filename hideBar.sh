#!/bin/bash

polybar-msg cmd show
wid=($(xdotool search --name "polybar-mybar_DP-3"))
wid=(${wid:--1})
xdo raise $wid &

CURSOR_IN_REGION=1

REGION_END=25

while [ "$CURSOR_IN_REGION" -eq 1 ];
do
	Y_POS=$(xdotool getmouselocation | cut -d " " -f2 | cut -d ":" -f2)
	Y_POS=$(($Y_POS))
	if [ "$Y_POS" -gt "$REGION_END" ]; then
		CURSOR_IN_REGION=0
	else
		sleep 0.05
	fi
done

polybar-msg cmd hide
