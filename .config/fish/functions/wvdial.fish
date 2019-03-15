function wvdial
   # usbsw;
   command killall conky; conky
   command wvdial -n $argv > /dev/null
   notify-send "wvdial" "disconnect" -u critical
   # nohup mpg123 -q ~/.config/i3/noti.mp3 > /dev/null 2>&1
end
