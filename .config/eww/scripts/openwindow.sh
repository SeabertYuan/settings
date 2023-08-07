#!/bin/sh

case $1 in
	"reboot")
		shutdown -r now ;;
	"power")
		shutdown now ;;
esac
