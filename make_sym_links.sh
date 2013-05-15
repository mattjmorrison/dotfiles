#!/bin/bash - 
#===============================================================================
#
#              FILE: make_sym_links.sh
#     
#             USAGE: ./make_sym_links.sh 
#     
#       DESCRIPTION: Script creates symlinks in the users home folder to all of the 
#                    dot files that we specify in the files variable found below
#     
#             NOTES: For this to work you must have cloned the github repo to your 
#                    home folder as ~/dotfiles/ 
#
#            AUTHOR: Jarrod Taylor
#
#           CREATED: 05/14/2013 07:49:06 AM CDT
#
#          REVISION: v0.1
#
# MAINTENANCE NOTES: To add additional files/folders to be symlinked all that is 
#                    needed is to include their names in the files variable.
#===============================================================================

#==============
# Variables
#==============
dir=~/dotfiles           # Dotfiles directory
files="bashrc vimrc vim" # List of files / folders to symlink in home folder

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
# Ask if user wants to install required packages
#==============
echo "We need a few packages for some of the plugins to work"
echo "Would you like to have then auto installed (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    echo "Installing exuberant-ctags..."
    sudo apt-get install exuberant-ctags
fi

#==============
# Wrap it up with warm fuzzies
#==============
echo "====== Finished ======"
echo "When you first open vim run :BundleInstall to install the plugins"
echo "All done enjoy"
