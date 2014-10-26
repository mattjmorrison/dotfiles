"===============================================================================
" Plugin source
"===============================================================================
"Yggdroot/indentLine"

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:indentLine_enabled = 0
let g:indentLine_char = '¦' "'┊'
let g:indentLine_color_term = 239
let g:indentLine_bufNameExclude = ['_.*', 'start*']
let g:indentLine_fileTypeExclude = ['text']

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>ig :IndentLinesToggle<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += ['➤ Toggle indentation guildes                                   9ig', 'normal 9ig']
