#!/bin/bash

player_track_name=$(qdbus org.mpris.MediaPlayer2.Goodvibes /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus)

# show_play_track() {
  if [[ $player_track_name == "Playing" ]];then
      echo $(qdbus org.mpris.MediaPlayer2.Goodvibes /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep "^xesam:title:" | cut -d':' -f3-)
  else
      echo ''
  fi
