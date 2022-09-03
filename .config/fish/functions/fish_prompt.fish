# -eq:"==", -ne:"!=", -lt:"<", -le "<=": , -gt:'>' -ge:">="

# Function to show a segment
function prompt_segment -d "Function to show a segment"
    # Get colors
    set -l bg $argv[1]
    set -l fg $argv[2]

    # Set 'em
    set_color -b $bg
    set_color $fg

    # Print text
    if [ -n "$argv[3]" ]
        echo -n -s $argv[3](color_off)
    end
end

# Function to show current status
function show_status -d "Function to show the current status"
    set -l colors
    if [ $last_status_code -ne 0 ]
        set colors 600 900 c00
    else
        set colors 444 555 blue
    end
    #  stest $last_status_code -ne 0
    #  and set -l colors 600 900 c00
    #  or set -l colors 444 555 blue

    for color in $colors
        echo -n -s (set_color $color)'>'
        #  prompt_segment yellow $color '>'
    end
end

# function show_virtualenv -d "Show active python virtual environments"
#   if set -q VIRTUAL_ENV
#     set -l venvname (basename "$VIRTUAL_ENV")
#     prompt_segment normal white " ($venvname) "
#   end
# end

# Show user if not in default users
# function show_user -d "Show user"

# end

# Show directory
function show_pwd -d "Show the current directory"
    #    # Define colors
    # set -U budspencer_night 000000 083743 445659 fdf6e3 b58900 cb4b16 dc121f af005f 6c71c4 268bd2 2aa198 859900
    # set -U budspencer_day 000000 333333 666666 ffffff ffff00 ff6600 ff0000 ff0033 3300ff 00aaff 00ffff 00ff00
    # if not set -q budspencer_colors
    #   # Values are: black dark_gray light_gray white yellow orange red magenta violet blue cyan green

    # set -l color_pwd cb4b16 # orange
    # set -l color_pwd dc121f # red
    # set -l color_pwd ff0033 # red2
    # set -l color_pwd af005f # pink
    # set -l color_pwd 6c71c4 # violet
    # set -l color_pwd 00aaff # sky-blue
    # set -l color_pwd 268bd2 # green
    # set -l color_pwd 859900 # green2
    # set -l color_pwd b58900 # yellow
    set -l color_pwd 083743 # blue gray
    # set -l color_pwd 445659 # gray

    prompt_segment $color_pwd white (prompt_pwd)(color_off)(set_color $color_pwd)''
    #  echo -n -s (set_color blue) (prompt_pwd) (color_off)" "
end

# Show prompt w/ privilege cue
function show_prompt -d "Shows prompt with cue for current priv"
    set_color normal
    echo -n -s (color_off)" "
end

function fish_prompt --description 'Write out the prompt'
    set -g last_status_code $status
    #  show_virtualenv
    #  show_user
    show_pwd
    show_status
    show_prompt
end
