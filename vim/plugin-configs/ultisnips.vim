"===============================================================================
" Plugin source
"===============================================================================
"'SirVer/ultisnips'

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom-snips"]
let g:UltiSnipsJumpForwardTrigger="9<Tab>"
let g:UltiSnipsEditSplit="vertical"

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap 9ue :UltiSnipsEdit<CR>

function! UltiSnipsCallUnite()
  Unite -start-insert -winheight=100 -immediately -no-empty ultisnips
  return ''
endfunction

inoremap 9<Tab> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
nnoremap 9<Tab> a<C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Edit UltiSnips snippet file                                   9ue', 'normal 9ue']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Display snippet list                                          9<Tab>', 'echo "Use 9<Tab> to display available snippets"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Jump to next UltiSnip edit point                              9<Tab>', 'echo "Use 9<Tab> to jump to the next editable snippet segment"']]
