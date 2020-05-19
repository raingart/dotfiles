function tsl --description 'send lines file to "ts" command'

   if set -q argv[2]
      set last $argv[2];
   else
      set last 1;
   end
   
   for line in (cat $argv[1]);
      ts "$line" $last;
      set last (math $last + 1);
   end
end
