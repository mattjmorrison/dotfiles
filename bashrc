#===============================================================================
#
#          FILE:  .bashrc
# 
#   DESCRIPTION: Configure bash in a pleasing manner 
# 
#        AUTHOR: Jarrod Taylor
#       CREATED: 06/19/2011 02:48:15 PM CDT
#      MODIFIED: 05/18/2012 
#===============================================================================

#-------------------------------------------------------------------------------
#  Set crazy bash color codes to English
#  Two formats for each group of 8, the second set includes escape characters
#  this keeps some of the code a little cleaner when possible 
#-------------------------------------------------------------------------------
# Reset
Color_Off='\e[0m'            # Text Reset
Color_Off_='\[\e[0m\]'       # Text Reset

# Regular Colors
Black='\e[0;30m'             # Black
Red='\e[0;31m'               # Red
Green='\e[0;32m'             # Green
Yellow='\e[0;33m'            # Yellow
Blue='\e[0;34m'              # Blue
Purple='\e[0;35m'            # Purple
Cyan='\e[0;36m'              # Cyan
White='\e[0;37m'             # White

Black_='\[\e[0;30m\]'        # Black
Red_='\[\e[0;31m\]'          # Red
Green_='\[\e[0;32m\]'        # Green
Yellow_='\[\e[0;33m\]'       # Yellow
Blue_='\[\e[0;34m\]'         # Blue
Purple_='\[\e[0;35m\]'       # Purple
Cyan_='\[\e[0;36m\]'         # Cyan
White_='\[\e[0;37m\]'        # White

# Bold
BBlack='\e[1;30m'            # Black
BRed='\e[1;31m'              # Red
BGreen='\e[1;32m'            # Green
BYellow='\e[1;33m'           # Yellow
BBlue='\e[1;34m'             # Blue
BPurple='\e[1;35m'           # Purple
BCyan='\e[1;36m'             # Cyan
BWhite='\e[1;37m'            # White

BBlack_='\[\e[1;30m\]'       # Black
BRed_='\[\e[1;31m\]'         # Red
BGreen_='\[\e[1;32m\]'       # Green
BYellow_='\[\e[1;33m\]'      # Yellow
BBlue_='\[\e[1;34m\]'        # Blue
BPurple_='\[\e[1;35m\]'      # Purple
BCyan_='\[\e[1;36m\]'        # Cyan
BWhite_='\[\e[1;37m\]'       # White

# Underline
UBlack='\e[4;30m'            # Black
URed='\e[4;31m'              # Red
UGreen='\e[4;32m'            # Green
UYellow='\e[4;33m'           # Yellow
UBlue='\e[4;34m'             # Blue
UPurple='\e[4;35m'           # Purple
UCyan='\e[4;36m'             # Cyan
UWhite='\e[4;37m'            # White

UBlack_='\[\e[4;30m\]'       # Black
URed_='\[\e[4;31m\]'         # Red
UGreen_='\[\e[4;32m\]'       # Green
UYellow_='\[\e[4;33m\]'      # Yellow
UBlue_='\[\e[4;34m\]'        # Blue
UPurple_='\[\e[4;35m\]'      # Purple
UCyan_='\[\e[4;36m\]'        # Cyan
UWhite_='\[\e[4;37m\]'       # White

# Background
On_Black='\e[40m'            # Black
On_Red='\e[41m'              # Red
On_Green='\e[42m'            # Green
On_Yellow='\e[43m'           # Yellow
On_Blue='\e[44m'             # Blue
On_Purple='\e[45m'           # Purple
On_Cyan='\e[46m'             # Cyan
On_White='\e[47m'            # White

On_Black_='\[\e[40m\]'       # Black
On_Red_='\[\e[41m\]'         # Red
On_Green_='\[\e[42m\]'       # Green
On_Yellow_='\[\e[43m\]'      # Yellow
On_Blue_='\[\e[44m\]'        # Blue
On_Purple_='\[\e[45m\]'      # Purple
On_Cyan_='\[\e[46m\]'        # Cyan
On_White_='\[\e[47m\]'       # White

# High Intensty
IBlack='\e[0;90m'            # Black
IRed='\e[0;91m'              # Red
IGreen='\e[0;92m'            # Green
IYellow='\e[0;93m'           # Yellow
IBlue='\e[0;94m'             # Blue
IPurple='\e[0;95m'           # Purple
ICyan='\e[0;96m'             # Cyan
IWhite='\e[0;97m'            # White

IBlack_='\[\e[0;90m\]'       # Black
IRed_='\[\e[0;91m\]'         # Red
IGreen_='\[\e[0;92m\]'       # Green
IYellow_='\[\e[0;93m\]'      # Yellow
IBlue_='\[\e[0;94m\]'        # Blue
IPurple_='\[\e[0;95m\]'      # Purple
ICyan_='\[\e[0;96m\]'        # Cyan
IWhite_='\[\e[0;97m\]'       # White

# Bold High Intensty
BIBlack='\e[1;90m'           # Black
BIRed='\e[1;91m'             # Red
BIGreen='\e[1;92m'           # Green
BIYellow='\e[1;93m'          # Yellow
BIBlue='\e[1;94m'            # Blue
BIPurple='\e[1;95m'          # Purple
BICyan='\e[1;96m'            # Cyan
BIWhite='\e[1;97m'           # White

BIBlack_='\[\e[1;90m\]'      # Black
BIRed_='\[\e[1;91m\]'        # Red
BIGreen_='\[\e[1;92m\]'      # Green
BIYellow_='\[\e[1;93m\]'     # Yellow
BIBlue_='\[\e[1;94m\]'       # Blue
BIPurple_='\[\e[1;95m\]'     # Purple
BICyan_='\[\e[1;96m\]'       # Cyan
BIWhite_='\[\e[1;97m\]'      # White

# High Intensty backgrounds
On_IBlack='\e[0;100m'        # Black
On_IRed='\e[0;101m'          # Red
On_IGreen='\e[0;102m'        # Green
On_IYellow='\e[0;103m'       # Yellow
On_IBlue='\e[0;104m'         # Blue
On_IPurple='\e[10;95m'       # Purple
On_ICyan='\e[0;106m'         # Cyan
On_IWhite='\e[0;107m'        # White

On_IBlack_='\[\e[0;100m\]'   # Black
On_IRed_='\[\e[0;101m\]'     # Red
On_IGreen_='\[\e[0;102m\]'   # Green
On_IYellow_='\[\e[0;103m\]'  # Yellow
On_IBlue_='\[\e[0;104m\]'    # Blue
On_IPurple_='\[\e[10;95m\]'  # Purple
On_ICyan_='\[\e[0;106m\]'    # Cyan
On_IWhite_='\[\e[0;107m\]'   # White
#===============================================================================
#  Custom prompt(s)
#  Two options are available:
#   1) The terminal width prompt
#      - Two lines the first line has the pwd truncated if over 30 chars
#        a fill line that pads to the width of the terminal a face that indicates
#        the status of the last return code yellow smile for 0 exit code and a
#        red frown for an error exit code, and the time the prompt was created
#        the second line has the history number of the command.
#   2) The minimal prompt:
#      - One line with the pwd truncated if over 30 chars
# ---------- Options for Reference ---------------------------------------------
#Bash supports the following special characters in the prompt
#
#       Bash allows these prompt strings to be customized by inserting a number of backslash-escaped
#       special characters that are decoded as follows:
#              \a     an ASCII bell character (07)
#              \d     the date in "Weekday Month Date" format (e.g., "Tue May 26")
#              \D{format}
#                     the format is passed to strftime(3) and the result is inserted into the prompt
#                     string; an empty format results in a locale-specific time representation.  The
#                     braces are required
#              \e     an ASCII escape character (033)
#              \h     the hostname up to the first ‘.’
#              \H     the hostname
#              \j     the number of jobs currently managed by the shell
#              \l     the basename of the shell’s terminal device name
#              \n     newline
#              \r     carriage return
#              \s     the  name  of  the  shell, the basename of $0 (the portion following the final
#                     slash)
#              \t     the current time in 24-hour HH:MM:SS format
#              \T     the current time in 12-hour HH:MM:SS format
#              \@     the current time in 12-hour am/pm format
#              \A     the current time in 24-hour HH:MM format
#              \u     the username of the current user
#              \v     the version of bash (e.g., 2.00)
#              \V     the release of bash, version + patch level (e.g., 2.00.0)
#              \w    the current working directory, with $HOME abbreviated with a tilde
#              \W    the basename of the current working directory, with $HOME abbreviated  with  a
#                     tilde
#              \!     the history number of this command
#              \#     the command number of this command
#              \$     if the effective UID is 0, a #, otherwise a $
#              \nnn   the character corresponding to the octal number nnn
#              \\     a backslash
#              \[     begin  a  sequence  of non-printing characters, which could be used to embed a
#                     terminal control sequence into the prompt
#              \]     end a sequence of non-printing characters
#===============================================================================

#===  FUNCTION  ================================================================
#          NAME:  wide_prompt
#   DESCRIPTION:  Creates a truncated pwd if the pwd has a length greater than
#                 the amount of chars defined by max_pwd, and a fill_chars
#                 variable that is used to pad the prompt to the width of 
#                 the terminal
#       RETURNS:  Returns nothing but creates updated 'newPWD', and 'fill_chars'
#                 variables that are used with the PROMPT_COMMAND 
#===============================================================================
function wide_prompt() {
    max_pwd=30                                                                                 # This max len of pwd that we want displayed
    if [ $(echo $(pwd) | sed -e "s_${HOME}_~_" | wc -c | tr -d " ") -gt $max_pwd ]             # If the pwd with $HOME replaced by a "~" and spaces removed is greater then max_pwd
    then
      newPWD="...$(echo $(pwd) | sed -e "s_${HOME}_~_" | sed -e "s/.*\(.\{$max_pwd\}\)/\1/")"  # Replace $HOME with "~" prepend with '...' and truncate the leading characters that make it longer than max_pwd
    else
      newPWD="$(echo $(pwd) | sed -e "s_${HOME}_~_")"                                          # Else replace $HOME with a '~' to use as pwd
    fi

    termwidth=${COLUMNS}                                                                       # The width of the terminal window
    default_info_width="$((22 + ${#newPWD}))"                                                  # This is the length of the text that needs to appear on the line 
    fill="──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────"
    needed_fillsize=$(($termwidth - $default_info_width))                                      # The width of the screen less the text to appear gives amount of spaces we need to fill
    fill_chars="${fill:0:${needed_fillsize}}"                                                  # The actual characters that are needed to fill the line
    git_status=$(echo $(__git_ps1) | cut -d "(" -f 2 | cut -d ")" -f 1)                        # The bit status cuts off the leading space and the brackets
}

# PROMPT_COMMAND (see comments)
PROMPT_COMMAND=wide_prompt      # From the bash manual: "The value of the variable PROMPT_COMMAND is examined just before Bash
                                #  prints each primary prompt. If PROMPT_COMMAND is set and has a non-null value, then the value 
								#  is executed just as if it had been typed on the command line." This allows us to use the variables
								#  created in wide_prompt each time the prompt is redrawn

# Set the prompt formatting, a yellow happy face retuned on commands with a 0 exit code and red frown retuned with an error exit code
PS1="$BGreen_┌─($BWhite_\$newPWD$BGreen_)\$fill_chars(\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]O_O\[\e[0m\]; fi\`$BGreen_)───($BWhite_\@$BGreen_)\n$BGreen└──($BWhite_\$git_status$BGreen_)-> $Color_Off_"
#            ^formating  ^the newPWD      ^the filler ^the smile if then test------------------------------------------------------------------^         ^formatting ^time      ^new line^formatting ^^git info  ^formatting

#-------------------------------------------------------------------------------
#  A minimal prompt that displays the pwd truncated over 30 chars
#  Remove the double comment (##'s) to activate
#-------------------------------------------------------------------------------
#===  FUNCTION  ================================================================
#          NAME:  trunc_pwd
#   DESCRIPTION:  Creates a truncated pwd if the pwd has a length greater than
#                 the amount of chars defined by max_pwd
#       RETURNS:  Returns nothing but creates an updated 'newPWD' variable that 
#                 is used with the PROMPT_COMMAND to create a custom prompt
#===============================================================================
##function trunc_pwd() 
##{
##max_pwd=30                                                                                     # This max len of pwd that we want displayed
##if [ $(echo $(pwd) | sed -e "s_${HOME}_~_" | wc -c | tr -d " ") -gt $max_pwd ]                 # If the pwd with $HOME replaced by a "~" and spaces removed is greater then max_pwd
##then
##	newPWD="...$(echo $(pwd) | sed -e "s_${HOME}_~_" | sed -e "s/.*\(.\{$max_pwd\}\)/\1/")"  # replace $HOME with "~" prepend with '...' and truncate the leading characters that make it longer than max_pwd
##else
##  newPWD="$(echo $(pwd) | sed -e "s_${HOME}_~_")"                                              # Else replace $HOME with a '~' to use as pwd
##fi
##}
#PROMPT_COMMAND=truncpwd
##PS1="$BPurple($BWhite\$newPWD$BPurple)\$ $Color_Off" # Very minimal but a resonable prompt

    
#===============================================================================
# Settings
#===============================================================================
#-------------------------------------------------------------------------------
#  Don't put duplicate lines in the history
#-------------------------------------------------------------------------------
export HISTCONTROL=ignoredups

#-------------------------------------------------------------------------------
#  Update the values of LINES and COLUMNS
#-------------------------------------------------------------------------------
shopt -s checkwinsize

#-------------------------------------------------------------------------------
#  Do not over write files
#-------------------------------------------------------------------------------
set -o noclobber 

#-------------------------------------------------------------------------------
#  Set Vi as the default editor
#-------------------------------------------------------------------------------
export EDITOR=vim

#-------------------------------------------------------------------------------
# Automatically do an ls after each cd
#-------------------------------------------------------------------------------
cd() { 
  if [ -n "$1" ]; then
      builtin cd "$@" && ls --group-directories-first
  else
      builtin cd ~ && ls --group-directories-first
  fi
}

#-------------------------------------------------------------------------------
# Git auto completion from the command line
#-------------------------------------------------------------------------------
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

#===============================================================================
#  Aliases
#===============================================================================
alias bye='sudo shutdown -h now'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias upgrade='sudo apt-get upgrade'
alias clean='sudo apt-get autoclean && sudo apt-get autoremove'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ls='ls --color'
alias long_command=fc            # Opens a vim and let's you work on long commands. Just to help remember fc
# Empty the trash folder that is created when you delete things as root
alias root_trash='sudo bash -c "exec rm -r /root/.local/share/Trash/{files,info}/*"'
#===============================================================================
# FUNCTIONS
#===============================================================================

#-------------------------------------------------------------------------------
#  Prints out my alias commands and functions
#-------------------------------------------------------------------------------
function custom()
    {
	echo "###########--ALIAS--############"
	echo "         bye <<-- Shut down the computer"
	echo "      update <<-- sudo apt-get update && sudo apt-get upgrade"
	echo "     upgrade <<-- sudo apt-get upgrade"
	echo "       clean <<-- sudo apt-get autoclean && sudo apt-get autoremove"
	echo "long_command <<-- Opens a vim and let's you work on long commands. Just to help remember fc"
	echo "  root_trash <<-- Empty the trash folder that is created when you delete things as root"
	echo ""
	echo "###########--FUNCTIONS--############"
	echo " webshare <<-- cd into a directory you want to share and run command"
	echo "workTimer <<-- A timer to allow focusing on the task at hand"
	echo "mem_usage <<-- Shows the specified number of the top memory consuming processes"
        echo "banner    <<-- Prints a banner containing the public / eth0 ip address and misc information"
	}

#-------------------------------------------------------------------------------
#  Python webserver: cd into a directory you want to share and then 
#                    type webshare. You will be able to connect to that directory
#                    with other machines on the local net work with IP:8000
#                    the function will display the current machines ip address
#                    need to have a host name of either lapForceOne or skynet
#-------------------------------------------------------------------------------
function webshare()
    {
	if [[ "`hostname`" = "lapForceOne" ]]; then
		local_ip=`ifconfig eth1 | awk '/inet addr/ {split ($2,A,":"); print A[2]}'`
	elif [[ "`hostname`" = "Skynet" ]]; then
		local_ip=`ifconfig eth0 | awk '/inet addr/ {split ($2,A,":"); print A[2]}'`
	fi
    echo "connect to $local_ip:8000"
		python -m SimpleHTTPServer
	  }

#-------------------------------------------------------------------------------
# A timer function that will say the message and display a pop-up
# after the specified amount of time. 
# REQUIRES: Need to have espeak installed. 
#-------------------------------------------------------------------------------
function workTimer()
{ 
	#echo -n "Timer name => "; read name ##<-- We don't really need a name for the timer
	echo -n "How long to set timer for? (ex. 1h, 10m, 20s, etc) => "; read duration
	echo -n "What to say when done => "; read say
	sleep $duration && espeak "$say" && zenity --info --title="$name" --text="$say"
}

#-------------------------------------------------------------------------------
# Shows the specified number of the top memory consuming processes and their PID
#-------------------------------------------------------------------------------
function mem_usage()
	{
	echo -n "How many you what to see? "; read number
	echo ""
	echo "Mem Size       PID     Process"
	echo "============================================================================="
	ps aux | awk '{ output = sprintf("%5d Mb --> %5s --> %s%s%s%s", $6/1024, $2, $11, $12, $13, $14); print output }' | sort -gr | head --line $number
	}


#------------------------------------------------------------------------------
#  Prints a banner with public / private ip addresses, kernel 
#  Information and uptime also shows three months of calendar.
#  REQUIREMENTS: figle: for the banner, will need to apt-get on new install
#  NOTES: You will need to configure the hostname that it looks for unless you
#         happen to by chance call your machine lapForceOne or skynet
#-------------------------------------------------------------------------------
function banner()
{
echo -e "${BYellow}";figlet " #winning!";
echo -ne "${BRed}public ip address:\t${BBlue}" `wget -qO- ip.nu |grep IP | cut -d " " -f 5`; echo ""
if [[ "`hostname`" = "lapForceOne" ]]; then
	echo -ne "${BRed}eth1 IP Address:\t${BBlue}" `ifconfig wlan0 | awk '/inet addr/ {split ($2,A,":"); print A[2]}'`; echo ""
elif [[ "`hostname`" = "skynet" ]]; then
	echo -ne "${BRed}eth0 IP Address:\t${BBlue}" `ifconfig eth0 | awk '/inet addr/ {split ($2,A,":"); print A[2]}'`; echo ""
fi
echo -e "${BRed}Kernel Information: \t${BBlue}" `uname -smr`
if [[ "`hostname`" = "lapForceOne" ]]; then
	echo -ne "${BGreen}$HOSTNAME ${BRed}uptime is ${BBlue}   ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
elif [[ "`hostname`" = "skynet" ]]; then
	echo -ne "${BGreen}$HOSTNAME ${BRed}uptime is ${BBlue}        ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
fi
echo -e "${BWhite}"; cal -3
}
