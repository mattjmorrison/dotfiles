#==============
# Install all the packages
#==============
echo -n "Install all the packages (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    sudo chown -R $(whoami):admin /usr/local

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew update

    # So we use all of the packages we are about to install
    echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.bashrc
    source ~/.bashrc

    # ===
    # The regular brew installable packages
    # ===
    brew install zsh
    brew install vim --with-lua
    brew install tig
    brew install aspell
    brew install node
    brew install reattach-to-user-namespace --wrap-pbcopy-and-pbpaste
    brew install ack
    brew install tmux
    brew install the_silver_searcher
    brew install planck

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
    sudo gem install CoffeeTags

    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
    sh /tmp/installer.sh ~/.dein
fi
