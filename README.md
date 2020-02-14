# Dotfiles


In my opinion *which I respect very much* what you have stumbled across right
here are the best dotfiles money can buy, and they're priced to move. This venerable
treasure trove of developer tools is worthy of your time and attention. So if you
love the command line, and I know you do, then grab a copy and get coding.

## Installation

``` bash
git clone https://github.com/dhcrain/dotfiles.git ~/dotfiles
cd ~/dotfiles/install-scripts
bash setup.sh
```

## Customization

There is no need to fork this repository in order to customize it. (*But I did it anyway*) Everything
can be customized by leveraging the [custom-configs](https://github.com/dhcrain/dotfiles/wiki/custom-config) directory.
You are encouraged to maintain a separate github repository of configurations for your own dotfiles.

# Contents


## Zsh

When you first open the terminal you will notice the custom prompt. The prompt
takes up the full width of the terminal and is two or three lines depending on
if you are currently in a directory that is a git repo. The image below details
the core components of the prompt.

![zsh-prompt](https://cloud.githubusercontent.com/assets/4416952/4179773/ecec6e52-36d5-11e4-9317-bd6af3313e73.png)

### Customizing Zsh

[customizing-zsh](https://github.com/mattjmorrison/dotfiles/wiki/zsh)

## Misc Customization

You can use your own configuration file in place of any of the following
 * gitconfig
 * psqlrc

To do so you just need to include a file of the same name in your version
controlled directory that you save into `custom-configs` the create symlinks
scripts will link the files properly.
