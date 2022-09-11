# -eq:"==", -ne:"!=", -lt:"<", -le "<=": , -gt:">" -ge:">="

function fish_right_prompt -d "Write out the right prompt"
   set -l last_status_code $status
   set -l max_duration_ms 200
         
   # last command status failed
   if test $last_status_code -ne 0
      echo (color_digit)"["(color_bad)"$last_status_code"(color_digit)"]"(color_off)

   else if test -n "$SSH_CONNECTION"
      printf (color_bad)":"(color_digit)"$HOSTNAME "(color_off)
      
   # Show duration of the last command in ms
   else if test $CMD_DURATION -ge $max_duration_ms
      
      # --icon=dialog-information
      notify-send "Terminal" "[$last_status_code] $history[1] finished in $(humantime $CMD_DURATION)" -u low &
      sh ~/.config/dunst/sound.sh
      
   # show time
   else
      printf (color_digit)(date +%H(color_dot):(color_digit)%M(color_dot):(color_digit)%S)(color_off)
   end

   function humantime --argument-names ms --description "Turn milliseconds into a human-readable string"
       set --query ms[1] || return

       set --local secs (math --scale=1 $ms/1000 % 60)
       set --local mins (math --scale=0 $ms/60000 % 60)
       set --local hours (math --scale=0 $ms/3600000)

       test $hours -gt 0 && set --local --append out $hours"h"
       test $mins -gt 0 && set --local --append out $mins"m"
       test $secs -gt 0 && set --local --append out $secs"s"

       set --query out && echo $out || echo $ms"ms"
   end
end
