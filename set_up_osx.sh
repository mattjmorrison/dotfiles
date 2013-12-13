#!/bin/bash -
#===============================================================================
#
#             NOTES: For this to work you must have cloned the github
#                    repo to your home folder as ~/dotfiles/
#
#===============================================================================

#==============
# Make sure the dotfiles are properly linked
#==============
echo -n "Would you like to replace any existing dot files (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    #==============
    # Remove old dot flies
    #==============
    sudo rm -r ~/.vim > /dev/null 2>&1
    sudo rm ~/.vimrc > /dev/null 2>&1
    sudo rm ~/.bashrc > /dev/null 2>&1
    sudo rm ~/.tmux > /dev/null 2>&1
    sudo rm ~/.tmux.conf > /dev/null 2>&1
    sudo rm ~/.zsh_prompt > /dev/null 2>&1
    sudo rm ~/.zshrc > /dev/null 2>&1
    sudo rm ~/.gitconfig
    sudo rm ~/.ackrc
    sudo rm ~/.antigen
    sudo rm ~/.antigen.zsh
    #==============
    # Create symlinks in the home folder
    #==============
    ln -s ~/dotfiles/vim ~/.vim
    ln -s ~/dotfiles/vimrc ~/.vimrc
    ln -s ~/dotfiles/bashrc ~/.bashrc
    ln -s ~/dotfiles/mac_tmux ~/.tmux
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/zsh/zsh_prompt ~/.zsh_prompt
    ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
    ln -s ~/dotfiles/gitconfig ~/.gitconfig
    ln -s ~/dotfiles/ackrc ~/.ackrc
fi

#==============
# Clone vundle to manage vim plugins
#==============
git clone https://github.com/gmarik/vundle.git ~/dotfiles/vim/bundle/vundle

#==============
# Install all the packages
#==============
echo -n "Install all the packages (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then

    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    brew doctor
    brew update

    # So we use all of the packages we are about to install
    echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.bashrc
    source ~/.bashrc

    # ===
    # The regular brew installable packages
    # ===
    brew install tig
    brew install aspell
    brew install node
    brew install ack
    brew install tmux
    brew install mysql
    brew install vim
    brew install zsh

    # ===
    # Get Ctags properly setup
    # Brew install and do away with the busted default version of ctags
    # ===
    brew install ctags
    sudo mv /usr/bin/ctags /usr/bin/ctags_orig

    # ===
    # Install pip and global pip packages
    # ===
    sudo easy_install pip
    sudo pip install virtualenvwrapper
    sudo pip install jedi
    sudo pip install flake8

    # ===
    # Gollum set up
    # ===
    brew install icu4c
    sudo gem install gollum
    sudo gem install redcarpet

    # ===
    # brew-cask installs
    # ===
    brew tap phinze/homebrew-cask
    brew install brew-cask

    echo "install chrome"
    brew cask install google-chrome

    echo "install firefox"
    brew cask install firefox

    echo "install iterm2"
    brew cask install iterm2

    echo "install alfred"
    brew cask install alfred

    echo "install virtualbox"
    brew cask install virtualbox
fi

#==============
# Set zsh as the default shell
#==============
chsh -s /bin/zsh

#==============
# And we are done
#==============
echo -e "\n====== Success!! ======\n"
echo
echo "When you first open vim run :BundleInstall to install the plugins"
echo "Enjoy -Jarrod"
