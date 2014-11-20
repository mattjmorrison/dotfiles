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

At the configurations core is the Z shell. When you first open the terminal you
will notice the custom prompt. The prompt takes up the full width of the
terminal and is two or three lines depending on if you are currently in a
directory that is a git repo. The image below details the core components of
the prompt. Additionally if you enter a directory that shares the name of a
Python virtualenv it will be activated automatically and indicated visually in
the prompt. The same is true for a directory containing node modules.

![zsh-prompt](https://cloud.githubusercontent.com/assets/4416952/4179773/ecec6e52-36d5-11e4-9317-bd6af3313e73.png)

### Customizing Zsh

The zsh setup is designed to allow customization. You can maintain a separate
version controlled repository of zsh configurations and pull that repository
into the `dotfiles/custom-configs` directory. Any file ending with `.sh` will
automatically be sourced when you open a shell. You can use this to add
additional alias, functions, etc.


## Tmux

A must have for pair programming sessions. The most notable features are the themed status line pictured below and the non-stock leader key \<C-Space>

![tmux-status](https://cloud.githubusercontent.com/assets/4416952/4179937/429dc236-36dd-11e4-87ad-1aca9966db8d.png)

## Vim

The vim configuration is the life blood of the dotfiles. Vim is my primary
editor and I spend the majority of everyday banging away inside its modal
buffers. You can interactively explore the key mappings by opening an empty buffer and
typing `|<Space>` in normal mode as pictured below. This will open a unite menu
that lists all of the shortcuts with a description and the key mapping that
triggers it. You can scroll through the list with \<C-J> \<C-k> or filter the
options by typing.

### Customizing Vim

The Vim setup is designed to allow customization. You can maintain a separate
version controlled repository of Vim configurations and pull that repository
into the `dotfiles/custom-configs` directory. Any file ending with `.vim` will
automatically be sourced. If you would like to add additional plugins copy a
file from `vim/plugin-configs` and updated it as needed then save that file
with a name that ends in `-plugin.vim`. If you would like to not load some of
the plugins that I have configured you can create a file named
`custom-init.vim` that you can specify an array of plugins to exclude. For
example `hard-time` is not for the novice Vim user. So in your
`custom-init.vim` you can add the following line.  `let g:exclude =
["vim-hardtime.vim"]` this array can contain the name of any file in
`vim/plugin-configs`


## Conky

To wrap up the tour we have one more treat for the Linux users out there. Conky in two flavors 2 and 4 core. The setup script will ask you which one you would like to install.

![conky](https://cloud.githubusercontent.com/assets/4416952/4180173/3ffd4868-36eb-11e4-84a9-2b50f8c00694.png)
