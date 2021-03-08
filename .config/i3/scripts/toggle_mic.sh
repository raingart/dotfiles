#!/bin/bash
# Mic Mute Toggle

target_alsa_control="Capture"

amixer set "$target_alsa_control" toggle;

status=`amixer get $target_alsa_control |grep "Front Left:" |awk '{ print ($7) }' |cut -d '[' -f2 |cut -d ']' -f1`

notify-send -i /*microphone-sensitivity-medium*/ "Microphone" "$status" -u normal -t 1000 -h int:transient:1;
