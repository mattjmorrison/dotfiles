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
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Grep in Quickfix buffer                                       9g', 'echo "Use 9g to grep within the Quickfix buffer"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Restore the Quickfix buffer                                   9r', 'echo "Use 9r to restore the Quickfix buffer"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Reverse Grep in Quickfix buffer                               9v', 'echo "Use 9v to reverse grep within the Quickfix buffer"']]
