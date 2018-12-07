# reload setting:
# source ~/.bashrc or . ~/.bashrc

# Add default apps
export EDITOR=nano
export VISUAL=geany
export TERMINAL=tilix
export BROWSER=chromium

# Gtk themes 
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

trap '_start=$SECONDS' DEBUG
PROMPT_COMMAND='(if (( SECONDS - _start > 5 )); \
then notify-send "$([ $? = 0 ] && echo Terminal || echo error)" \
"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*echo$//'\'')" \
--urgency=low; fi)'
# --icon=dialog-information & mpg123 -q ~/Videos/Perfect\ Notification0.mp3; fi)'

PROMPT_COMMAND="$PROMPT_COMMAND; history -a"
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:sleep:[bf]g:exit"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

COLOR_WHITE="\[\e[1;37m\]"
COLOR_BLACK="\[\e[0;30m\]"
COLOR_BLUE="\[\e[0;34m\]"
COLOR_LIGHT_BLUE="\[\e[1;34m\]"
COLOR_GREEN="\[\e[0;32m\]"
COLOR_LIGHT_GREEN="\[\e[1;32m\]"
COLOR_CYAN="\[\e[0;36m\]"
COLOR_LIGHT_CYAN="\[\e[1;36m\]"
COLOR_RED="\[\e[0;31m\]"
COLOR_LIGHT_RED="\[\e[1;31m\]"
COLOR_PURPLE="\[\e[0;35m\]"
COLOR_LIGHT_PURPLE="\[\e[1;35m\]"
COLOR_BROWN="\[\e[0;33m\]"
COLOR_YELLOW="\[\e[1;33m\]"
COLOR_GRAY="\[\e[0;30m\]"
COLOR_LIGHT_GRAY="\[\e[0;37m\]"
COLOR_RESET='\[\e[00m\]'

PS1="$COLOR_WHITE\$(if [[ \$? == 0 ]];\
then echo '$COLOR_LIGHT_GREENツ';\
else echo '$COLOR_RED✘'; fi)\
$COLOR_BLUE\w$COLOR_RESET > "

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias x='exit'
alias ls='ls -a --color=auto'

# CALCULATOR
# function calc { echo "${1}"|bc -l; }

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

