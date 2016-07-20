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

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/mac-tmux ~/.tmux
ln -sf ~/dotfiles/zsh/zsh_prompt ~/.zsh_prompt
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/dotfiles/config ~/.config
ln -sf ~/dotfiles/custom-configs/custom-snips ~/.vim/custom-snips

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
