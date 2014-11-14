"===============================================================================
" Plugin source
"===============================================================================
"vim-scripts/UltiSnips"

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="9<Tab>"
let g:UltiSnipsJumpForwardTrigger="9<Tab>"
let g:UltiSnipsEditSplit="vertical"

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap 9ue :UltiSnipsEdit<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Edit UltiSnips snippet file                                   9ue', 'normal 9ue']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Trigger UltiSnip snippet expansion                            9<Tab>', 'echo "Use 9<Tab> to expand a snippet"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Jump to next UltiSnip edit point                              9<Tab>', 'echo "Use 9<Tab> to jump to the next editable snippet segment"']]
