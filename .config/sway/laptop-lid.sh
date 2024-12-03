#!/bin/sh

outputs=$(swaymsg -t get_outputs | grep "DP" | cut -d ":" -f 2 | sed -e 's/ //' -e 's/"//g' -e "s/,//")

# assumes that internal display will be 'eDP'
for output in $outputs; do
    if [[ $output =~ ^e ]]; then
        LAPTOP_OUTPUT=$output
    else
        LAST_OUTPUT=$output
    fi
done

echo "$LAST_OUTPUT"
echo "$LAPTOP_OUTPUT"

LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

read -r LS < "$LID_STATE_FILE"

case "$LS" in
*open)   swaymsg output "$LAPTOP_OUTPUT" enable ;;
*closed)
    if [[ $(swaymsg -t get_outputs | grep name | wc -l) == 1 ]]; then
        fusermount3 -u ssh_mnt #unmount ssh_mnt so the filesystem doesn't shit the bed
        swaylock --daemonize -e -f -i ~/Pictures/Kanagawa_blur.jpg
        sleep 1
        systemctl suspend
    else
        swaymsg output "*" disable
        swaymsg output "$LAST_OUTPUT" enable
        # swaymsg output "DP-1" enable
    fi ;;
*)       echo "Could not get lid state" >&2 ; exit 1 ;;
esac
