#!/bin/bash
source $(dirname "$0")/goodvibes.sh

echo "$player_track_name" | xclip -selection c && notify-send "Copied to clipboard" "$player_track_name"
exit
