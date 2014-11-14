"===============================================================================
" Plugin source
"===============================================================================
"takac/vim-hardtime"

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:hardtime_ignore_buffer_patterns = [".*markdown", ".*md"]
let g:hardtime_maxcount = 4
let g:hardtime_ignore_quickfix = 1
let g:hardtime_default_on = 1

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>th :HardTimeToggle<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Toggle hard mode                                              <Leader>th', 'normal <Leader>th']]
