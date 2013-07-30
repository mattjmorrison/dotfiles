"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  An ever changing work in progress
"       AUTHOR:  Jarrod Taylor
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
 Bundle 'https://github.com/Shougo/neocomplcache.vim'
 Bundle 'https://github.com/vim-scripts/bash-support.vim'
 Bundle 'https://github.com/skammer/vim-css-color'
 Bundle 'https://github.com/Raimondi/delimitMate'
 Bundle 'https://github.com/vim-scripts/L9'
 Bundle 'https://github.com/scrooloose/nerdtree'
 Bundle 'https://github.com/JarrodCTaylor/vim-color-menu'
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
 Bundle 'https://github.com/alfredodeza/pytest.vim'
 Bundle 'https://github.com/jmcantrell/vim-virtualenv'
 Bundle 'https://github.com/mhinz/vim-startify'
 Bundle 'https://github.com/tmhedberg/SimpylFold'
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
set listchars=""                       " Empty the listchars
set listchars=tab:>.                   " A tab will be displayed as >...
set listchars+=trail:.                 " Trailing white spaces will be displayed as .
set mouse=a                            " enable the use of the mouse
set nobackup                           " don't constantly write backup files
set noswapfile                         " ain't nobody got time for swap files
set noerrorbells                       " don't beep
set nowrap                             " do not wrap lines
set popt=left:8pc,right:3pc            " print options
"set ruler                             " shows the cursor position all the time I have a custom status line for this
set shiftwidth=4                       " number of spaces to use for each step of indent
set showcmd                            " display incomplete commands in the bottom line of the screen
set smartcase                          " ignore case if search pattern is all lowercase, case_sensitive otherwise
"set smartindent                        " smart autoindenting when starting a new line
set tabstop=4                          " number of spaces that a <Tab> counts for
set expandtab                          " Make vim use spaces and not tabs
set undolevels=1000                    " never can be too careful when it comes to undoing
set visualbell                         " visual bell instead of beeping
set wildignore=*.swp,*.bak,*.pyc,*.class,node_modules/**  " wildmenu: ignore these extensions
set wildmenu                           " command-line completion in an enhanced mode
set shell=bash                         " Required to let zsh know how to run things on command line 
"
"-----------------------------------------------------------------------------------
" My pimped out status line
"-----------------------------------------------------------------------------------
set laststatus=2                " Make the second to last line of vim our status line
set statusline=%F                            " File path
set statusline+=%m%r%h%w                     " Flags
" set statusline+=\ %{fugitive#statusline()}   " Git branch
" set statusline+=\ [FORMAT=%{&ff}]            " File format
set statusline+=\ [TYPE=%Y]                  " File type
" set statusline+=\ [ASCII=\%03.3b]            " ASCII value of character under cursor
" set statusline+=\ [HEX=\%02.2B]              " HEX value of character under cursor
set statusline+=%=                           " Right align the rest of the status line
set statusline+=\ [R%04l,C%04v]              " Cursor position in the file row, column
" set statusline+=\ [%p%%]                     " Percentage of the file the active line is
set statusline+=\ [LEN=%L]                   " Number of line in the file
set statusline+=%#warningmsg#                " Highlights the syntastic errors in red
set statusline+=%{SyntasticStatuslineFlag()} " Adds the line number and error count
set statusline+=%*                           " Fill the width of the vim window
"
"-----------------------------------------------------------------------------------
" Change the background color of the status line based on the mode. 
" Insert mode = Green, Replace = Purple, command = Gray
"-----------------------------------------------------------------------------------
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Green ctermfg=34 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=124 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
"
"-----------------------------------------------------------------------------------
" Turn off the toolbar that is under the menu in gvim
"-----------------------------------------------------------------------------------
set guioptions-=T
"

"-----------------------------------------------------------------------------------
" Treat JSON files like JavaScript
"-----------------------------------------------------------------------------------
au BufNewFile,BufRead *.json set ft=javascript

"-----------------------------------------------------------------------------------
" Make pasting done without any indentation break
"-----------------------------------------------------------------------------------
set pastetoggle=<F3>

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
" --- open CtrlP buffer explorer
nnoremap <leader>b :CtrlPBuffer<CR>
" --- open Ctrlp as a fuzzy finder
nnoremap <leader>ff :CtrlP<CR>
" --- Better window navigation E.g. now use Ctrl+j instead of Ctrl+W+j
nnoremap <C-j> <C-w>j  
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" --- Split the window vertically
nnoremap <leader>\ :vsplit<CR>
" --- Split the window horizontally
nnoremap <leader>- :split<CR>
" --- Ack short cut
nnoremap <leader>a :Ack!<space>
" --- Toggle Syntastic
nnoremap <leader>ts :SyntasticToggleMode<CR>
" --- Clear the search buffer and highlighted text with enter press
:nnoremap <CR> :nohlsearch<cr>
" --- Search the ctags index file for anything by class or method name
map <leader>fs :CtrlPTag<CR>
" --- Re-index the ctags file
nnoremap <leader>ri :call RenewTagsFile()<cr>
" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <leader>yp :let @" = expand("%:p")"<cr>:echo "Copied file path to clipboard"<cr>
" Copy current filename to system clipboard
nnoremap <Leader>yf :let @"=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer path without filename to system clipboard
nnoremap <Leader>yd :let @"=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>
" --- Strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
"
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
"-----------------------------------------------------------------------------------
" Syntastic configurations use :help syntastic.txt
"-----------------------------------------------------------------------------------
let g:syntastic_check_on_open=1                   " check for errors when file is loaded
let g:syntastic_loc_list_height=5                 " the height of the error list defaults to 10
let g:syntastic_python_checkers = ['pyflakes']    " sets pyflakes as the default for checking python files
let g:syntastic_javascript_checkers = ['jshint']  " sets jshint as our javascript linter
"
"-----------------------------------------------------------------------------------
" UltiSnips configurations
"-----------------------------------------------------------------------------------
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mySnippets"]
let g:UltiSnipsExpandTrigger='`'
" 
"-----------------------------------------------------------------------------------
" Neocomplcache configurations
"-----------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup=1
" To make compatible with jedi
autocmd FileType python setlocal omnifunc=jedi#complete
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplcache_force_omni_patterns')
      let g:neocomplcache_force_omni_patterns = {}
  endif
let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'
"
"-----------------------------------------------------------------------------------
" Ctrlp configurations
"-----------------------------------------------------------------------------------
let g:ctrlp_custom_ignore = 'node_modules$\|xmlrunner$\|.DS_Store|.git|.bak|.swp|.pyc'
let g:ctrlp_max_height = 18
"
"-----------------------------------------------------------------------------------
" Exuberant ctags configurations
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
let g:jedi#get_definition_command = "<leader>j"
let g:jedi#use_tabs_not_buffers = 0     " Use buffers not tabs

"-----------------------------------------------------------------------------------
" Startify constantly
"-----------------------------------------------------------------------------------
" Highlight the acsii banner with red font
hi StartifyHeader ctermfg=76   
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
            \ '       $$         $$$$$$$$$$       $$$$$$$$  $$$  $$$$       $$$           $$$$$$$$         $$$$$$$  $$$$               ',
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
"===================================================================================
" Misc Functions
"===================================================================================
"
function! RenewTagsFile()
    exe 'silent !rm -rf .ctags'
    exe 'silent !coffeetags --include-vars -Rf .ctags'
    exe 'silent !ctags -a -Rf .ctags --languages=python --python-kinds=-iv --exclude=build --exclude=dist ' . system('python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"')''
    exe 'silent !ctags -a -Rf .ctags --extra=+f --exclude=.git --languages=python --python-kinds=-iv --exclude=build --exclude=dist 2>/dev/null'
    exe 'redraw!'
endfunction
