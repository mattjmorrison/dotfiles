"===============================================================================
" Plugin source
"===============================================================================
"'SirVer/ultisnips'

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<space><tab>"
let g:UltiSnipsJumpForwardTrigger="<space><tab>"
let g:UltiSnipsEditSplit="vertical"

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>ue :UltiSnipsEdit<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Edit UltiSnips snippet file                                   <Leader>ue', ':UltiSnipsEdit']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Display snippet list                                          <Leader><Tab>', 'echo "Use <Leader><Tab> to display available snippets"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Jump to next UltiSnip edit point                              <Leader><Tab>', 'echo "Use <Leader><Tab> to jump to the next editable snippet segment"']]
