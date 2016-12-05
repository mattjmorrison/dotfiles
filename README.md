# Dotfiles

<img src="https://cloud.githubusercontent.com/assets/4416952/4179463/baa22c1a-36c7-11e4-8d8b-b0d1cee0caa6.png"
 alt="JarrodCTaylor" title="JarrodCTaylor" align="left" />

In my opinion *which I respect very much* what you have stumbled across right
here is the best dotfiles money can buy, and they're priced to move. This venerable
treasure trove of developer tools is worthy of your time and attention. So if you
love the command line, and I know you do, then grab a copy and get coding.

## Installation

``` bash
git clone https://github.com/JarrodCTaylor/dotfiles.git ~/dotfiles
cd ~/dotfiles/install-scripts
bash OSX/install-packages.sh
bash OSX/create-symlinks.sh
# or
bash Linux/install-packages.sh
bash Linux/create-symlinks.sh
```

## Customization

There is no need to fork this repository in order to customize it. Everything
can be customized by leveraging the [custom-configs](https://github.com/JarrodCTaylor/dotfiles/wiki/custom-config) directory.
You are encouraged to maintain a separate github repository of configurations for your own dotfiles.

# Contents


## Zsh

When you first open the terminal you will notice the custom prompt. The prompt
takes up the full width of the terminal and is two or three lines depending on
if you are currently in a directory that is a git repo. The image below details
the core components of the prompt. Additionally if you enter a directory that
shares the name of a Python virtualenv it will be activated automatically and
indicated visually in the prompt. The same is true for a directory containing
node modules.

![zsh-prompt](https://cloud.githubusercontent.com/assets/4416952/4179773/ecec6e52-36d5-11e4-9317-bd6af3313e73.png)

### Customizing Zsh

[customizing-zsh](https://github.com/JarrodCTaylor/dotfiles/wiki/zsh)

## Tmux

A must have for pair programming sessions. The most notable features are the
themed status line pictured below and the non-stock leader key \<C-Space>

![tmux-status](https://cloud.githubusercontent.com/assets/4416952/4179937/429dc236-36dd-11e4-87ad-1aca9966db8d.png)

## Vim

The vim configuration is the life blood of the dotfiles. Although it is heavily
customized you can interactively explore the key mappings to quickly find out
what it has to offer.  Open any buffer buffer and type `|<Space>` in normal
mode. This will open a unite menu that lists all of the shortcuts with a
description and the key mapping that triggers it. You can scroll through the
list with \<C-J> \<C-k> or filter the options by typing as seen below.

![key-map-search](https://cloud.githubusercontent.com/assets/4416952/13449402/cc8002b2-dff0-11e5-911b-e616d851f525.gif)

### Customizing Vim

- [Adding Plugins](https://github.com/JarrodCTaylor/dotfiles/wiki/Adding-Vim-Plugins)
- [Removing Plugins](https://github.com/JarrodCTaylor/dotfiles/wiki/Removing-Vim-Plugins)
- [Adding Snippets](https://github.com/JarrodCTaylor/dotfiles/wiki/Adding-Vim-Snippets)
- [Changing Colorschemes](https://github.com/JarrodCTaylor/dotfiles/wiki/Changing-Vim-Colorschemes)
- [Splash Screen](https://github.com/JarrodCTaylor/dotfiles/wiki/Changing-Vim-Splashscreen)

## Misc Customization

You can use your own configuration file in place of any of the following
 * gitconfig
 * psqlrc
 * tigrc
 * tmux.conf

To do so you just need to include a file of the same name in your version
controlled directory that you save into `custom-configs` the create symlinks
scripts will link the files properly.
