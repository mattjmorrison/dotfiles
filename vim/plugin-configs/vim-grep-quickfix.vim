"===============================================================================
" Plugin source
"===============================================================================
"~/dotfiles/vim/my-plugins/vim-grep-quickfix", {'type': 'nosync'}

"===============================================================================
" Plugin Configurations
"===============================================================================
" N/A

"===============================================================================
" Plugin Keymappings
"===============================================================================
" Defined in the plugin file itself

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Grep in Quickfix buffer                                       <Leader>g', 'echo "Use <Leader>g to grep within the Quickfix buffer"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Restore the Quickfix buffer                                   <Leader>r', 'echo "Use <Leader>r to restore the Quickfix buffer"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Reverse Grep in Quickfix buffer                               <Leader>v', 'echo "Use <Leader>v to reverse grep within the Quickfix buffer"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Reverse Grep Line Under Cursor in Quickfix buffer             <Leader>d', 'echo "Use <Leader>d to reverse grep the Line Under the Cursor in Quickfix buffer"']]
