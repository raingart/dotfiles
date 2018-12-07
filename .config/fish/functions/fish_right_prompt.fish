# -eq:"==", -ne:"!=", -lt:"<", -le "<=": , -gt:">" -ge:">="

function fish_right_prompt -d "Write out the right prompt"
   set -l last_status_code $status

   if test -n "$SSH_CONNECTION"
      printf (color_bad)":"(color_digit)"$HOSTNAME "(color_off)
   end

   # Show duration of the last command in seconds
   if test $CMD_DURATION
      set secs (math "$CMD_DURATION / 1000")
      set duration_sec (echo "$CMD_DURATION 1000" | awk '{printf "%.3f", $1 / $2}')
      # set duration_sec (echo "scale=2; " $CMD_DURATION " / 1000" | bc)"s"

      set duration (math "$duration_sec % 60")

      if test $secs -ge 60
         set duration (math "$duration / 60")"m"
      else
         set duration $duration"s"
      end


      if test $secs -gt 0
         echo $duration
         # statements
      else if test $last_status_code -ne 0
         echo (color_digit)"["(color_bad)"$last_status_code"(color_digit)"]"(color_off)
      else
         printf (color_digit)(date +%H(color_dot):(color_digit)%M(color_dot):(color_digit)%S)(color_off)
      end

      if test $secs -ge 5
         # --icon=dialog-information
         notify-send "Terminal" "$history[1] finished in $duration ($status)" -u low &
      end

   end
end
