#!/bin/bash

goodvibes_status=$(qdbus org.mpris.MediaPlayer2.Goodvibes /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus 2>/dev/null)
player_track_name=''

if [[ $(pidof goodvibes 2>/dev/null) && "$goodvibes_status" == "Playing" ]];then
   player_track_name=$(qdbus org.mpris.MediaPlayer2.Goodvibes /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep "^xesam:title:" | cut -d':' -f3-)
fi

echo $player_track_name

exit
