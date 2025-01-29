#!/bin/sh

echo 75 | sudo tee /sys/class/power_supply/BAT0/charge_start_threshold >/dev/null
echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_stop_threshold >/dev/null
