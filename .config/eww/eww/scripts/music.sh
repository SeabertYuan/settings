#!/bin/sh	

player=$(playerctl -p spotify status)
title=$(playerctl metadata --player=spotify --format '{{ title }}')
artist=$(playerctl metadata --player=spotify --format '{{ artist }}')
album=$(playerctl metadata --player=spotify --format '{{ album }}')

position=$(playerctl position --player=spotify)
position=${position%%.*}
duration=$(playerctl metadata mpris:length --player=spotify)
#duration=${duration%000000*}

case $1 in
	"status")
	    [ "$player" = "Playing" ] && status="" || status="Not playing media"
            echo $status ;;
	"statusbut")
	    [ "$player" = "Playing" ] && icon="" || icon=""
            echo $icon ;;
	"title")
            [ -z "$title" ] && title=""
            echo $title ;;
	"artist")
            [ -z "$artist" ] && artist="Unknown"
            echo $artist ;;
	"album")
            [ -z "$album" ] && album=""
            echo $album ;;
	"dispprog")
	    [ $(playerctl metadata --player=spotify mpris:length | wc -c) -gt 0 ] && printf "%02d:%02d" $((position%3600/60)) $((position%60)) && printf " / " && printf "%02d:%02d" $((duration/1000000/60)) $((duration/1000000%60)) || printf "00:00 / 00:00" ;;
	"progress")
	    echo $((position*100000000/duration)) ;;
	"duration")
	    echo $duration ;;
esac
