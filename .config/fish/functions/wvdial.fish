function wvdial
   set -l last_status_code $status
   
   # if [ $? -eq 0 ]; then
     # echo Found
   # fi
   
   # command wvdial -n $argv > /dev/null
   # if test (command wvdial -n $argv > /dev/null) -gt 0
   # if test $last_status_code -ne 0
   # if test (command wvdial -n $argv > /dev/null) -ne 0
      # echo 1111 $last_status_code
   # else
      # echo 2222 $last_status_code
      # usbsw
   # end


   # if type -q figlet
     # hostname | figlet
   # end

   # if command -s wvdial -n $argv > /dev/null
     # echo 333 $last_status_code
   # end
   usbsw;

   command wvdial -n $argv > /dev/null
   
   notify-send "wvdial" "disconnect" -u critical
   # nohup mpg123 -q ~/.config/i3/noti.mp3 > /dev/null 2>&1
end
