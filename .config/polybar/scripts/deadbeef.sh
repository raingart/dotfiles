#!/bin/bash

player_track_name=$(deadbeef --nowplaying "%a - %t" 2>/dev/null)

[[ "$player_track_name" == "nothing" ]] && echo '' || echo $player_track_name
