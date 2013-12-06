# VIM-ACK

A wrapper for the Perl module [Ack](http://beyondgrep.com/).
This plugin will allow you to run ack from vim, and shows the results in a split window.

## INSTALLATION

Use your plugin manager of choice.

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/JarrodCTaylor/vim-ack ~/.vim/bundle/vim-ack`
- [Vundle](https://github.com/gmarik/vundle)
  - Add `Bundle 'https://github.com/JarrodCTaylor/vim-ack'` to .vimrc
  - Run `:BundleInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - Add `NeoBundle 'https://github.com/JarrodCTaylor/vim-ack'` to .vimrc
  - Run `:NeoBundleInstall`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - Add `Plug 'https://github.com/JarrodCTaylor/vim-ack'` to .vimrc
  - Run `:PlugInstall`

## REQUIREMENTS
You must have ack installed.

## Usage

`:Ack [options] {pattern} [{directory}]`

Search recursively in {directory} (which defaults to the current directory) for the {pattern}.

Files containing the search term will be listed in the split window, along with
the line number of the occurrence, once for each occurrence.  [Enter] on a line
in this window will open the file, and place the cursor on the matching line.

### SPECIAL CHARACTERS

Some characters have special meaning, and need to be escaped your search pattern.
For instance, '#'. You have to escape it as follows `:Ack '\\\#define foo'` to search
for `#define foo`.

### KEYBOARD SHORTCUTS

In the quickfix window, you can use:

Enter    Open in buffer and automatically close preview window
    o    to open
    go   to preview file (open but maintain focus on ack.vim results)
    t    to open in new tab
    T    to open in new tab silently
    h    to open in horizontal split
    H    to open in horizontal split silently
    v    to open in vertical split
    gv   to open in vertical split silently
    q    to close the quickfix window
