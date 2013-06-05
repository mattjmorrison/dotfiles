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
#                    Also deletes any existing links to these .dotfiles
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
dir=~/dotfiles                         # Dotfiles directory
files="bashrc vimrc vim emacs.d"       # List of files / folders to symlink in home folder
log_file=~/install_progress_log.txt    # Does what it says on the tin

#==============
# Delete existing dot files and folders
#==============
echo "Would you like to delete any existing dot files (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    sudo rm -r ~/.emacs.d > /dev/null 2>&1
    sudo rm -r ~/.vim > /dev/null 2>&1
    sudo rm  ~/.vimrc > /dev/null 2>&1
    sudo rm  ~/.bashrc > /dev/null 2>&1
fi

#==============
# Change to the dotfiles directory
#==============
echo -n "Changing to the $dir directory ..." >> $log_file
cd $dir

#==============
# Create symlinks in the home folder to any files in the ~/dotfiles folder 
# that we specified in $files variable.
#==============
for file in $files; do
    echo "Creating symlink to $file in $HOME" >> $log_file
    ln -s $dir/$file ~/.$file
done

#==============
# Clone vundle so we can update vim plugins when we open it 
# the first time
#==============
echo "Cloning vundle to manage vim plugins" >> $log_file
git clone https://github.com/gmarik/vundle.git ~/dotfiles/vim/bundle/vundle
echo "Vundle successfully cloned" >> $log_file

#==============
# Ask if user wants to install all the required and additional packages
#==============
echo "Would you like to install all additional packages for this setup (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    echo "Installing Vim" >> $log_file
    sudo apt-get install vim-gnome
    echo "Vim Installed" >> $log_file

    echo "Installing Emacs" >> $log_file
    sudo apt-get install emacs24
    echo "Emacs Installed" >> $log_file

    echo "Installing Keepassx" >> $log_file
    sudo apt-get install keepassx
    echo "Keepassx Installed" >> $log_file

    echo "Installing figlet" >> $log_file
    sudo apt-get install figlet
    echo "figlet Installed" >> $log_file

    echo "Installing espeak" >> $log_file
    sudo apt-get install espeak
    echo "espeak Installed" >> $log_file

    echo "Installing curl" >> $log_file
    sudo apt-get install curl
    echo "curl Installed" >> $log_file

    echo "Installing exuberant-ctags" >> $log_file
    sudo apt-get install exuberant-ctags
    echo "exuberant-ctags Installed" >> $log_file

    echo "Downloading and installing git-completion" >> $log_file
    cd ~/
    curl -OL https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
    mv ~/git-completion.bash ~/.git-completion.bash
    echo "git-completion Installed and Configured" >> $log_file

    echo "Installing nodejs" >> $log_file
    cd ~/
    git clone https://github.com/joyent/node
    cd node
    sudo ./configure --prefix=/usr/local
    sudo make
    sudo make install
    cd ~/
    sudo rm -r node # Remove the node folder in the home directory
    echo "nodejs Installed" >> $log_file

    echo "Installing npm" >> $log_file
    sudo apt-get install npm
    echo "npm Installed" >> $log_file
    
    echo "Installing jshint" >> $log_file
    sudo npm install -g jshint
    echo "jshint Installed" >> $log_file

    echo "Installing coffee script" >> $log_file
    sudo npm install -g coffee-script
    echo "coffee script Installed" >> $log_file

    # jshint will look for node and it seems to be installed as
    # nodejs if that is the case we create a symlink
    ##if [ ! -f /usr/bin/node ]; then 
    ##    sudo ln -s /usr/bin/nodejs /usr/bin/node
    ##fi

    echo "Installing pyflakes" >> $log_file
    sudo apt-get install pyflakes
    echo "pyflakes Installed" >> $log_file

    echo "Downloading and installing Ack" >> $log_file
    curl http://beyondgrep.com/ack-2.04-single-file > ~/ack && chmod 0755 !#:3 
    sudo mv ~/ack /usr/bin/ack
    echo "Ack Downloaded and Installed" >> $log_file

    echo "Installing pip" >> $log_file
    sudo apt-get install python-pip
    echo "pip Installed" >> $log_file
fi

#==============
# Give the user a summary of what has been installed
#==============
echo -e "\n====== Success!! ======\n"
echo -e "\n====== Summary ======\n"
cat $log_file
echo
echo "When you first open vim run :BundleInstall to install the plugins"
echo "Enjoy -Jarrod"
rm $log_file
