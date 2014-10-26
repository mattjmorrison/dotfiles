"===============================================================================
" Plugin source
"===============================================================================
"JarrodCTaylor/vim-shell-executor"

"===============================================================================
" Plugin Configurations
"===============================================================================
" N/A

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>eb :ExecuteBuffer<CR>
vnoremap <Leader>es :ExecuteSelection<CR>
"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += ['➤ Execute current buffer                                       9eb', 'ExecuteBuffer']
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += ['➤ Execute surrent selection                                    9es', 'ExecuteSelection']
