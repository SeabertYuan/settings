#!/bin/sh
if [ -z ${1} ]; then
  feh
  exit
fi
FPATH="$1"
FNAME="$(basename "$FPATH")"
DPATH="$(dirname "$FPATH")"
if [ $DPATH = "" ]; then
  DPATH="."
  FPATH="./$FNAME"
fi
feh --start-at $FPATH $DPATH

