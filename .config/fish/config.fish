#!/usr/bin/env fish

set fish_greeting 'welcome'
set HISTSIZE  20000
set -x EDITOR 	nano
set -x VISUAL 	geany
set -x TERMINAL tilix
# set -x BROWSER 	chromium
# set -x GREP_OPTIONS  '--color=always'
set -x GREP_COLOR    'mt=1;33'
# set -x GREP_COLOR    '1;35;40'

# colors
# function color_dot; set_color -o 2B9; end
# function color_good; set_color -o 2B9; end
# function color_bad; set_color -o f06; end
function color_good; 	set_color 	2B9; end
function color_bad; 	set_color -o 	red; end
function color_dot; 	set_color    	333; end
function color_digit; 	set_color  	666; end
function color_off; 	set_color 	normal; end

# if not set -q abbrs_initialized
#   set -U abbrs_initialized
#   set -g fish_user_abbreviations
if status --is-interactive
   set FISH_SOURCE_LIST "aliases" "abbr" "git" #abbreviations
   set -l failed false
   set -l console_mute false

   for i in (seq (count $FISH_SOURCE_LIST))
      # echo $FISH_SOURCE[$i]
      set --local fish_patch_source ~/.config/fish/$FISH_SOURCE_LIST[$i].fish

      if test $console_mute = false
         echo -n Loading $FISH_SOURCE_LIST[$i]...
      end

      if test -e $fish_patch_source
         # source ~/.config/fish/$fish_source.fish
         source $fish_patch_source
         
         if test $console_mute = false
            echo (set_color green) '[ ok ]'(color_off)
         end
      else
         echo (color_bad) '[ fail ]'(color_off)
         set failed true
      end
  end

   # echo $failed
   if test $failed = false -a $console_mute = false
      # command sleep 1;
      printf "\033c";
      #clear ;and echo -en "\e[3J"
      #reset
   end

   if test -d "$HOME/bin"
      set -gx PATH $HOME/bin $PATH
   end
end

function setproxy --description 'Set Proxy'
   if test "$argv"
      # command export
      export {http,https,ftp,all}_proxy="http://$argv/"
      export no_proxy=localhost,127.0.0.0/8
      # export use_proxy=on
   end
   env | grep -i proxy
   # curl --proxy $argv check-host.net/ip
   curl check-host.net/ip
end

function unsetproxy --description 'Unset Proxy'
   unset http_proxy
   unset https_proxy
   unset ftp_proxy
   unset all_proxy
   unset no_proxy
   unset use_proxy
   curl check-host.net/ip
   env | grep -i proxy
end

# Loaded once (only first terminal)
# if not set -q git_initialized
#   set -U git_initialized
# end
# set ALIAS_FISH ~/.config/fish/aliases.fish
# if test -f $ALIAS_FISH
#   echo -n Setting aliases...
#   source $ALIAS_FISH
#   echo 'Done'
# end

# set PLATFORM_FISH  source ~/.config/fish/(hostname).fish
# set PLATFORM_FISH ~/.config/fish/(uname -s).fish
# if test -f $PLATFORM_FISH
#   source $PLATFORM_FISH
# else
#   echo Creating platform fish: $PLATFORM_FISH
#   touch $PLATFORM_FISH
# end

# case $OSTYPE:l in
# 	linux*)
# 		sudo apt full-upgrade -y
# 		;;
#
# 	darwin*)
# 		brew upgrade --fetch-HEAD || :
# 		;;
