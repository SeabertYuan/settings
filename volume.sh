#!/bin/bash


step=2
max=100

function get_current_volume() {
	pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' '{print $2}' | grep -o '[0-9]\+'
}

if [ $1 == "raise" ]; then
	if [ `get_current_volume` -lt ${max} ]; then
		pactl set-sink-volume @DEFAULT_SINK@ "+${step}%"
	fi

elif [ $1 == "lower" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ "-${step}%"
fi
