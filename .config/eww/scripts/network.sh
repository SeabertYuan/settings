#!/bin/sh

device=wlan0
#device=${device##*-}
#device=${device#* }

network=$(iwctl station $device show | grep "Connected network")
status=$(iwctl station $device show | grep "State")

#echo ${status##*e }
#echo ${network##*network  }

case $1 in
	"status")
		if [ ${status##*e } == "connected" ]; then
			echo "󰖩"
		else
			echo "󰖪"
		fi ;;
	"network")
		if [ ${status##*e } == "connected" ]; then
			echo ${network##*network  }
		else
			echo "No connection"
		fi ;;
	"toggle")
		if [ -z "${status##*e }" ]; then
			iwctl device $device set-property Powered on
		else
			iwctl device $device set-property Powered off
		fi ;;
esac
