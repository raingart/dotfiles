function cs --description 'cd and ls'
   if test "$argv"
      cd "$argv" ;and ls
   else
      cd '/tmp'
   end
end
