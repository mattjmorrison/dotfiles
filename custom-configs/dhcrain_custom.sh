# Aliases <<1
#-------------------------------------------------------------------------------
alias la='ls -lah'
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias c='clear'
alias cat='bat'
alias speedtest='speedtest-cli --simple'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias ip-public='curl ipinfo.io/ip'
alias ip-local="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias gUncommit='git reset HEAD~1 --soft' # Uncommit last unpushed commit

# >>1

export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home

# Do not run brew update when installing with brew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
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
function ff() {
	find . -type f -iname '*'"$*"'*' -ls ;
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
	if [[ $1 ]]; then
		preFix="$1/"
	fi
	noSpace=`pbpaste | tr -s " \n" "-"`
	echo $preFix$noSpace | pbcopy
}

# https://gist.github.com/npx/3a8688e114df6b3157c6e1bc5bdfd1f0
function git-watch() {
  watch -ct -n1 git --no-pager log --color --all --oneline --decorate --graph
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
	IFS=$'\n' originDeleted=($(git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}'))
	IFS=$'\n' notPushed=($(git branch -vv | grep -v origin | awk '{print $1}'))
	branches=("${originDeleted[@]}" "${notPushed[@]}")
	branchCount="${#branches[@]}"

	echo "* Branches that do not exist on origin:"
	for (( i=1; i<=$branchCount; i++ )) do
		echo " [$i]" "${branches[$i]}"
	done

	echo "* Which Branch to delete? (1-$branchCount). \
		  \n  * Enter more than one branch with spaces between numbers (ex. 1 2 3) \
		  \n  * Delete All (All)  \
		  \n  * Anything else will exit without touching repo  "; read confirm

	if [[ "${confirm//[A-Za-z]/}" = "" ]]; then
		if [[ $confirm == [aA][lL][lL] ]]; then
			echo "!! Deleting all local branches that do not exist on origin !!\
			 \n * Are you sure? [y/n] "; read yesNo
			if [[ $yesNo == [Yy] ]]; then
				echo "Burn with Fire"
				echo $branches | xargs git branch -D
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
	sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache
}

# Workon node env <<2
#--------------------------------------------------------------------
# If we cd into a directory that contains a directory named node_modules
# we automatically add it to the $PATH
# -------------------------------------------------------------------
workon_node_env() {
	if [[ -d "node_modules" ]]; then

		export NPM_ORIGINAL_PATH=$PATH
		eval NODE_NAME=$(basename $(pwd))
		export PATH="${PATH}:$(pwd)/node_modules/.bin"

		deactivatenode(){
			export PATH=$NPM_ORIGINAL_PATH
			unset -f deactivatenode
			unset NODE_NAME
		}
	fi
}
 # >>2
 # Run the virtual environments functions for the prompt on each cd <<2
 # -------------------------------------------------------------------
 cd() {
   builtin cd "$@"
   unset NODE_NAME
   workon_virtualenv
   workon_node_env
 }
 # >>2

# # Run the virtual environments functions for the prompt on each cd <<2
# # -------------------------------------------------------------------
# cd() {
#   builtin cd "$@"
#   workon_virtualenv
# }
# # >>2

make-git-remote() {
	repoName="$1.git"
	path=~/git/$repoName
	mkdir -p $path
	cd $path
	git init --bare

	localIp=ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
	user=`whoami`

	echo "Run on remote: git remote add $repoName $user@$localIp:$path"
}

# Stop running a process running on a particular port
stop() {
	port=$1
	pid=$(lsof -ti tcp:$port)
	if [[ $pid ]]; then
		kill -9 $pid
		echo "Congrates!! $port is stopped."
	else
		echo "Sorry nothing running on above port"
	fi
}

# https://til.hashrocket.com/posts/sfyie5lqwd-rename-iterm-tab-with-a-shell-function
# Rename the current iTerm tab
function renametab () {
    echo -ne "\033]0;"$@"\007"
}

# Jump to section in man page
# press N to go to the next instance of search term
function searchman () {
    man $1 | less +/$2
}

fpath+=~/.zfunc
