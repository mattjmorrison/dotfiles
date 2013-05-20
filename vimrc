"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  An ever changing work in progress
"       AUTHOR:  Jarrod Taylor
"      CREATED:  06.19.2011
"      UPDATED:  05.15.2013
"===================================================================================
"
"-----------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings. This must be first, because it changes
" other options as a side effect.
"-----------------------------------------------------------------------------------
set nocompatible
"
"===================================================================================
" Vundle package management
"
" Help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"===================================================================================
"
"-----------------------------------------------------------------------------------
" Required for vundle to work
"-----------------------------------------------------------------------------------
 filetype off                   
 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()
 Bundle 'gmarik/vundle'
"
"-----------------------------------------------------------------------------------
" Github repos for bundles that we want to have installed
"-----------------------------------------------------------------------------------
 Bundle 'https://github.com/mileszs/ack.vim'
 Bundle 'https://github.com/vim-scripts/AutoComplPop'
 Bundle 'https://github.com/vim-scripts/bash-support.vim'
 Bundle 'https://github.com/skammer/vim-css-color'
 Bundle 'https://github.com/Raimondi/delimitMate'
 Bundle 'https://github.com/vim-scripts/L9'
 Bundle 'https://github.com/scrooloose/nerdtree'
 Bundle 'https://github.com/JarrodCTaylor/vim-color-menu'
 Bundle 'https://github.com/widox/vim-buffer-explorer-plugin'
 Bundle 'https://github.com/tpope/vim-fugitive'
 " Must have exuberant-ctags for this to work
 Bundle 'https://github.com/majutsushi/tagbar'
 Bundle 'https://github.com/ervandew/supertab'
 Bundle 'https://github.com/pangloss/vim-javascript'
 Bundle 'https://github.com/Lokaltog/vim-easymotion'
 Bundle 'https://github.com/scrooloose/syntastic'
"
"===================================================================================
" GENERAL SETTINGS
"===================================================================================
"
"-----------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Load indent files, to automatically do language-dependent indenting.
"-----------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
"-----------------------------------------------------------------------------------
" Color scheme and fonts if gui (gvim) then mustang if command line zenburn
"-----------------------------------------------------------------------------------
if has("gui_running")
	colorscheme mustang
	set guifont=Monospace\ 12 
	set antialias
else 
	set t_Co=256
	colorscheme zenburn
endif
"
"-----------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-----------------------------------------------------------------------------------
syntax on            
"
"-----------------------------------------------------------------------------------
" Various settings
"-----------------------------------------------------------------------------------
set autoindent                         " copy indent from current line
set autoread                           " read open files again when changed outside Vim
set autowrite                          " write a modified buffer on each :next , ...
set backspace=indent,eol,start         " backspacing over everything in insert mode
set browsedir=current                  " which directory to use for the file browser
set complete+=k                        " scan the files given with the 'dictionary' option
set history=50                         " keep 50 lines of command line history
set hlsearch                           " highlight the last used search pattern
set incsearch                          " do incremental searching
"set list                              " Toggle manually with set list / set nolist or set list!
set listchars=tab:>.,trail:@,nbsp:@    " strings to use in 'list' mode tabs >., trailing whitespace @ and invisible spaces @
set mouse=a                            " enable the use of the mouse
set nobackup                           " don't constantly write backup files
set noerrorbells                       " don't beep 
set nowrap                             " do not wrap lines
set popt=left:8pc,right:3pc            " print options
"set ruler                             " shows the cursor position all the time I have a custom status line for this
set shiftwidth=4                       " number of spaces to use for each step of indent
set showcmd                            " display incomplete commands in the bottom line of the screen
set smartcase                          " ignore case if search pattern is all lowercase, case_sensitive otherwise
set smartindent                        " smart autoindenting when starting a new line
set tabstop=4                          " number of spaces that a <Tab> counts for
set expandtab                          " Make vim use spaces and not tabs
set undolevels=1000                    " never can be too careful when it comes to undoing 
set visualbell                         " visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~,*.pyc  " wildmenu: ignore these extensions
set wildmenu                           " command-line completion in an enhanced mode
"
"-----------------------------------------------------------------------------------
" My pimped out status line
"-----------------------------------------------------------------------------------
set laststatus=2                " Make the second to last line of vim our status line
set statusline=%F                            " File path
set statusline+=%m%r%h%w                     " Flags
set statusline+=\ %{fugitive#statusline()}   " Git branch
set statusline+=\ [FORMAT=%{&ff}]            " File format
set statusline+=\ [TYPE=%Y]                  " File type
set statusline+=\ [ASCII=\%03.3b]            " ASCII value of character under cursor
set statusline+=\ [HEX=\%02.2B]              " HEX value of character under cursor
set statusline+=%=                           " Right align the rest of the status line
set statusline+=\ [POS=L%04l,R%04v]          " Cursor position in the file line, row
set statusline+=\ [%p%%]                     " Percentage of the file the active line is
set statusline+=\ [LEN=%L]                   " Number of line in the file
set statusline+=%#warningmsg#                " Highlights the syntastic errors in red
set statusline+=%{SyntasticStatuslineFlag()} " Adds the line number and error count
set statusline+=%*                           " Fill the width of the vim window
"
"-----------------------------------------------------------------------------------
" Turn off the toolbar that is under the menu in gvim
"-----------------------------------------------------------------------------------
set guioptions-=T
"
"===================================================================================
"  REMAPPED KEYS 
"  (nore) prefix -- non-recursive
"  (un)   prefix -- Remove a mode-specific map 
"  Commands                        Mode
"  --------                        ----
"  map                             Normal, Visual, Select, Operator Pending modes
"  nmap, nnoremap, nunmap          Normal mode
"  imap, inoremap, iunmap          Insert and Replace mode
"  vmap, vnoremap, vunmap          Visual and Select mode
"  xmap, xnoremap, xunmap          Visual mode
"  smap, snoremap, sunmap          Select mode
"  cmap, cnoremap, cunmap          Command-line mode
"  omap, onoremap, ounmap          Operator pending mode
"===================================================================================
"
" --- change mapleader from \ to 9 as I find that easier to type
let mapleader="9"  
" --- jk mapped to <Esc> so we can keep our fingers on the home row 
imap jk <Esc>
" --- ss will toggle spell checking
map ss :setlocal spell!<CR>
" --- toggle NERDTree 
nnoremap <leader>d :NERDTreeToggle<CR>
" --- toggle Tagbar 
nnoremap <leader>tb :TagbarToggle<CR>
" --- open a list of buffers and change to the number selected
nnoremap <leader>t :buffers<CR>:buffer<Space>
" --- open minibuffer explorer
nnoremap <leader>b :BufExplorer<CR>
" --- Auto completion to get python parameter information
inoremap <leader><space> <C-x><C-o>
" --- Better window navigation E.g. now use Ctrl+j instead of Ctrl+W+j
nnoremap <C-j> <C-w>j  
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" --- Split the window vertically
nnoremap <leader>sv :vsplit<CR>
" --- Split the window horizontally
nnoremap <leader>sh :split<CR>
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
"-----------------------------------------------------------------------------------
" Syntastic configurations use :help syntastic.txt
"-----------------------------------------------------------------------------------
let g:syntastic_check_on_open=1                " check for errors when file is loaded
let g:syntastic_loc_list_height=5              " the height of the error list defaults to 10
let g:syntastic_python_checker = 'pyflakes'    " sets pyflakes as the default for checking python files
let g:syntastic_javascript_checker = 'jshint'  " sets jshint as our javascript linter

" 
"===================================================================================
" BUFFERS, WINDOWS
"===================================================================================
"
"-----------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-----------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufEnter * :lchdir %:p:h
endif
"
"-----------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-----------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")
"
