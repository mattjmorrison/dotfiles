# Reset Colors
Color_Off='\e[0m'            # Text Reset
Color_Off_='\[\e[0m\]'       # Text Reset

BPurple='\e[1;35m'           # Purple
BWhite='\e[1;37m'            # White

#===  FUNCTION  ================================================================
#          NAME:  trunc_pwd
#   DESCRIPTION:  Creates a truncated pwd if the pwd has a length greater than
#                 the amount of chars defined by max_pwd
#       RETURNS:  Returns nothing but creates an updated 'newPWD' variable that
#                 is used with the PROMPT_COMMAND to create a custom prompt
#===============================================================================
function trunc_pwd()
{
max_pwd=30
if [ $(echo $(pwd) | sed -e "s_${HOME}_~_" | wc -c | tr -d " ") -gt $max_pwd ]
then
  newPWD="...$(echo $(pwd) | sed -e "s_${HOME}_~_" | sed -e "s/.*\(.\{$max_pwd\}\)/\1/")"
else
  newPWD="$(echo $(pwd) | sed -e "s_${HOME}_~_")"
fi
}
PROMPT_COMMAND=trunc_pwd
PS1="$BPurple($BWhite\$newPWD$BPurple)\$ $Color_Off"

#===============================================================================
# Settings
#===============================================================================
export HISTCONTROL=ignoredups
shopt -s checkwinsize
set -o noclobber
export EDITOR=vim

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
# Empty the trash folder that is created when you delete things as root
alias root_trash='sudo bash -c "exec rm -r /root/.local/share/Trash/{files,info}/*"'
export PATH='/usr/local/bin:/Users/poginni/.pyenv/shims:~/.pyenv/shims:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/opt/X11/bin:/Users/poginni/.rvm/bin'

