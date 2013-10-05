" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
"===================================================================================
"  DESCRIPTION:  An ever changing work in progress
"       AUTHOR:  Jarrod Taylor
" ____   ____.__                  .__               __
" \   \ /   /|__| _____           |__| ____ _____ _/  |_  ___________
"  \   Y   / |  |/     \   ______ |  |/    \\__  \\   __\/  _ \_  __ \
"   \     /  |  |  Y Y  \ /_____/ |  |   |  \/ __ \|  | (  <_> )  | \/
"    \___/   |__|__|_|  /         |__|___|  (____  /__|  \____/|__|
"                     \/                  \/     \/
"
"===================================================================================
"

" Set nocompatible {
"-----------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings. This must be first, because it changes
" other options as a side effect.
"-----------------------------------------------------------------------------------
set nocompatible
" }

" Vundle Package Management {
"===================================================================================
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
 Bundle 'https://github.com/Shougo/neocomplcache.vim'
 Bundle 'https://github.com/vim-scripts/bash-support.vim'
 " Bundle 'https://github.com/skammer/vim-css-color'
 Bundle 'https://github.com/Raimondi/delimitMate'
 Bundle 'https://github.com/vim-scripts/L9'
 Bundle 'https://github.com/scrooloose/nerdtree'
 Bundle 'https://github.com/JarrodCTaylor/vim-256-color-schemes'
 Bundle 'https://github.com/tpope/vim-fugitive'
 " Must have exuberant-ctags for tagbar to work
 Bundle 'https://github.com/majutsushi/tagbar'
 Bundle 'https://github.com/ervandew/supertab'
 Bundle 'https://github.com/pangloss/vim-javascript'
 Bundle 'https://github.com/Lokaltog/vim-easymotion'
 Bundle 'https://github.com/scrooloose/syntastic'
 Bundle 'https://github.com/vim-scripts/UltiSnips'
 Bundle 'https://github.com/kchmck/vim-coffee-script'
 Bundle 'https://github.com/kien/ctrlp.vim'
 Bundle 'https://github.com/tpope/vim-commentary'
 Bundle 'https://github.com/davidhalter/jedi-vim'
 Bundle 'https://github.com/mhinz/vim-startify'
 Bundle 'https://github.com/tmhedberg/SimpylFold'
 Bundle 'https://github.com/nono/vim-handlebars'
 Bundle 'https://github.com/JarrodCTaylor/vim-python-test-runner'
 Bundle 'https://github.com/goldfeld/vim-seek.git'
 Bundle 'https://github.com/tpope/vim-surround'
 Bundle 'https://github.com/bling/vim-airline'
 " This will no longer be needed in vim 7.4
 Bundle 'https://github.com/guns/vim-clojure-static'
 Bundle 'https://github.com/tpope/vim-fireplace'
 Bundle 'https://github.com/kien/rainbow_parentheses.vim'
 Bundle 'https://github.com/JarrodCTaylor/vim-js2coffee'
" }

" General Settings {
"
"-----------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Load indent files, to automatically do language-dependent indenting.
"-----------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
"-----------------------------------------------------------------------------------
" Color scheme
"-----------------------------------------------------------------------------------
set t_Co=256
colorscheme tomorrow-night
"
"-----------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-----------------------------------------------------------------------------------
syntax on
"
"-----------------------------------------------------------------------------------
" Various settings
"-----------------------------------------------------------------------------------
set autoindent                         " Copy indent from current line
set autoread                           " Read open files again when changed outside Vim
set autowrite                          " Write a modified buffer on each :next , ...
set backspace=indent,eol,start         " Backspacing over everything in insert mode
set history=50                         " Keep 50 lines of command line history
set hlsearch                           " Highlight the last used search pattern
set incsearch                          " Do incremental searching
"set list                              " Toggle manually with set list / set nolist or set list!
set listchars=""                       " Empty the listchars
set listchars=tab:>.                   " A tab will be displayed as >...
set listchars+=trail:.                 " Trailing white spaces will be displayed as .
set mouse=a                            " Enable the use of the mouse
set nobackup                           " Don't constantly write backup files
set noswapfile                         " Ain't nobody got time for swap files
set noerrorbells                       " Don't beep
set nowrap                             " Do not wrap lines
set popt=left:8pc,right:3pc            " Print options
set shiftwidth=4                       " Number of spaces to use for each step of indent
set showcmd                            " Display incomplete commands in the bottom line of the screen
set smartcase                          " Ignore case if search pattern is all lowercase, case_sensitive otherwise
set tabstop=4                          " Number of spaces that a <Tab> counts for
set expandtab                          " Make vim use spaces and not tabs
set undolevels=1000                    " Never can be too careful when it comes to undoing
set hidden                             " Don't unload the buffer when we switch between them. Saves undo history
set visualbell                         " Visual bell instead of beeping
set wildignore=*.swp,*.bak,*.pyc,*.class,node_modules/**  " wildmenu: ignore these extensions
set wildmenu                           " Command-line completion in an enhanced mode
set shell=bash                         " Required to let zsh know how to run things on command line
set clipboard=unnamed                  " Yank and paste with the system clipboard
set ttimeoutlen=50                     " Fix delay when escaping from insert with Esc

"-----------------------------------------------------------------------------------
" Turn off the toolbar that is under the menu in gvim
"-----------------------------------------------------------------------------------
set guioptions-=T

"-----------------------------------------------------------------------------------
" Treat JSON files like JavaScript
"-----------------------------------------------------------------------------------
au BufNewFile,BufRead *.json set ft=javascript

"-----------------------------------------------------------------------------------
" Make pasting done without any indentation break
"-----------------------------------------------------------------------------------
set pastetoggle=<F3>

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
endif

"-----------------------------------------------------------------------------------
" Abbreviations
"-----------------------------------------------------------------------------------
:iabbr teh the

" }

" My pimped out status line {

set laststatus=2                                    " Make the second to last line of vim our status line
let g:airline_theme='understated'                   " Use the custom theme I wrote
let g:airline_left_sep=''                           " No separator as they seem to look funky
let g:airline_right_sep=''                          " No separator as they seem to look funky
let g:airline#extensions#branch#enabled = 0         " Do not show the git branch in the status line
let g:airline#extensions#syntastic#enabled = 1      " Do show syntastic warnings in the status line
let g:airline#extensions#tabline#show_buffers = 0   " Do not list buffers in the status line
let g:airline_section_x = ''                        " Do not list the filetype or virtualenv in the status line
"let g:airline_section_y = '[TYPE=%Y] [Format=%{&ff}] [ASCII=%03.3b] [HEX=%02.2B] [R%04l,C%04v] [LEN=%L]'  " Replace file encoding and file format info with file position
let g:airline_section_y = '[R%04l,C%04v] [LEN=%L]'  " Replace file encoding and file format info with file position
let g:airline_section_z = ''                        " Do not show the default file position info
" }

"  Remapped Keys {
"===================================================================================
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
"
" Keys         Notation
" -----        ---------
" <C-s>        Ctrl + s
" <A-s>        Alt + s
" <M-s>        Meta + s
" <BS>         Backspace
" <Tab>        Tab
" <CR>         Enter
" <Esc>        Escape
" <Space>      Space
" <Up>         Up arrow
" <Down>       Down arrow
" <Left>       Left arrow
" <Right>      Right arrow
" <F1> - <F12> Function keys 1 to 12
" <Insert>     Insert
" <Del>        Delete
" <Home>       Home
" <End>        End


"===================================================================================
"
" --- change mapleader from \ to 9 as I find that easier to type
let mapleader="9"
" --- jk mapped to <Esc> so we can keep our fingers on the home row
imap jk <Esc>
" --- ss will toggle spell checking
map ss :setlocal spell!<CR>
" --- toggle NERDTree
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>no :NERDTreeFind<CR>
" --- toggle Tagbar
nnoremap <Leader>tb :TagbarToggle<CR>
" --- open CtrlP buffer explorer
nnoremap <Leader>b :CtrlPBuffer<CR>
" --- open Ctrlp as a fuzzy finder
nnoremap <Leader>ff :CtrlP<CR>
" --- Split the window vertically
nnoremap <Leader>\ :vsplit<CR>
" --- Split the window horizontally
nnoremap <Leader>- :split<CR>
" --- Ack short cut
nnoremap <Leader>a :Ack!<space>
" --- Toggle Syntastic
nnoremap <Leader>ts :SyntasticToggleMode<CR>
" --- Clear the search buffer and highlighted text with enter press
:nnoremap <CR> :nohlsearch<CR>
" --- Search the ctags index file for anything by class or method name
map <Leader>st :CtrlPTag<CR>
" --- Refresh the ctags file
nnoremap <Leader>rt :call RenewTagsFile()<CR>
" --- Strip trailing whitespace
nnoremap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>
" --- Better window navigation E.g. now use Ctrl+j instead of Ctrl+W+j
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" --- Shortcuts for test running commands
nnoremap<Leader>da :DjangoTestApp<CR>
nnoremap<Leader>df :DjangoTestFile<CR>
nnoremap<Leader>dc :DjangoTestClass<CR>
nnoremap<Leader>dm :DjangoTestMethod<CR>
nnoremap<Leader>nf :NosetestFile<CR>
nnoremap<Leader>nc :NosetestClass<CR>
nnoremap<Leader>nm :NosetestMethod<CR>
nnoremap<Leader>rr :RerunLastTests<CR>
" --- grunt-karma test runner shortcut
map <Leader>q :!grunt test<CR>"
" --- Toggle relative line numbering
nnoremap<Leader>tn :set relativenumber!<CR>
" --- Shortcut to RenameFile function defined below
map <Leader>rf :call RenameFile()<CR>
" --- Shortcut to CopyFile function defined below
map <Leader>cf :call CopyFile()<CR>

" }

" Plugin Configurations {

"-----------------------------------------------------------------------------------
" Syntastic configurations use :help syntastic.txt
"-----------------------------------------------------------------------------------
let g:syntastic_check_on_open=1                   " check for errors when file is loaded
let g:syntastic_loc_list_height=5                 " the height of the error list defaults to 10
let g:syntastic_python_checkers = ['flake8']      " sets flake8 as the default for checking python files
let g:syntastic_javascript_checkers = ['jshint']  " sets jshint as our javascript linter
" Ignore line width for syntax checking in python
let g:syntastic_python_flake8_post_args='--ignore=E501'
"
"-----------------------------------------------------------------------------------
" UltiSnips configurations
"-----------------------------------------------------------------------------------
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mySnippets"]
"
"-----------------------------------------------------------------------------------
" Neocomplcache configurations
"-----------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup=1
" To make compatible with jedi
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplcache_force_omni_patterns')
      let g:neocomplcache_force_omni_patterns = {}
  endif
let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'
let g:neocomplcache_force_overwrite_completefunc=1
"
"-----------------------------------------------------------------------------------
" Ctrlp configurations
"-----------------------------------------------------------------------------------
let g:ctrlp_custom_ignore = 'node_modules$\|xmlrunner$\|.DS_Store|.git|.bak|.swp|.pyc'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 18
"
"-----------------------------------------------------------------------------------
" Exuberant ctags configurations
" Vim will look for a ctags file in the current directory and continue
" up the file path until it finds one
"-----------------------------------------------------------------------------------
" Enable ctags support
set tags=./.ctags,.ctags;

"-----------------------------------------------------------------------------------
" NERDTree configurations
"-----------------------------------------------------------------------------------
" Make NERDTree ignore .pyc files
let NERDTreeIgnore = ['\.pyc$']

"-----------------------------------------------------------------------------------
" Jedi configurations
"-----------------------------------------------------------------------------------
let g:jedi#goto_definitions_command = "<Leader>j"
let g:jedi#use_tabs_not_buffers = 0     " Use buffers not tabs
let g:jedi#popup_on_dot = 0

"-----------------------------------------------------------------------------------
" Startify configurations
"-----------------------------------------------------------------------------------
" Highlight the acsii banner with green font
hi StartifyHeader ctermfg=76
" Make startify not open ctrlp in a new buffer
let g:ctrlp_reuse_window = 'startify'
" Don't change the directory when opening a recent file with a shortcut
let g:startify_change_to_dir = 0

" Set the contents of the banner
let g:startify_custom_header = [
            \ '                                                                                                                        ',
            \ '                            $$$$                                                                     $$$$               ',
            \ '                            $$$$                                                                     $$$$               ',
            \ '                            $$$$                                                                     $$$$               ',
            \ '                            $$$$       $$$$$      $$$        $$$             $$$$            $$$$$   $$$$               ',
            \ '                            $$$$   $$$$$$$$$$$$   $$$$$$$$$$ $$$$$$$$$$  $$$$$$$$$$$$     $$$$$$$$$$$$$$$               ',
            \ '       $$$$$$$$$$$$$$$$$$$  $$$$  $$$$      $$$$  $$$$$$$$$$ $$$$$$$$$$ $$$$$    $$$$$   $$$$$     $$$$$$               ',
            \ '       $$$$$$$$$$$$$$$$$$$  $$$$             $$$  $$$$       $$$$      $$$$        $$$$ $$$$         $$$$               ',
            \ '       $$                   $$$$    $$$$$$$$$$$$  $$$$       $$$$      $$$         $$$$ $$$          $$$$               ',
            \ '       $$                   $$$$  $$$$$$     $$$  $$$$       $$$$      $$$         $$$$ $$$          $$$$               ',
            \ '       $$                  $$$$$ $$$$        $$$  $$$$       $$$$      $$$$        $$$$ $$$$         $$$$               ',
            \ '       $$         $$     $$$$$$  $$$$       $$$$  $$$$       $$$$       $$$$      $$$$   $$$$       $$$$$               ',
            \ '       $$         $$$$$$$$$$$$   $$$$$$$$$$$$$$$  $$$$       $$$$       $$$$$$$$$$$$$     $$$$$$$$$$$$$$$               ',
            \ '       $$         $$$$$$$$$$       $$$$$$$$  $$$  $$$$       $$$$          $$$$$$$$         $$$$$$$  $$$$               ',
            \ '       $$    $                                                                                                          ',
            \ '       $$    $$                                                                                                         ',
            \ '       $$    $$$                                                                                                        ',
            \ '       $$$$$$$$$$                                                                                                       ',
            \ '       $$$$$$$$$$$                                                                                                      ',
            \ '       $$$$$$$$$$   ===========                                                                                         ',
            \ '             $$$                                                                                                        ',
            \ '             $$                                                                                                         ',
            \ '             $                                                                                                          ',
            \ '',
            \]

" List recently used files using viminfo.
let g:startify_show_files = 1
" The number of files to list.
let g:startify_show_files_number = 10
" A list of files to bookmark. Always shown
let g:startify_bookmarks = [ '~/.vimrc' ]

"-----------------------------------------------------------------------------------
" Rainbow Parentheses settings
"-----------------------------------------------------------------------------------
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

" }

" Misc Functions {

function! RenewTagsFile()
    exe 'silent !rm -rf .ctags'
    exe 'silent !coffeetags --include-vars -Rf .ctags'
    exe 'silent !ctags -a -Rf .ctags --languages=python --python-kinds=-iv --exclude=build --exclude=dist ' . system('python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"')''
    exe 'silent !ctags -a -Rf .ctags --extra=+f --exclude=.git --languages=python --python-kinds=-iv --exclude=build --exclude=dist 2>/dev/null'
    exe 'redraw!'
endfunction

function! CopyFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        redraw!
    endif
endfunction

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" }
