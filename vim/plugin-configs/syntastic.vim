"===============================================================================
" Plugin source
"===============================================================================
"'scrooloose/syntastic'

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:syntastic_check_on_open=1                   " check for errors when file is loaded
let g:syntastic_loc_list_height=5                 " the height of the error list defaults to 10
let g:syntastic_python_checkers = ['flake8']      " sets flake8 as the default for checking python files
let g:syntastic_javascript_checkers = ['jshint']  " sets jshint as our javascript linter
" Disable syntastic in html files because it pretty well blows there
let g:syntastic_mode_map={ 'mode': 'active',
                         \ 'active_filetypes': [],
                         \ 'passive_filetypes': ['html', 'handlebars'] }

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>tl :SyntasticToggleMode<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Toggle Linting                                                <Leader>tl', 'SyntasticToggleMode']]
