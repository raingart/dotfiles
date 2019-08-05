function tsl --description 'send lines file to "ts" command'
   for line in (cat $argv[1]);
      ts $line;
   end
end
