"===============================================================================
" Plugin source
"===============================================================================
"'Shougo/neocomplete.vim'

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:neocomplete#enable_at_startup = 1
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#auto_completion_start_length = 99
let g:neocomplete#enable_smart_case = 1
" This refresh may be too heavy weight!!
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#max_list = 30
" let g:neocomplete#min_keyword_length = 1
" let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#data_directory = $HOME.'/.vim/tmp/neocomplete'
" Disable the auto select feature by default
let g:neocomplete#enable_auto_select = 0

" To make compatible with jedi
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
    let g:neocomplete#sources#omni#input_patterns.python='[^. \t]\.\w*'
endif

set completeopt-=preview

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

"===============================================================================
" Plugin Keymappings
"===============================================================================
" N/A

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
" N/A
