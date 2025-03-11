#!/bin/sh

if pgrep ffmpeg
then
		pkill ffmpeg
		notify-send "saved recording." -t 700
				echo "file:///home/seabert/Downloads/recording.mp3" | wl-copy -t text/uri-list
else
		notify-send "recording audio..." -t 700
		# ffmpeg -y -f pulse -i alsa_output.pci-0000_00_1f.3.analog-stereo.monitor -ac 2 Downloads/recording.mp3
		# ffmpeg -y -f pulse -i alsa_output.usb-FiiO_FiiO_USB_DAC_E17K-01.analog-stereo.monitor -ac 2 -filter:a "volume=15.0" Downloads/recording.mp3
		DEVICE=`pactl info | rg "Default Sink" | awk '{print $3}'`
		if [ "$DEVICE" == "alsa_output.usb-FiiO_FiiO_USB_DAC_E17K-01.analog-stereo" ]; then
			ffmpeg -y -f pulse -i "$DEVICE.monitor" -ac 2 -filter:a "volume=17.0" ~/Downloads/recording.mp3
		else 
			ffmpeg -y -f pulse -i "$DEVICE.monitor" -ac 2 -filter:a "volume=2.0" ~/Downloads/recording.mp3
		fi
fi
