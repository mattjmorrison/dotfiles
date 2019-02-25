#==============
# Install all the packages
#==============
echo -n "Install all base packages (Y/n) => "; read answer
if [[ $answer != "n" ]] && [[ $answer != "N" ]] ; then
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
    brew install vim
    brew install tig
    brew install aspell
    brew install node
    brew install reattach-to-user-namespace
    brew install tmux
    brew install the_silver_searcher
    brew install planck
    brew install zsh-syntax-highlighting

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
fi

echo -n "Install haskell related tools? (y/N) => "; read haskell
if [[ $haskell = "y" ]] || [[ $haskell = "Y" ]] ; then
    brew install haskell-stack
    stack setup
    stack install hlint ghc-mod hdevtools
fi

echo -n "Install GO related tools? (y/N) => "; read go
if [[ $go = "y" ]] || [[ $go = "Y" ]] ; then
    brew install go --cross-compile-common
    # go get -u github.com/golang/lint/golint
fi
