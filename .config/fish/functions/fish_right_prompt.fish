# -eq:"==", -ne:"!=", -lt:"<", -le "<=": , -gt:">" -ge:">="

function fish_right_prompt -d "Write out the right prompt"
   set -l last_status_code $status
         
   # statements
   if test $last_status_code -ne 0
      echo (color_digit)"["(color_bad)"$last_status_code"(color_digit)"]"(color_off)

   else if test -n "$SSH_CONNECTION"
      printf (color_bad)":"(color_digit)"$HOSTNAME "(color_off)
      
   # Show duration of the last command in seconds
   else if test $CMD_DURATION
      set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3f", $1 / $2}')
      # set duration (echo "scale=2; " $CMD_DURATION " / 1000" | bc)"s"
         
      if test $duration -ge 5
         # --icon=dialog-information
         notify-send "Terminal" "$history[1] finished in $duration ($status)" -u low &
         sh ~/.config/dunst/sound.sh &
      end
         
      if test $duration -gt 0
         if test $duration -ge 60
            set duration (math "$duration / 60")"m"
         else
            set duration $duration"s"
         end
         
         echo $duration
         
      else
         printf (color_digit)(date +%H(color_dot):(color_digit)%M(color_dot):(color_digit)%S)(color_off)
      end
   end
end
