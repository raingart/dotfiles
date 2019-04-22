# -eq:"==", -ne:"!=", -lt:"<", -le "<=": , -gt:">" -ge:">="

function wget --description 'wget'
   #if not test -z (echo $argv)

   # site
   if test $argv[1] -eq "s"
      echo "wget site:"
      command wget -r -k -l 10 -p -E -nc "$argv[2]" robots=off 

   # single file (manual name)
   else if begin; test (count $argv) -eq 2 ;and test $argv[1]; end
      set -l name $argv[-1]'.'(string split "." -- $argv[1])[-1]
      echo "url:" $argv[1]
      echo "name:" $name
      echo "----------------"
      
      command wget -c --content-disposition --trust-server-names=on --restrict-file-names=nocontrol --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:26.0) Chrome/72.0.3626.96 Safari/537.36" $argv[1] -O "$name"
      
   # single file (auto name)
   else if test "$argv"
      echo "wget single file:"
      command wget -c --content-disposition --trust-server-names=on --restrict-file-names=nocontrol --no-check-certificate --user-agent="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:26.0) Chrome/72.0.3626.96 Safari/537.36" "$argv[1]"
      
   else
      command wget -h
   end
end
