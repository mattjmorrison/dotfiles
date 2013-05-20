#!/bin/bash - 
#===============================================================================
#
#              FILE: config_linux_environment.sh
#     
#             USAGE: ./config_linux_environment.sh 
#     
#       DESCRIPTION: Script installs all the packages that I use on the regular 
#                    and creates symlinks in the users home folder to all of the 
#                    dot files that we specify in the files variable found below.
#     
#             NOTES: For this to work you must have cloned the github repo to your 
#                    home folder as ~/dotfiles/ 
#
#            AUTHOR: Jarrod Taylor
#
# MAINTENANCE NOTES: To add additional files/folders to be symlinked all that is 
#                    needed is to include their names in the files variable.
#===============================================================================

#==============
# Variables
#==============
dir=~/dotfiles           # Dotfiles directory
files="bashrc vimrc vim emacs.d" # List of files / folders to symlink in home folder

#==============
# Change to the dotfiles directory
#==============
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

#==============
# Create symlinks in the home folder to any files in the ~/dotfiles folder 
# that we specified in $files variable.
#==============
for file in $files; do
    echo "Creating symlink to $file in $HOME"
    ln -s $dir/$file ~/.$file
done

#==============
# Clone vundle so we can update vim plugins when we open it 
# the first time
#==============
echo "Cloning vundle to manage vim plugins"
git clone https://github.com/gmarik/vundle.git ~/dotfiles/vim/bundle/vundle

#==============
# Ask if user wants to install all the required and additional packages
#==============
echo "Would you like to install all additional packages for this setup (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    echo "Installing Vim"
    sudo apt-get install vim-gnome
    echo "Installing Emacs"
    sudo apt-get install emacs24
    echo "Installing Keepassx"
    sudo apt-get install keepassx
    echo "Installing figlet"
    sudo apt-get install figlet
    echo "Installing espeak"
    sudo apt-get install espeak
    echo "Installing curl"
    sudo apt-get install curl
    echo "Installing exuberant-ctags..."
    sudo apt-get install exuberant-ctags
    echo "Downloading and installing git-completion"
    cd ~/
    curl -OL https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
    mv ~/git-completion.bash ~/.git-completion.bash
    echo "Installing nodejs, npm and jshint for js error checking in vim"
    # Currently I am only concerned about getting jshint working. It should
    # be noted that the Debian version fo nodejs is very out of date
    # so if node development is of interest it would be better to build 
    # from source
    sudo apt-get install nodejs
    sudo apt-get install npm
    sudo npm install -g jshint
    # jshint will look for node and it seems to be installed as
    # nodejs if that is the case we create a symlink
    if [ ! -f /usr/bin/node ]; then 
        ln -s /usr/bin/nodejs /usr/bin/node
    fi
    echo "Installing pyflakes for python error checking in vim"
    sudo apt-get install pyflakes
fi

#==============
# Wrap it up with warm fuzzies
#==============
echo "====== Finished ======"
echo "When you first open vim run :BundleInstall to install the plugins"
echo "All done enjoy"
