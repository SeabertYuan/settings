#!/bin/bash

case $1 in
    dbrightness)
        MAX_BRIGHT=$(brightnessctl max)
        CURR_BRIGHT=$(brightnessctl get)
        THRESH_BRIGHT=$(echo "($MAX_BRIGHT*0.07+1)/1" | bc)
        # echo $THRESH_BRIGHT
        if [ $CURR_BRIGHT -le $THRESH_BRIGHT ]; then
            # echo $CURR_BRIGHT
            CURR_BRIGHT=$(echo "$CURR_BRIGHT/2" | bc)
            # echo $CURR_BRIGHT
            brightnessctl set $CURR_BRIGHT
        else
            brightnessctl set 7%-
        fi
        ;;
    ibrightness)
        MAX_BRIGHT=$(brightnessctl max)
        CURR_BRIGHT=$(brightnessctl get)
        THRESH_BRIGHT=$(echo "($MAX_BRIGHT*0.07+1)/1" | bc)
        # echo $THRESH_BRIGHT
        if [ $CURR_BRIGHT -le $THRESH_BRIGHT ]; then
            # echo $CURR_BRIGHT
            CURR_BRIGHT=$(echo "$CURR_BRIGHT*2+1" | bc)
            # echo $CURR_BRIGHT
            brightnessctl set $CURR_BRIGHT
        else
            brightnessctl set 7%+
        fi
        ;;
esac
