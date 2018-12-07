# -eq:"==", -ne:"!=", -lt:"<", -le "<=": , -gt:">" -ge:">="
function fish_prompt --description 'Write out the prompt'
   set -l last_status_code $status

   # if test $last_status_code = 0
   #   set prefix (color_good) 'ツ'
   # else
   #   set prefix (color_bad) '✗ ' # ✘
   #   set prefix $prefix $last_status_code
   #   printf '%s' ($last_status_code)
   # end

   test $status -ne 0;
      and set -l colors 600 900 c00
      or set -l colors 444 555 blue

   set -l color_cwd
   # set -l suffix
   switch $USER
      case root toor
         if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
         else
            set color_cwd $fish_color_cwd
         end
         # set suffix '#'
      case '*'
         # set color_cwd $fish_color_cwd
         set color_cwd blue
         # set suffix '>'
      end

   echo -n -s $prefix (set_color $color_cwd) (prompt_pwd) (color_off)" " # $suffix

   # suffix
   for color in $colors
      echo -n (set_color $color)">"
   end

   echo -n " "
end

# test $code -ne 0; and echo (color_digit)"("(color_bad)"$code"(color_digit)") "(color_off)
