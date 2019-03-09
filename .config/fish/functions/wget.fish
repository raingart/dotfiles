# -eq:"==", -ne:"!=", -lt:"<", -le "<=": , -gt:">" -ge:">="

function wget --description 'wget'
   #if not test -z (echo $argv)

   # site
   if test $argv[1] -eq "s"
      echo "wget site:"
      command wget -r -k -l 10 -p -E -nc "$argv[2]"

   # single file (manual name)
   else if begin; test (count $argv) -eq 2 ;and test $argv[1]; end
      echo "wget referer url"
      echo "referer:" $argv[1]
      echo "Saving:" $argv[-1]
      echo "----------------"
      command wget -c --content-disposition --trust-server-names=on --restrict-file-names=nocontrol --no-check-certificate $argv[1] -O $argv[-1]
      
   # single file (auto name)
   else if test "$argv"
      echo "wget single file:"
      command wget -c "$argv[1]"
      
   else
      wget -h
   end
end
