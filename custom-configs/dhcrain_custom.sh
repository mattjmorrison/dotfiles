# Aliases <<1
#-------------------------------------------------------------------------------
alias la='ls -lah'
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias ts='tig status'
alias c='clear'
alias cat='bat'
alias speedtest='speedtest-cli --simple'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias ip-public='curl ipinfo.io/ip'
alias ip-local="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# >>1

# ssh-add -K ~/.ssh/ted_db &> /dev/null
# ssd-add -A &> /dev/null


export JAVA_HOME=$(/usr/libexec/java_home)
export GROOVY_HOME=/usr/local/opt/groovy/libexec


# Functions <<1
#===============================================================================

# Python webserver <<2
#-------------------------------------------------------------------------------
#  cd into a directory you want to share and then
#  type pyserve. You will be able to connect to that directory
#  with other machines on the local net work with IP:8000
#  the function will display the current machines ip address
#-------------------------------------------------------------------------------
function pyserve() {
	if [ "$(uname)" = "Darwin" ]; then
		local_ip=`ifconfig | grep 192 | cut -d ' ' -f 2`
	else
		local_ip=`hostname -I | cut -d " " -f 1`
	fi
	echo "connect to $local_ip:8000"
		python -m SimpleHTTPServer > /dev/null 2>&1
	}
# >>2

# Memory Usage <<2
#-------------------------------------------------------------------------------
# Shows the specified number of the top memory consuming processes and their PID
#-------------------------------------------------------------------------------
function mem_usage() {
	echo -n "How many you what to see? "; read number
	echo ""
	echo "Mem Size       PID     Process"
	echo "============================================================================="
	if [ "$(uname)" = "Darwin" ]; then
		ps aux | awk '{ output = sprintf("%5d Mb --> %5s --> %s%s%s%s", $6/1024, $2, $11, $12, $13, $14); print output }' | sort -gr | head -n $number
	else
		ps aux | awk '{ output = sprintf("%5d Mb --> %5s --> %s%s%s%s", $6/1024, $2, $11, $12, $13, $14); print output }' | sort -gr | head --line $number
	fi
	}
# >>2
# Spell Check <<2
#------------------------------------------------------------------------------
# Because, well I need to spell check a lot :\
#------------------------------------------------------------------------------
spell (){
	echo $1 | aspell -a
}
# >>2
# Search for running processes <<2
# -------------------------------------------------------------------
any() {
	emulate -L zsh
	unsetopt KSH_ARRAYS
	if [[ -z "$1" ]] ; then
		echo "any - grep for process(es) by keyword" >&2
		echo "Usage: any " >&2 ; return 1
	else
		if [ "$(uname)" = "Darwin" ]; then
			echo "USER            PID     %CPU %MEM VSZ       RSS  TTY   STAT START     TIME    COMMAND"
		else
			echo "USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
		fi
		ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
	fi
}
# >>2
# Display a neatly formatted path <<2
# -------------------------------------------------------------------
path() {
echo $PATH | tr ":" "\n" | \
	awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
		   sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
		   sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
		   sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
		   sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
		   print }"
  }
# >>2
# Displays mounted drive information in a nicely formatted manner <<2
# -------------------------------------------------------------------
function nicemount() {
	(echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ;
}
# >>2
# Source file if it exists <<2
#--------------------------------------------------------------------
include() {
	[[ -s "$1" ]] && source "$1"
}
# >>2

# Find a file with a pattern in name: <<2
#--------------------------------------------------------------------
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }
# >>2

# Get info about an ip or url <<2
#--------------------------------------------------------------------
# Usage:
# ipinfo -i 199.59.150.7
# ipinfo -u github.com
#--------------------------------------------------------------------
ipinfo() {
	if [ $# -lt 2 ]; then
	  echo "Usage: `basename $0` -i ipaddress" 1>&2
	  echo "Usage: `basename $0` -u url" 1>&2
	  return
	fi
	if [ "$1" = "-i" ]; then
		desiredIP=$2
	fi
	if [ "$1" = "-u" ]; then
		# Aleternate ways to get desired IP
		# desitedIP=$(host unix.stackexchange.com | awk '/has address/ { print $4 ; exit }')
		# desiredIP=$(nslookup google.com | awk '/^Address: / { print $2 ; exit }')
		desiredIP=$(dig +short $2)
	fi
	curl "freegeoip.net/json/$desiredIP" | python -m json.tool
}
# >>2

# Upwards directory traversal shortcut <<2
#--------------------------------------------------------------------
# Hitting `...` will produce `../..` an additional `/..` will be added
# for every `.` after that
# -------------------------------------------------------------------
traverse_up() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}
zle -N traverse_up
bindkey . traverse_up
# >>2
# >>1

# -------------------------------------------------------------------
# Retrieves the URL for the GitHub page of a project cloned from GitHub
# and opens it in the default browser.
# -------------------------------------------------------------------
github() {
	if [ ! -d .git ] ;
		then echo "ERROR: This isnt a git directory" && return false;
	fi

	git_url=`git config --get remote.origin.url`
	git_domain=`echo $git_url | awk -v FS="(@|:)" '{print $2}'`
	git_branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`

	if [[ $git_url == https://* ]];
	then
		url=${git_domain}/${git_url%.git}/tree/${git_branch}
	else
	   if [[ $git_url == git@* ]]
	   then
			url="https://${git_domain}/${${git_url#*:}%.git}/tree/${git_branch}"
			echo $url
	   else
		   echo "ERROR: Remote origin is invalid" && return false;
	   fi
	fi
	open $url
}


# Get the weather for given location <<2
weather() {
	curl wttr.in/$1
}


# make a directory and move into that directory
mkcdir () {
	mkdir -p -- "$1" && cd -P -- "$1"
}

# takes the clipboard contents, replaces spaces and new lines with '-', puts it back on the clipboard
# will add prefix 'feature/' by default, but can pass something differnt
branch-this () {
	if [[ -z $1 ]]; then
		preFix="feature/"
	else
		preFix="$1/"
	fi
	noSpace=`pbpaste | tr -s " \n" "-"`
	echo $preFix$noSpace | pbcopy
}

# Colored Man pages <<1
# https://www.tecmint.com/view-colored-man-pages-in-linux/
#-------------------------------------------------------------------------------
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
# >>1

# inspierd from http://erikaybar.name/git-deleting-old-local-branches/
clean-git() {

	IFS=$'\n' branches=($(git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}'))
	branchCount="${#branches[@]}"

	echo "* Branches that do not exist on origin:"
	for (( i=1; i<=$branchCount; i++ )) do
		echo " [$i]" "${branches[$i]}"
	done

	echo "* Which Branch to delete? (1-$branchCount). \
		  \n  * Enter more than one branch with spaces between numbers (ex. 1 2 3) \
		  \n  * Delete All (All)  "; read confirm

	if [[ "${confirm//[A-Za-z]/}" = "" ]]; then
		if [[ $confirm == [aA][lL][lL] ]]; then
			echo "!! Deleting all local branches that do not exist on origin !!\
			 \n * Are you sure? [y/n] "; read yesNo
			if [[ $yesNo == [Yy] ]]; then
				echo "Burn with Fire"
				echo $branches | xargs git branch -d
			else
				echo "Nothing Delted"
			fi
		else
		 echo "Local repo is untouched"
		fi
	else
		# Split string on spaces and in arr so can iterate over
		IFS=' ' read -A userIn <<< $confirm
		for i in ${userIn[@]}; do
			if [[ $i -ge 1 ]] && [[ $i -le $branchCount ]]; then # valid entry
				echo "Deleting ${branches[$i]}"
				echo ${branches[$i]} | xargs git branch -D
			else
				echo "Local repo is untouched"
			fi
		done
	fi
}


#  Uses tree - install first:
# brew install tree
function t() {
  # Defaults to 3 levels deep, do more with `t 5` or `t 1`
  # pass additional args after
  tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -aC $2
}

# move file or dir to trash
function trash() {
	mv "$1" ~/.Trash
}

function nuke-node-modules() {
	echo " > Deleteing node_modules and reinstalling"
	rm -rf node_modules && npm install
}

function dnsFlush() {
	sudo killall -HUP mDNSResponder
}