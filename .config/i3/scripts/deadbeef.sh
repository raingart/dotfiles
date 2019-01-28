#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
web_open_url="\youtube.com/results?search_query="

# the regex is actually straightforward:
# \[     #match [
# [^]]*  #match any non "]" chars
# \]     #match ]
#player_track_name=$(deadbeef --nowplaying "%a - %t" 2>/dev/null | sed 's/\[[^]]*\]//g' | sed 's/|[0-9]\{7\}//g' )
player_track_name=$(deadbeef --nowplaying "%a - %t" 2>/dev/null)

# -eq:"==", -ne:"!=", -lt:"<", -le "<=": , -gt:">" -ge:">="

# show_play_track() {
  if [[ $player_track_name == "nothing" ]];then
      echo ''
  # elif [[ $player_track_name = "Paused" ]]; then
      # echo ''
  else
      echo $player_track_name
  fi
# }

# show_play_track

# defines i3blocks mouse click events
# case $BLOCK_BUTTON in
   # ## left click
   # 1) chromium "${web_open_url}${player_track_name}" ;;
   # ## middle click
   # 2) echo ${player_track_name} | xclip -selection c && notify-send "Copied to clipboard" "${player_track_name}"  ;;
   # ## right click
   # 3) chromium "${player_track_name}" ;;
# esac

# exit 0
