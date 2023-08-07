#!/bin/bash

case $1 in 
	"mount")
		rclone mount onedrive:OneSyncFiles/"Obsidian Cloud" /home/seabert/Documents/OneDrive/"Obsidian Cloud" --daemon;;
	"umount")
		umount /home/seabert/Documents/OneDrive/"Obsidian Cloud"
esac

