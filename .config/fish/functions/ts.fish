function ts --description 'download .ts segments and combine to .mp4 from .m3u8'
   set -l url $argv[1]
   set -l name $argv[2]
   
   if not test $name
      for file in (string split "/" -- $url)
         if string match --quiet --regex '.mp4$' $file >/dev/null
            set name $file
         end
      end
   else
      set name $name".mp4"
   end
   
   command ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$url" -c copy "$name"
   echo 'done:' $name
end
