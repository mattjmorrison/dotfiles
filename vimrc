" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker:

"===================================================================================
"  DESCRIPTION:  ”I’m sorry, Jarrod, I’m afraid I cant do that.” – VIM
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

" Set nocompatible {{{1
"-----------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings. This must be first, because it changes
" other options as a side effect.
"-----------------------------------------------------------------------------------
set nocompatible
" }}}1

" NeoBundle auto-installation and setup {{{1
" Install and configure NeoBundle {{{2
let iCanHazNeoBundle=1
let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    echo "Installing NeoBundle.."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    let iCanHazNeoBundle=0
endif

" Call NeoBundle
if has('vim_starting')
    set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand($HOME.'/.vim/bundle/'))

" NeoBundle rules NeoBundle (needed!)
NeoBundle 'Shougo/neobundle.vim'
" }}}2
" Bundles {{{2
" Vimproc to asynchronously run commands (NeoBundle, Unite)
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/unite.vim'
" Unite sources
NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload': {'unite_sources': 'colorscheme'}}
NeoBundleLazy 'ujihisa/unite-locate', {'autoload': {'unite_sources': 'locate'}}
NeoBundleLazy 'osyo-manga/unite-fold', {'autoload': {'unite_sources': 'fold'}}
NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources': ['file_mru', 'directory_mru']}}
NeoBundle 'majkinetor/unite-cmdmatch'
NeoBundle 'kopischke/unite-spell-suggest'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'JarrodCTaylor/vim-256-color-schemes'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'ervandew/supertab'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/UltiSnips'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'tmhedberg/SimpylFold'
NeoBundle 'JarrodCTaylor/vim-python-test-runner'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bling/vim-airline'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'nelstrom/vim-markdown-folding'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'JarrodCTaylor/vim-shell-executor'
NeoBundle 'https://github.com/mattn/emmet-vim/'
NeoBundle 'junegunn/vim-easy-align'
" tern requires you to do a npm install
NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'JarrodCTaylor/vim-qunit-special-blend'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'JarrodCTaylor/vim-js2coffee'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'groenewege/vim-less'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'wellle/targets.vim'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle '~/dotfiles/vim/my-plugins/nerd-ack', {'type': 'nosync'}
NeoBundle '~/dotfiles/vim/my-plugins/tmux-navigator', {'type': 'nosync'}
NeoBundle '~/dotfiles/vim/my-plugins/vim-ack', {'type': 'nosync'}
NeoBundle '~/dotfiles/vim/my-plugins/vim-grep-quickfix', {'type': 'nosync'}
NeoBundle '~/dotfiles/vim/my-plugins/vim-wiki-links', {'type': 'nosync'}
" }}}2
" Auto install the plugins {{{2

" First-time plugins installation
if iCanHazNeoBundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :NeoBundleInstall
endif

" Check if all of the plugins are already installed, in other case ask if we want to install them
NeoBundleCheck
" }}}2
" }}}1

" General Settings {{{1
" File Type Detection {{{2
"-----------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Load indent files, to automatically do language-dependent indenting.
"-----------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
" }}}2
" Color scheme {{{2
"-----------------------------------------------------------------------------------
if has("gui_running")
    colorscheme desert
    set guifont=Monospace\ 12
    set antialias
    set guioptions=
else
    set t_Co=256
    colorscheme harlem-nights
endif
" }}}2
" Switch syntax highlighting on. {{{2
"-----------------------------------------------------------------------------------
syntax on
" }}}2
" Various settings {{{2
"-----------------------------------------------------------------------------------
set autoindent                         " Copy indent from current line
set autoread                           " Read open files again when changed outside Vim
set autowrite                          " Write a modified buffer on each :next , ...
set backspace=indent,eol,start         " Backspacing over everything in insert mode
set history=200                        " Keep 200 lines of command line history
set incsearch                          " Do incremental searching
set ignorecase                         " Ignore case when searching....
set smartcase                          " ...unless uppercase letter are used
set hlsearch                           " Highlight the last used search pattern
set list                               " Toggle manually with set list / set nolist or set list!
set listchars=""                       " Empty the listchars
set listchars=tab:>.                   " A tab will be displayed as >...
"set listchars+=trail:.                 " Trailing white spaces will be displayed as .
set mouse=a                            " Enable the use of the mouse
set nobackup                           " Don't constantly write backup files
set noswapfile                         " Ain't nobody got time for swap files
set noerrorbells                       " Don't beep
set nowrap                             " Do not wrap lines
set showbreak=↪\                       " Character to precede line wraps for the times I turn it on
set popt=left:8pc,right:3pc            " Print options
set shiftwidth=4                       " Number of spaces to use for each step of indent
set showcmd                            " Display incomplete commands in the bottom line of the screen
set tabstop=4                          " Number of spaces that a <Tab> counts for
set expandtab                          " Make vim use spaces and not tabs
set undolevels=1000                    " Never can be too careful when it comes to undoing
set hidden                             " Don't unload the buffer when we switch between them. Saves undo history
set visualbell                         " Visual bell instead of beeping
set wildignore=*.swp,*.bak,*.pyc,*.class,node_modules/**  " wildmenu: ignore these extensions
set wildmenu                           " Command-line completion in an enhanced mode
set shell=bash                         " Required to let zsh know how to run things on command line
set ttimeoutlen=50                     " Fix delay when escaping from insert with Esc
"set iskeyword-=_                       " Make underscores keyword boundaries
set noshowmode                         " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set synmaxcol=256                      " Don't syntax highlight long lines
" }}}2
" Turn off the toolbar that is under the menu in gvim {{{2
"-----------------------------------------------------------------------------------
set guioptions-=T
" }}}2
" Treat JSON files like JavaScript {{{2
"-----------------------------------------------------------------------------------
au BufNewFile,BufRead *.json set ft=javascript
" }}}2
" Make pasting done without any indentation break {{{2
"-----------------------------------------------------------------------------------
set pastetoggle=<F3>
" }}}2
" Last cursor position {{{2
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
" }}}2
" Abbreviations {{{2
"-----------------------------------------------------------------------------------
:iabbr teh the
:iabbr condole console
" }}}2
" Make arrowkey resize viewports {{{2
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>
" }}}2
" }}}1

" My pimped out status line {{{1

set laststatus=2                                    " Make the second to last line of vim our status line
let g:airline_theme='understated'                   " Use the custom theme I wrote
let g:airline_left_sep=''                           " No separator as they seem to look funky
let g:airline_right_sep=''                          " No separator as they seem to look funky
let g:airline#extensions#branch#enabled = 0         " Do not show the git branch in the status line
let g:airline#extensions#syntastic#enabled = 1      " Do show syntastic warnings in the status line
let g:airline#extensions#tabline#show_buffers = 0   " Do not list buffers in the status line
let g:airline_section_b = ''                        " Do not show git hunks or branch
let g:airline_section_x = ''                        " Do not list the filetype or virtualenv in the status line
let g:airline_section_y = '[TYPE=%Y] [Format=%{&ff}] [ASCII=%03.3b] [HEX=%02.2B] [R%04l,C%04v] [LEN=%L]'  " Replace file encoding and file format info with file position
"let g:airline_section_y = '[R%04l,C%04v] [LEN=%L]'  " Replace file encoding and file format info with file position
let g:airline_section_z = ''                        " Do not show the default file position info
" }}}1

" Key mapings {{{1
" Notes {{{2
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
" }}}2
" Key mappings {{{2
let mapleader="9"
let maplocalleader= '|'
map ss :setlocal spell!<CR>
map Y y$
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>no :NERDTreeFind<CR>
nnoremap <Leader>tb :TagbarToggle<CR>
nnoremap <Leader>\ :vsplit<CR>
nnoremap <Leader>- :split<CR>
nnoremap <Leader>a :Ack!<space>
nnoremap <Leader>ff :CtrlP<CR>
nnoremap <Leader>ts :SyntasticToggleMode<CR>
nnoremap <Space> :nohlsearch<CR>
nnoremap <Leader>rt :call RenewTagsFile()<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <Leader>da :DjangoTestApp<CR>
nnoremap <Leader>df :DjangoTestFile<CR>
nnoremap <Leader>dc :DjangoTestClass<CR>
nnoremap <Leader>dm :DjangoTestMethod<CR>
nnoremap <Leader>nf :NosetestFile<CR>
nnoremap <Leader>nc :NosetestClass<CR>
nnoremap <Leader>nm :NosetestMethod<CR>
nnoremap <Leader>rr :RerunLastTests<CR>
nnoremap <Leader>tn :set relativenumber!<CR>:set number!<CR>
nnoremap <Leader>ud :GundoToggle<CR>
nnoremap <Leader>tc :call ToggleTodoCheckbox()<CR>
nnoremap <Leader>q :call QuickfixToggle()<CR>
nnoremap <Leader>eb :ExecuteBuffer<CR>
nnoremap <Leader>es :ExecuteSelection<CR>
nnoremap <Leader>ja :RunAllQunitTests<CR>
nnoremap <Leader>jt :RunSingleQunitTest<CR>
nnoremap <Leader>jm :RunSingleQunitModule<CR>
inoremap <Leader>w <Esc>:wa<CR>
nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>
nnoremap <Leader>ev :edit $MYVIMRC<CR>
" --- Shortcuts for quickfix as it was broken for some reason
autocmd BufReadPost quickfix nnoremap <buffer> <CR> :.cc<CR>
autocmd BufReadPost quickfix nnoremap <buffer> o :.cc<CR>
" --- Strip trailing whitespace
nnoremap <Leader>W :%s/\s\+$//<CR>:let @/=''<CR>
" --- Save changes to a readonly file with sudo
cmap w!! w !sudo tee %
" }}}2
" }}}1

" Plugin Configurations {{{1
" Syntastic configurations use :help syntastic.txt {{{2
"-----------------------------------------------------------------------------------
let g:syntastic_check_on_open=1                   " check for errors when file is loaded
let g:syntastic_loc_list_height=5                 " the height of the error list defaults to 10
let g:syntastic_python_checkers = ['flake8']      " sets flake8 as the default for checking python files
let g:syntastic_javascript_checkers = ['jshint']  " sets jshint as our javascript linter
" Ignore line width for syntax checking in python
let g:syntastic_python_flake8_post_args='--ignore=E501'
" Disable syntastic in html files because it pretty well blows there
let g:syntastic_mode_map={ 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['html'] }
let g:syntastic_coffee_coffeelint_args="--csv --file ~/coffeelint.json"
" }}}2
" UltiSnips configurations {{{2
"-----------------------------------------------------------------------------------
let g:UltiSnipsSnippetDirectories=["mySnippets"] " UltiSnips
let g:UltiSnipsExpandTrigger="<Leader><Tab>"
let g:UltiSnipsJumpForwardTrigger="<Leader><Tab>"
" }}}2
" Neocomplete {{{2
"-----------------------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 1
let g:jedi#auto_vim_configuration = 0
" To make compatible with jedi
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.python='[^. \t]\.\w*'
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#auto_completion_start_length = 99
set completeopt-=preview

let g:neocomplete#enable_smart_case = 1
" This refresh may be too heavy weight!!
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#max_list = 30
" let g:neocomplete#min_keyword_length = 1
" let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#data_directory = $HOME.'/.vim/tmp/neocomplete'

" disable the auto select feature by default to speed up writing without obstacles (is optimal for certain situations)
let g:neocomplete#enable_auto_select = 0

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" }}}2
" Exuberant ctags configurations {{{2
"-----------------------------------------------------------------------------------
" Vim will look for a ctags file in the current directory and continue
" up the file path until it finds one
"-----------------------------------------------------------------------------------
" Enable ctags support
set tags=./.ctags,.ctags;
" }}}2
" NERDTree configurations {{{2
"-----------------------------------------------------------------------------------
" Make NERDTree ignore .pyc files
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpPrevSibling = ''
" }}}2
" Jedi configurations {{{2
"-----------------------------------------------------------------------------------
let g:jedi#goto_definitions_command = "<Leader>gt"
let g:jedi#use_tabs_not_buffers = 0     " Use buffers not tabs
let g:jedi#popup_on_dot = 0
" }}}2
" Startify configurations {{{2
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
" }}}2
" SuperTab {{{2
"-----------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"
" }}}2
" Gundo {{{2
"-----------------------------------------------------------------------------------
let g:gundo_preview_bottom = 1
" }}}2
" Vim-Markdown-Folding {{{2
"-----------------------------------------------------------------------------------
let g:markdown_fold_style = 'nested'
" }}}2
" Vim-Markdown {{{2
"-----------------------------------------------------------------------------------
 let g:markdown_fenced_languages = ['python', 'sh', 'vim', 'javascript', 'html', 'clojure', 'css', 'c', 'sql', 'java']
"}}}2
" Vim-sneak {{{2
"-----------------------------------------------------------------------------------
" Replace the default f command
nmap f <Plug>SneakForward
nmap F <Plug>SneakBackward
let g:sneak#streak = 1
" We need 52 characters for this
let g:sneak#target_labels = "sfgkqwetyupzcvbnmSDFGHJKLQWERTYUPZXCVBNM1234567890rx"
"}}}2
" Ctrlp configurations {{{2
"-----------------------------------------------------------------------------------
let g:ctrlp_custom_ignore = 'node_modules$\|xmlrunner$\|.DS_Store|.git|.bak|.swp|.pyc'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 18
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }
func! MyCtrlPMappings()
    nnoremap <buffer> <silent> <F6> :call <sid>DeleteBuffer()<cr>
endfunc
" }}}2
" Emmet Vim {{{2
"-----------------------------------------------------------------------------------
" Enable just in html files
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key=','
autocmd FileType html,htmldjango,handlebars EmmetInstall
"}}}2
" Easy Align {{{2
"-----------------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
"}}}2
" Handlebars {{{2
"-----------------------------------------------------------------------------------
" Enable handlebars shortcuts
let g:mustache_abbreviations = 1
" }}}2
" Indent Lines {{{2
"-------------------------------------------------------------------------
nnoremap <Leader>ig :IndentLinesToggle<CR>
let g:indentLine_enabled = 0
let g:indentLine_char = '¦' "'┊'
let g:indentLine_color_term = 239
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'start*']
let g:indentLine_fileTypeExclude = ['text']
" }}}2
" Rainbow Parentheses settings {{{2
"-------------------------------------------------------------------------
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
    \ ['darkred',     'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['red',         'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
augroup rainbow_parentheses
  au!
  au BufEnter *.clj RainbowParenthesesActivate
  au BufEnter *.clj RainbowParenthesesLoadRound
  au BufEnter *.clj RainbowParenthesesLoadSquare
  au BufEnter *.clj RainbowParenthesesLoadBraces
augroup END
" }}}2
" Unite {{{2
"-------------------------------------------------------------------------
" Unite global variables and general settings {{{3
let g:unite_enable_start_insert = 1
let g:unite_split_rule = 'botright'
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 15
let g:unite_source_history_yank_enable = 1
let g:unite_prompt = '──➤  '
let g:unite_update_time = 200
let g:unite_source_file_rec_max_cache_files = 0
let g:unite_data_directory = $HOME.'/.vim/tmp/unite'
let g:unite_source_buffer_time_format = '(%m-%d-%Y %H:%M:%S) '
let g:unite_source_file_mru_time_format = '(%m-%d-%Y %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%m-%d-%Y %H:%M:%S) '
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.DS_Store/', 
      \ 'node_modules/', 
      \ '\.git/', 
      \ '\.bak', 
      \ '\.swp', 
      \ '\.pyc',
      \ ], '\|'))
" }}}3
" Unite autocmd FileType settings {{{3
autocmd FileType unite call s:unite_buffer_settings()

function! s:unite_buffer_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
" }}}3
" Unite Key Mappings {{{3
nnoremap <Leader>b :Unite buffer<CR>
nnoremap <Leader>m :Unite file_mru<CR>
" filter buffer for search term
nnoremap <Leader>sb :Unite line<CR>
nnoremap <Leader>* :UniteWithCursorWord line<CR>
nnoremap <Leader>y :Unite history/yank<CR>
nnoremap <Leader>sf :Unite fold<CR>
nnoremap <Leader>sj :Unite jump<CR>
nnoremap <Leader>sp ]s :Unite spell_suggest<CR>
nnoremap <LocalLeader>c :Unite colorscheme -auto-preview<CR>
" }}}3
" Unite Menus {{{3
let g:unite_source_menu_menus = {}
nnoremap [menu] <Nop>
" menu prefix key (for all Unite menus)
nmap <LocalLeader> [menu]

" Menus {{{4
nnoremap <silent>[menu]u :Unite -silent -winheight=20 menu<CR>
" }}}4
" Files and Buffers {{{4
let g:unite_source_menu_menus.Files = {'description': 'Find and switch files and buffers                  |f'}
let g:unite_source_menu_menus.Files.command_candidates = [
    \['➤ Find files,                                                 9ff', 'normal 9ff'],
    \['➤ Buffer list                                                  9b', 'Unite buffer'],
    \['➤ Most recently used files                                     9m', 'Unite file_mru'],
    \['➤ Save as root                                               :w!!', 'exe "write !sudo tee % >/dev/null"'],
    \]
nnoremap <silent>[menu]f :Unite -silent -winheight=17 -start-insert menu:Files<CR>
" }}}4
" Windows {{{4
let g:unite_source_menu_menus.Windows = {'description': 'creation and management                          |w'}
let g:unite_source_menu_menus.Windows.command_candidates = [
    \['➤ Toggle quickfix                                              9q', 'call QuickfixToggle()'],
    \['➤ Resize windows                                       Arrow keys', 'echo "Use the arrow keys to resize windows"'],
    \['➤ New vertical split                                           9|', 'vsplit'],
    \['➤ New horizontal window                                        9-', 'split'],
    \]
nnoremap <silent>[menu]w :Unite -silent menu:Windows<CR>
" }}}4
" Searching and Finding {{{4
let g:unite_source_menu_menus.Searching = {'description': 'buffers, words, folds, yanks, jumps            |se'}
let g:unite_source_menu_menus.Searching.command_candidates = [
    \['➤ Search lines in the current buffer                         9sb', 'Unite line'],
    \['➤ Search word under the cursor in current file                9*', 'UniteWithCursorWord line'],
    \['➤ Yanks                                                       9y', 'Unite history/yank'],
    \['➤ Search folds                                               9sf', 'Unite fold'],
    \['➤ Search jumps                                               9sj', 'Unite jump'],
    \]
nnoremap <silent>[menu]sp :Unite -silent menu:Searching<CR>
" }}}4
" Misc editor shortcuts {{{4
let g:unite_source_menu_menus.Misc = {'description': 'Editor Shortcuts                                    |m'}
let g:unite_source_menu_menus.Misc.command_candidates = [
    \['➤ undo tree      (gundo)                                     9ud', 'GundoToggle'],
    \['➤ Turn off search highlighting                             space', 'nohlsearch'],
    \['➤ Toggle line numbers                                        9tn', 'normal 9tn'],
    \['➤ Enter paste mode [Exit with Esc]                            yp', 'normal yp'],
    \['➤ Remove trailing whitespaces                                 9W', 'normal 9W'],
    \['➤ Show current char info                                      ga', 'normal ga'],
    \['➤ choose colorscheme                                          |c', 'Unite colorscheme -auto-preview'],
    \['➤ Edit configuration file (vimrc)                            9ev', 'edit $MYVIMRC'],
    \['➤ Toggle NERDTree                                            9nt', 'NERDTreeToggle'],
    \['➤ Open NERDTree focused in current directory                 9no', 'NERDTreeFind'],
    \['➤ Toggle Tagbar                                              9tb', 'TagbarToggle'],
    \['➤ Ack                                                         9a', 'echo "User 9a to start the Ack prompt"'],
    \['➤ Toggle Syntastic                                           9ts', 'SyntasticToggleMode'],
    \['➤ Refresh Ctags                                              9rt', 'call RenewTagsFile()'],
    \['➤ Execute Current Buffer                                     9eb', 'ExecuteBuffer'],
    \['➤ Execute Current Selection                                  9es', 'ExecuteSelection'],
    \['➤ Exit insert mode and write all files                        9w', 'echo use 9w'],
    \['➤ Visual find and replace over full file                     9fr', 'call VisualFindAndReplace()'],
    \['➤ Visual find and replace over current visual selection      9fr', 'call VisualFindAndReplaceWithSelection()']
    \]
nnoremap <silent>[menu]m :Unite -silent menu:Misc<CR>
" }}}4
" Running tests {{{4
let g:unite_source_menu_menus.Tests = {'description': 'Running tests                                      |t'}
let g:unite_source_menu_menus.Tests.command_candidates = [
    \['➤ Test Django Method                                         9dm', 'normal 9dm'],
    \['➤ Test Django Class                                          9dc', 'normal 9dc'],
    \['➤ Test Django File                                           9df', 'normal 9df'],
    \['➤ Test Django App                                            9da', 'normal 9da'],
    \['➤ Test Python Method with Nose                               9nm', 'normal 9nm'],
    \['➤ Test Python Class with Nose                                9nc', 'normal 9nc'],
    \['➤ Test Python File with Nose                                 9nf', 'normal 9nf'],
    \['➤ Rerun Last Python Test                                     9rr', 'RerunLastTests'],
    \['➤ Test JavaScript Single Test (Qunit)                        9jt', 'normal 9jt'],
    \['➤ Test JavaScript Single Method (Qunit)                      9jm', 'normal 9jm'],
    \['➤ Run All JavaScript Tests (Qunit)                           9ja', 'normal 9ja'],
    \]
nnoremap <silent>[menu]s :Unite -silent menu:Tests<CR>
" }}}4
" Spelling {{{4
let g:unite_source_menu_menus.Spelling = {'description': 'Spell checking shortcuts                        |sp'}
let g:unite_source_menu_menus.Spelling.command_candidates = [
    \['➤ Turn on spell checking                                      ss', 'setlocal spell!'],
    \['➤ Turn off spell checking                                     ss', 'setlocal spell!'],
    \['➤ Jumps to next spelling error and show suggestions          9sp', 'normal 9sp'],
    \['➤ Jumps to next bad spell word                                ]s', 'normal ]s'],
    \['➤ Suggestions                                                 z=', 'normal z='],
    \]
nnoremap <silent>[menu]sp :Unite -silent menu:Spelling<CR>
" }}}3
" }}}2
" }}}1

" Misc Functions {{{1
" DeleteBuffer {{{2
"-----------------------------------------------------------------------------------
" Custom function to delete buffers from within Ctrl-P
function! s:DeleteBuffer()
    let line = getline('.')
    let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
    exec "bd" bufid
    exec "norm \<F5>"
endfunction
"}}}2
" Renewtagsfile {{{2
"-----------------------------------------------------------------------------------
function! RenewTagsFile()
    exe 'silent !rm -rf .ctags'
    exe 'silent !coffeetags --include-vars -Rf .ctags'
    exe 'silent !ctags -a -Rf .ctags --languages=python --python-kinds=-iv --exclude=build --exclude=dist ' . system('python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"')''
    exe 'silent !ctags -a -Rf .ctags --extra=+f --exclude=.git --languages=python --python-kinds=-iv --exclude=build --exclude=dist 2>/dev/null'
    exe 'redraw!'
endfunction
" }}}2
" Highlight matches when jumping to next {{{2
"-----------------------------------------------------------------------------------
" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

function! HLNext (blinktime)
    highlight HighlightStyle ctermfg=none ctermbg=160 cterm=none
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('HighlightStyle', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
    call matchdelete(ring)
    redraw
endfunction
" }}}2
" Custom Fold Text{{{2
"-----------------------------------------------------------------------------------
function! CustomFoldText()
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif
    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage
    " Add fold level indication at the end of the line
    "let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    "return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
set foldtext=CustomFoldText()
" }}}2
" Nohassle Paste {{{2
"-----------------------------------------------------------------------------------
" Code totally boosted from Tim Pope
function! s:setup_paste() abort
  let s:paste = &paste
  set paste
endfunction

nnoremap <silent> <Plug>unimpairedPaste :call <SID>setup_paste()<CR>
nnoremap <silent> yp  :call <SID>setup_paste()<CR>a
nnoremap <silent> yP  :call <SID>setup_paste()<CR>i
nnoremap <silent> yo  :call <SID>setup_paste()<CR>o
nnoremap <silent> yO  :call <SID>setup_paste()<CR>O
nnoremap <silent> yA  :call <SID>setup_paste()<CR>A
nnoremap <silent> yI  :call <SID>setup_paste()<CR>I

augroup unimpaired_paste
  autocmd!
  autocmd InsertLeave *
        \ if exists('s:paste') |
        \   let &paste = s:paste |
        \   unlet s:paste |
        \ endif
augroup END
" }}}2
" Increment a column of number {{{2
"-----------------------------------------------------------------------------------
function! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction

vnoremap <C-a> :call Incr()<CR>
" }}}2
" Toggle checkboxs {{{2
"-----------------------------------------------------------------------------------
function! ToggleTodoCheckbox()
        let line = getline('.')
        if(match(line, "\\[ \\]") != -1)
          let line = substitute(line, "\\[ \\]", "[√]", "")
          let line = substitute(line, "$", " @done (" . strftime("%m/%d/%y %H:%M") . ")", "")
        elseif(match(line, "\\[√\\]") != -1)
          let line = substitute(line, "\\[√\\]", "[ ]", "")
          let line = substitute(line, " @done.*$", "", "")
        endif
        call setline('.', line)
endfunction
" }}}2
" Toggle Quickfix {{{2
"-----------------------------------------------------------------------------------
let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}2
" Format JSON {{{2
"-----------------------------------------------------------------------------------
function! FormatJSON()
    :'<,'>!python -m json.tool
endfunction
command! -range FormatJSON call FormatJSON()
" }}}2
" Visual Find and Replace {{{2
"-----------------------------------------------------------------------------------
function! VisualFindAndReplace()
    :OverCommandLine%s/
    :w
endfunction
" }}}2
" Visual Find and Replace With Selection {{{2
"-----------------------------------------------------------------------------------
function! VisualFindAndReplaceWithSelection() range
    :'<,'>OverCommandLine s/
    :w
endfunction
" Doesn't replace buffer contents when pasting {{{2
"-----------------------------------------------------------------------------------
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
" }}}2
" Toggle the auto select feature {{{2
"-----------------------------------------------------------------------------------
function! ToggleNeoComplete()
  if !g:neocomplete#disable_auto_complete && g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 0
      let g:neocomplete#enable_auto_select = 0
  elseif !g:neocomplete#disable_auto_complete && !g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 1
      let g:neocomplete#enable_auto_select = 0
  elseif g:neocomplete#disable_auto_complete && !g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 0
      let g:neocomplete#enable_auto_select = 1
  endif
endfunction
nnoremap <silent><Leader>ea :call ToggleNeoComplete()<CR>
" }}}2
" }}}1
