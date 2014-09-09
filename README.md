![jarrod_taylor_made](https://cloud.githubusercontent.com/assets/4416952/4179463/baa22c1a-36c7-11e4-8d8b-b0d1cee0caa6.png)

# dotfiles

In my opinion *which I respect very much* what you have stumbled across right here is the best dotfiles money can buy. I have and continue to spend a ridiculous amount of time grooming and enhancing this treasure trove of developer tools. So if you love the command line, and I know you do, then do yourself a favor, grab a copy and get to coding.

## Installation

``` bash
git clone https://github.com/JarrodCTaylor/dotfiles.git ~/dotfiles
cd ~/dotfiles 
bash set_up_linux.sh
# or
bash set_up_osx.sh
```

# Contents 

## Zsh

At the configurations core is the Z shell. When you first open the terminal you will notice the custom prompt. The prompt takes up the full width of the terminal and is two or three lines depending on if you are currently in a directory that is a git repo. The image below details the core components of the prompt. Additionally if you enter a directory that shares the name of a Python virtualenv it will be activated automatically and indicated visually in the prompt. The same is true for a directory containing node modules. 

![zsh-prompt](https://cloud.githubusercontent.com/assets/4416952/4179773/ecec6e52-36d5-11e4-9317-bd6af3313e73.png)

The shell has many convenience aliases and functions. For those I will suggest you look at the zshrc file as it is well organized and fully commented 

## Tmux

A must have for pair programming sessions. The most notable features are the themed status line pictured below and the non-stock leader key \<C-Space>

![tmux-status](https://cloud.githubusercontent.com/assets/4416952/4179937/429dc236-36dd-11e4-87ad-1aca9966db8d.png)

## Vim

The vim configuration is the life blood of the dotfiles. Vim is my primary editor and spend the majority of everyday banging away inside its modal buffers. Similar to the zshrc the vimrc is very well organized and fully commented. You can interactively explore the key mappings by opening an empty buffer and typing `|9` in normal mode as pictured below. This will open a unite menu that lists all of the shortcuts with a description and the key mapping that triggers it. You can scroll through the list with \<C-J> \<C-k> or filter the options by typing.

![vim](https://cloud.githubusercontent.com/assets/4416952/4179851/d820ceba-36d9-11e4-8818-0aee5eb7b096.gif)

## Emacs

While Vim is far and away my primary editor I would be remiss if I didn't mention the emacs configuration that you get with these dotfiles as well. Evil mode is used to make the Vim user feel almost at home. Again the configuration files are well organized and fully commented. 

![emacs](https://cloud.githubusercontent.com/assets/4416952/4180166/c5b4124e-36ea-11e4-8f21-2cef1009c2d7.gif)

## Conky

To wrap up the tour we have one more treat for the Linux users out there. Conky in two flavors 2 and 4 core. The setup script will ask you which one you would like to install.

![conky](https://cloud.githubusercontent.com/assets/4416952/4180173/3ffd4868-36eb-11e4-84a9-2b50f8c00694.png)
