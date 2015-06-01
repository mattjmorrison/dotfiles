#!/bin/zsh
#===============================================================================
#
#             NOTES: For this to work you must have cloned the github
#                    repo to your home folder as ~/dotfiles/
#
#===============================================================================

#==============
# Remove old dot flies
#==============
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.bashrc > /dev/null 2>&1
sudo rm -rf ~/.tmux > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.zsh_prompt > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -rf ~/.antigen > /dev/null 2>&1
sudo rm -rf ~/.antigen.zsh > /dev/null 2>&1
sudo rm -rf ~/.psqlrc > /dev/null 2>&1
sudo rm -rf ~/coffeelint.json > /dev/null 2>&1
sudo rm -rf ~/.tigrc > /dev/null 2>&1
sudo rm -rf ~/.config > /dev/null 2>&1
sudo rm -rf ~/.ideavimrc > /dev/null 2>&1

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/bashrc ~/.bashrc
ln -s ~/dotfiles/mac-tmux ~/.tmux
ln -s ~/dotfiles/zsh/zsh_prompt ~/.zsh_prompt
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/config ~/.config
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc

if [ -n "$(find ~/dotfiles/custom-configs -name gitconfig)" ]; then
    ln -s ~/dotfiles/custom-configs/**/gitconfig ~/.gitconfig
else
    ln -s ~/dotfiles/gitconfig ~/.gitconfig
fi

if [ -n "$(find ~/dotfiles/custom-configs -name tmux.conf)" ]; then
    ln -s ~/dotfiles/custom-configs/**/tmux.conf ~/.tmux.conf
else
    ln -s ~/dotfiles/mac-tmux/tmux.conf ~/.tmux.conf
fi

if [ -n "$(find ~/dotfiles/custom-configs -name tigrc)" ]; then
    ln -s ~/dotfiles/custom-configs/**/tigrc ~/.tigrc
else
    ln -s ~/dotfiles/tigrc ~/.tigrc
fi

if [ -n "$(find ~/dotfiles/custom-configs -name psqlrc)" ]; then
    ln -s ~/dotfiles/custom-configs/**/psqlrc ~/.psqlrc
else
    ln -s ~/dotfiles/psqlrc ~/.psqlrc
fi

if [ -n "$(find ~/dotfiles/custom-configs -name coffeelint.json)" ]; then
    ln -s ~/dotfiles/custom-configs/**/coffeelint.json ~/coffeelint.json
else
    ln -s ~/dotfiles/coffeelint.json ~/coffeelint.json
fi

#==============
# Set zsh as the default shell
#==============
chsh -s /bin/zsh

#==============
# And we are done
#==============
echo -e "\n====== All Done!! ======\n"
echo
echo "Enjoy -Jarrod"
