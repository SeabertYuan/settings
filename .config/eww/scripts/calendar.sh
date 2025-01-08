#!/bin/sh

month=$(date -u +%m)
month=$((month-1)) # for some reason eww gives the month as a zero-based integer

echo $month
