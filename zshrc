#!/bin/zsh
#===============================================================================
#
#          FILE:  .zshrc
# 
#   DESCRIPTION: Configure zsh in a pleasing manner
# 
#        AUTHOR: Jarrod Taylor
#       CREATED: 06/21/2013
#===============================================================================

#-------------------------------------------------------------------------------
# Autoload colors and tab completion
#-------------------------------------------------------------------------------
autoload -U colors && colors
autoload -U compinit
compinit -C

#-------------------------------------------------------------------------------
# Local array variable
#-------------------------------------------------------------------------------
local -a precmd_functions

#-------------------------------------------------------------------------------
# Set the desired setup options man zshoptions
#-------------------------------------------------------------------------------
# If command can't be executed, and command is name of a directory, cd to directory
setopt  auto_cd                 
# Make cd push the old directory onto the directory stack. 
setopt  auto_pushd              
setopt  noclobber               
# Prevents aliases on the command line from being internally substituted before 
# completion is attempted. The effect is to make the alias a distinct command 
# for completion purposes.
setopt  complete_aliases        
# Treat the #, ~ and ^ characters as part of patterns for filename 
# generation, etc.  (An initial unquoted `~' always produces named directory 
# expansion.)
setopt  extended_glob           
# If a new command line being added to the history list duplicates an older one, 
# the older command is removed from the list (even if it is not the pre‐ vious event). 
setopt  hist_ignore_all_dups    
#  Remove command lines from the history list when the first character on the line 
#  is a space, or when one of the expanded aliases contains a leading space.
setopt  hist_ignore_space       
# Do not exit on end-of-file. Require the use of exit or logout instead.
setopt  ignore_eof              
# This  option  both  imports new commands from the history file, and also 
# causes your typed commands to be appended to the history file
setopt  share_history           
setopt  noflowcontrol           
# When listing files that are possible completions, show the type of each file 
# with a trailing identifying mark.
setopt  list_types              
# Append a trailing / to all directory names resulting from filename 
# generation (globbing).
setopt  mark_dirs               
# Perform a path search even on command names with slashes in them.  
# Thus if /usr/local/bin is in the user's path, and he or she types 
# X11/xinit, the  command /usr/local/bin/X11/xinit will be executed 
# (assuming it exists).
setopt  path_dirs               
# If set, `%' is treated specially in prompt expansion.
setopt  prompt_percent          
# If set, parameter expansion, command substitution and arithmetic 
# expansion are performed in prompts.  
# Substitutions within prompts do not affect the command status.
setopt  prompt_subst            

#-------------------------------------------------------------------------------
# History settings
#-------------------------------------------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTFILESIZE=65536  # search this with `grep | sort -u`
HISTSIZE=4096
SAVEHIST=4096
REPORTTIME=60       # Report time statistics for progs that take more than a minute to run

#-------------------------------------------------------------------------------
# utf-8 in the terminal, will break stuff if your term isn't utf aware
#-------------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_COLLATE=C

#-------------------------------------------------------------------------------
# Set grepoptions
#-------------------------------------------------------------------------------
export GREP_OPTIONS='--color=auto'

#-------------------------------------------------------------------------------
# Editor and display configurations
#-------------------------------------------------------------------------------
export EDITOR='vim'
export VISUAL='vim'
export GIT_EDITOR=$EDITOR
export LESS='-imJMWR'
export PAGER="less $LESS"
export MANPAGER=$PAGER
export GIT_PAGER=$PAGER
export BROWSER='chromium-browser'

#-------------------------------------------------------------------------------
# Silence Wine debugging output
#-------------------------------------------------------------------------------
export WINEDEBUG=-all

#-------------------------------------------------------------------------------
# Specify virtualenv directories
#-------------------------------------------------------------------------------
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/VirtualDevEnvs
source /usr/local/bin/virtualenvwrapper.sh

#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle -e ':completion:*:(ssh|scp|sshfs|ping|telnet|nc|rsync):*' hosts '
    reply=( ${=${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**} )'

#-------------------------------------------------------------------------------
# Set vi-mode and create a few additional Vim-like mappings
#-------------------------------------------------------------------------------
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^R' history-incremental-pattern-search-backward

#-------------------------------------------------------------------------------
# Set up prompt
#-------------------------------------------------------------------------------
if [[ ! -n "$ZSHRUN" ]]; then
    source $HOME/.zsh_prompt

    # Fish shell like syntax highlighting for Zsh:
    # git clone git://github.com/nicoulaj/zsh-syntax-highlighting.git \
    #   $HOME/.zsh-syntax-highlighting/
    if [[ -f $HOME/zsh-syntax-highlighting.zsh ]]; then
        source $HOME/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS+=( brackets pattern cursor )
    else
        echo "No highlighting Son!!"
    fi
fi

#-------------------------------------------------------------------------------
# Automatically do an ls after each cd
#-------------------------------------------------------------------------------
# function chpwd() {
#     emulate -L zsh
#     ls --group-directories-first --color
# }

#===============================================================================
#  Aliases
#===============================================================================
alias ls='ls -F --color'
alias ll='ls -lh'
alias la='ls -la'
alias lls='ll -Sr'
alias less='less -imJMW'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias upgrade='sudo apt-get upgrade'
alias clean='sudo apt-get autoclean && sudo apt-get autoremove'
alias root_trash='sudo bash -c "exec rm -r /root/.local/share/Trash/{files,info}/*"'
alias tmux="TERM=screen-256color-bce tmux"  # Fix tmux making vim colors funky
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited

#===============================================================================
# FUNCTIONS
#===============================================================================


#-------------------------------------------------------------------------------
#  Python webserver: cd into a directory you want to share and then 
#                    type webshare. You will be able to connect to that directory
#                    with other machines on the local net work with IP:8000
#                    the function will display the current machines ip address
#-------------------------------------------------------------------------------
function webshare() {
    local_ip=`hostname -I | cut -d " " -f 1`
    echo "connect to $local_ip:8000"
		python -m SimpleHTTPServer > /dev/null 2>&1
    }

#-------------------------------------------------------------------------------
# A timer function that will say the message and display a pop-up
# after the specified amount of time. 
# REQUIRES: Need to have espeak installed. 
#-------------------------------------------------------------------------------
function workTimer() { 
	#echo -n "Timer name => "; read name ##<-- We don't really need a name for the timer
	echo -n "How long to set timer for? (ex. 1h, 10m, 20s, etc) => "; read duration
	echo -n "What to say when done => "; read say
	sleep $duration && espeak "$say" && zenity --info --title="$name" --text="$say"
}

#-------------------------------------------------------------------------------
# Shows the specified number of the top memory consuming processes and their PID
#-------------------------------------------------------------------------------
function mem_usage() {
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
#-------------------------------------------------------------------------------
function banner() {
echo -e  $fg[yellow];figlet " #winning!";
echo -ne $fg[red]"Public IP address:\t" $fg[blue]`wget -qO- ip.nu |grep IP | cut -d " " -f 5`; echo ""
echo -ne $fg[red]"Primary local IP:\t" $fg[blue]`hostname -I | cut -d " " -f 1`; echo ""
echo -e  $fg[red]"Kernel Information: \t" $fg[blue]`uname -smr`
echo -ne $fg[green]"$HOST $fg[red]uptime is: \t "$fg[blue];uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
echo -e  $fg[white];cal -3
}

#------------------------------------------------------------------------------
# Because, well I need to spell check a lot :\
#------------------------------------------------------------------------------
spell (){
    echo $1 | aspell -a
}

#------------------------------------------------------------------------------
# Auto activate virtualenv's when we cd into a directory that has one
# This kind of works but I am not sure of its value
#------------------------------------------------------------------------------
# virtualenv_auto_activate() {
#       if [ -e ".venv" ]; then
#           # Check to see if already activated to avoid redundant activating
#           if [ "$VIRTUAL_ENV" = "" ]; then
#               _VENV_NAME=$(basename `pwd`)
#               echo Activating virtualenv \"$_VENV_NAME\"...
#               VIRTUAL_ENV_DISABLE_PROMPT=1
#               source .venv/bin/activate
#            fi
#      else
#        if [ "$VIRTUAL_ENV" != "" ]; then
#          echo deactivating VirtualEnv
#          deactivate
#        fi
#      fi
#    }

# venv_cd () {
#     cd "$@" && virtualenv_auto_activate
# }
# alias cd="venv_cd"

#------------------------------------------------------------------------------
# Run precmd functions so we get our pimped out prompt
#------------------------------------------------------------------------------
precmd_functions=( precmd_prompt )
banner
# EOF
