#!/bin/bash
# toggle_vol -- toggle between speaker and headphones

speaker_control="Front"
headphone_control="Headphone"

if [[ "$(amixer sget ${speaker_control} |grep '%' |awk '{print $7}' |tail -n1)" == "[on]" ]];then
# if [[ "$front_status" == "[on]" ]];then
  amixer set $speaker_control mute
  amixer set $headphone_control unmute
else
  amixer set $speaker_control unmute
  amixer set $headphone_control mute
fi


status=`amixer get $headphone_control |grep "Front Left:" |awk '{ print ($7) }' |sed 's/[][]//g'`

notify-send "$headphone_control" "$status" -u normal -t 1000 -h int:transient:1;