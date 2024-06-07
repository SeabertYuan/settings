#!/bin/sh

device=$(pamixer --get-default-sink)
device=${device##*analog-stereo }

case $1 in
	"audevice")
		echo $device ;;
	"sysvol")
		vol=$(pamixer --get-volume)
                #vol=${vol#*[}
                #echo ${vol%%%*};;
								echo ${vol};;
	"sysmute")
		vol=$(pamixer --get-volume-human)
                #vol=${vol##*[}
		[ "${vol}" = "muted" ] && icon="" || icon=""
                echo $icon ;;
	"micvol")
		mic=$(amixer -c 1 sget Mic | grep "Right:")
                mic=${mic#*[}
                echo ${mic%%%*};; 
	"micmute")
		mic=$(amixer -c 1 sget Mic | grep "Left:")
                mic=${mic##*[}
		[ "${mic%%]*}" = "off" ] && icon="󰍬" || icon="󰍭"
                echo $icon ;;
	"musvol")
		vol=$(playerctl volume --player=spotify)
		hundred="100"
		result=$(bc -l <<<"$vol*$hundred")
		echo $result
		#[ "$vol" = "1.00" ] && vol=100 || vol=${vol##*.}
                #echo $vol

esac
