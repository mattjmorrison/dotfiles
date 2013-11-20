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
    sudo rm -r ~/highlighters > /dev/null 2>&1
    sudo rm ~/.zsh_prompt > /dev/null 2>&1
    sudo rm ~/zsh-syntax-highlighting.zsh > /dev/null 2>&1
    sudo rm ~/.zshrc > /dev/null 2>&1
    sudo rm ~/.gitconfig
    #==============
    # Create symlinks in the home folder
    #==============
    ln -s ~/dotfiles/Mac/vim ~/.vim
    ln -s ~/dotfiles/Mac/vimrc ~/.vimrc
    ln -s ~/dotfiles/Mac/bashrc ~/.bashrc
    ln -s ~/dotfiles/Mac/tmux ~/.tmux
    ln -s ~/dotfiles/Mac/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/Mac/zsh/highlighters ~/highlighters
    ln -s ~/dotfiles/Mac/zsh/zsh_prompt ~/.zsh_prompt
    ln -s ~/dotfiles/Mac/zsh/zsh-syntax-highlighting.zsh ~/zsh-syntax-highlighting.zsh
    ln -s ~/dotfiles/Mac/zsh/zshrc ~/.zshrc
    ln -s ~/dotfiles/Mac/gitconfig ~/.gitconfig
fi

#==============
# Clone vundle to manage vim plugins
#==============
git clone https://github.com/gmarik/vundle.git ~/dotfiles/Mac/vim/bundle/vundle

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

    brew install tig
    brew install node
    brew install ack
    brew install tmux
    brew install mysql
    brew install mongo
    brew install vim
    brew install zsh
    brew install ctags
    # Do away with the busted default version of ctags
    sudo mv /usr/bin/ctags /usr/bin/ctags_orig

    sudo easy_install pip
    sudo pip install virtualenvwrapper
    sudo pip install jedi
    sudo pip install flake8
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
