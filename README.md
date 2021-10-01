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

## Other Manual Steps

### Avoid loading “All My Files” when the Finder opens. To do this we need two steps:

1. Go to the Preferences for Finder:
	Under "New Finder windows show: 
	Choose any folder that is not “Recants”:
	By changing this setting, we can make sure new Finder windows do not show “All My Files” and eat our RAM.

2. Relaunch Finder, without triggering “All My Files”.
	A simple relaunch by holding option, two finger tapping (right click) on the Finder icon and selecting “Relaunch” should be enough. Or `killall Finder` if that doesn't work

From: https://paradite.com/2017/01/31/reduce-macos-finder-memory-usage/

And: https://apple.stackexchange.com/questions/53075/when-will-finder-use-large-amount-of-memory/105832#105832


### Use spacebar to select and tab to navigate controls
1.  → System Preferences → Keyboard → Shortcuts → Use keyboard navigation to move focus between controls

From: https://apple.stackexchange.com/a/384961/374596


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
